O0001
(====================================================================)
(  T_FUNC.NC - MACRO DE CAMBIO DE HERRAMIENTA                       )
(  Torreta de 12 posiciones con optimizacion de ruta CW/CCW          )
(  Controlador: ADTECH CNC9620 / FCNC4M                             )
(====================================================================)
(                                                                    )
(  DESCRIPCION GENERAL                                               )
(  Este programa gestiona el cambio automatico de herramienta.       )
(  Secuencia: Validar -> Desclampear -> Girar -> Clampear -> BCD     )
(                                                                    )
(  VARIABLES PRINCIPALES                                             )
(  #200    = Herramienta destino, solicitada por Txx                 )
(  #400    = Numero maximo de herramientas configurado               )
(  #4120   = Herramienta actual, registro del sistema x100           )
(  #201    = Herramienta actual extraida de #4120/100                )
(  #33     = Direccion de giro: +1=CW, -1=CCW                       )
(  #100    = Contador de posicion durante giro                       )
(  #1-#12  = Temporizadores para verificacion BCD                    )
(  #11028  = Selector de idioma: 0=ingles, 1=chino/espanol          )
(                                                                    )
(  ENTRADAS - SENSORES BCD TORRETA                                   )
(  IN5=#1005=TP4, IN6=#1006=TP3, IN7=#1007=TP2, IN8=#1008=TP1      )
(                                                                    )
(  TABLA BCD - CODIGO DE POSICION POR HERRAMIENTA                   )
(  Herr | IN5 | IN6 | IN7 | IN8 | Dec                               )
(  T01  |  1  |  1  |  1  |  0  |  14                               )
(  T02  |  1  |  1  |  0  |  1  |  13                               )
(  T03  |  1  |  1  |  0  |  0  |  12                               )
(  T04  |  1  |  0  |  1  |  1  |  11                               )
(  T05  |  1  |  0  |  1  |  0  |  10                               )
(  T06  |  1  |  0  |  0  |  1  |   9                               )
(  T07  |  1  |  0  |  0  |  0  |   8                               )
(  T08  |  0  |  1  |  1  |  1  |   7                               )
(  T09  |  0  |  1  |  1  |  0  |   6                               )
(  T10  |  0  |  1  |  0  |  1  |   5                               )
(  T11  |  0  |  1  |  0  |  0  |   4                               )
(  T12  |  0  |  0  |  1  |  1  |   3                               )
(                                                                    )
(  SEÑALES DE CONTROL                                                )
(  #1402 = Giro torreta sentido horario CW                           )
(  #1403 = Giro torreta sentido antihorario CCW                      )
(  #1422 = Rele freno torreta: 1=soltar, 0=activar                  )
(  #1423 = Rele clamp torreta: 1=desclampear, 0=clampear            )
(  IN15  = Sensor disco torreta, deteccion de paso                   )
(  IN21  = Sensor estado desclampeo                                  )
(  IN22  = Sensor estado freno                                       )
(  IN23  = Sensor estado clampeo                                     )
(                                                                    )
(  SECUENCIA OPERATIVA                                               )
(  1. Validar herramienta destino y configuracion maxima             )
(  2. Soltar freno y desclampear torreta                             )
(  3. Calcular direccion optima: CW o CCW, la mas corta             )
(  4. Girar posicion a posicion hasta alcanzar destino               )
(  5. Detener giro, clampear torreta y activar freno                 )
(  6. Verificar posicion final con sensores BCD, timeout 8s         )
(                                                                    )
(  TIMEOUTS                                                          )
(  Clamp/unclamp/freno: 5000ms                                      )
(  Verificacion BCD: 8000ms por herramienta                          )
(  M88 = Macro verificacion: P=señal, L=valor, Q=timeout ms         )
(                                                                    )
(  CORRECCIONES VS ORIGINAL T_FUNC 2.NC                              )
(  - Bug corregido: WHILE[#7<=8000] cambiado a WHILE[#8<=8000]      )
(    en verificacion BCD de herramienta 8                            )
(  - Etiquetas N11/N12 duplicadas: renombradas a N90 en seccion     )
(    de direccion para evitar conflicto con BCD T11/T12              )
(  - Todos los comentarios traducidos al espanol                     )
(====================================================================)

(--- SECCION 1: VALIDACION DE HERRAMIENTA ---)
(Si #400=0, no hay torreta configurada: salir)
IF[#400==0] M30
(Si #400 fuera de rango 1-12: alarma)
IF [[#400 <= 0] || [#400>12]]
{
IF [#11028==1] THEN #3000=1(Error: config max herramientas invalida)
IF [#11028==0] THEN #3000=1(Error: max tool setting invalid)
}
(Si herramienta destino #200 fuera de rango 1-#400: alarma)
IF [[#200 > #400] || [#200 <=0 ]]
{
IF [#11028==1] THEN #3000=1(Error: numero de herramienta T invalido)
IF [#11028==0] THEN #3000=1(Error: T tool number out of range)
}

(--- SECCION 2: DESCLAMPEO DE TORRETA ---)
(Sensores BCD: TP4=IN5, TP3=IN6, TP2=IN7, TP1=IN8)
(#200=herramienta destino, #4120=herramienta actual x100)
#1422=1 (Soltar freno)
#1423=1 (Desclampear torreta)
G4X1 (Pausa 1 segundo para estabilizacion)
M88P23L0Q5000 (Verificar desclampeo: señal 23=0, timeout 5s)
M88P21L1Q5000 (Verificar desclampeo: señal 21=1, timeout 5s)
M88P22L1Q5000 (Verificar freno suelto: señal 22=1, timeout 5s)

(--- SECCION 3: CALCULO DE DIRECCION OPTIMA ---)
(Extraer numero de herramienta actual del registro #4120)
(#4120 almacena herramienta x100, ej: T03=#4120=300)
#201=FIX[#4120/100]

(Caso 1: destino > actual Y diferencia <= 6 pos -> CW es mas corto)
IF[[#200>#201]&& [[#200-#201]<=6]]
{
#33=1 (Direccion: sentido horario CW)
#1402=1 (Activar giro CW)
GOTO90 (Saltar al bucle de giro)
}

(Caso 2: destino < actual Y diferencia >= 6 pos -> CW es mas corto)
IF[[#200<#201]&&[[#201-#200]>=6]]
{
#33=1 (Direccion: sentido horario CW)
#1402=1 (Activar giro CW)
GOTO90 (Saltar al bucle de giro)
}

(Caso 3: en cualquier otro caso -> CCW es mas corto)
ELSE
{
#33=-1 (Direccion: sentido antihorario CCW)
#1403=1 (Activar giro CCW)
}

(--- SECCION 4: BUCLE DE GIRO POSICION A POSICION ---)
(Gira la torreta una posicion a la vez hasta alcanzar destino)
(Cada iteracion espera paso por sensor disco IN15)
N90
#100=FIX[#4120/100] (Posicion actual)
WHILE[#200!=#100]DO88
M88P15L1Q5000 (Esperar sensor disco=1: paso detectado)
M88P15L0Q5000 (Esperar sensor disco=0: posicion alcanzada)
#100=#100+#33 (Avanzar contador en direccion de giro)
(Manejo de desbordamiento circular: 12->1 o 1->12)
IF[#100==0]
{
#100=12 (Si paso de 1 hacia atras, volver a 12)
}
IF[#100==13]
{
#100=1 (Si paso de 12 hacia adelante, volver a 1)
}
END88

(--- SECCION 5: CLAMPEO DE TORRETA ---)
(Detener giro y asegurar torreta en posicion)
#1402=0 (Apagar giro horario CW)
#1403=0 (Apagar giro antihorario CCW)
(Pulso de clampeo: secuencia bajo-alto-bajo activa solenoide)
#1423=0 (Pulso clampeo: bajo)
#1423=1 (Pulso clampeo: alto)
#1423=0 (Pulso clampeo: bajo)
G04 P700 (Retardo 700ms para asentamiento mecanico)
#1422=0 (Activar freno)

(Verificar que torreta quedo correctamente clampeada)
M88P23L0Q5000 (Verificar clampeo: señal 23=0, timeout 5s)
M88P21L1Q5000 (Verificar clampeo: señal 21=1, timeout 5s)
M88P22L0Q5000 (Verificar freno activo: señal 22=0, timeout 5s)

(--- SECCION 6: VERIFICACION BCD DE POSICION FINAL ---)
(Cada herramienta tiene un codigo BCD unico en 4 sensores)
(Se verifica con polling cada 10ms, timeout total 8000ms)
(Si no coincide dentro del timeout, el programa termina sin alarma)
(GOTO sale del bucle WHILE al alcanzar la etiqueta N correspondiente)

(Herramienta 1: BCD=1110, IN5=1 IN6=1 IN7=1 IN8=0)
IF[#200==1]
{
#1=0
WHILE[#1<=8000]DO1
IF[ [#1005==1]&&[#1006==1]&&[#1007==1]&&[#1008==0] ]GOTO1
G4P10
#1=#1+10
END1
}
N1

(Herramienta 2: BCD=1101, IN5=1 IN6=1 IN7=0 IN8=1)
IF[#200==2]
{
#2=0
WHILE[#2<=8000]DO2
IF[ [#1005==1]&&[#1006==1]&&[#1007==0]&&[#1008==1] ]GOTO2
G4P10
#2=#2+10
END2
}
N2

(Herramienta 3: BCD=1100, IN5=1 IN6=1 IN7=0 IN8=0)
IF[#200==3]
{
#3=0
WHILE[#3<=8000]DO3
IF[ [#1005==1]&&[#1006==1]&&[#1007==0]&&[#1008==0] ]GOTO3
G4P10
#3=#3+10
END3
}
N3

(Herramienta 4: BCD=1011, IN5=1 IN6=0 IN7=1 IN8=1)
IF[#200==4]
{
#4=0
WHILE[#4<=8000]DO4
IF[ [#1005==1]&&[#1006==0]&&[#1007==1]&&[#1008==1] ]GOTO4
G4P10
#4=#4+10
END4
}
N4

(Herramienta 5: BCD=1010, IN5=1 IN6=0 IN7=1 IN8=0)
IF[#200==5]
{
#5=0
WHILE[#5<=8000]DO5
IF[ [#1005==1]&&[#1006==0]&&[#1007==1]&&[#1008==0] ]GOTO5
G4P10
#5=#5+10
END5
}
N5

(Herramienta 6: BCD=1001, IN5=1 IN6=0 IN7=0 IN8=1)
IF[#200==6]
{
#6=0
WHILE[#6<=8000]DO6
IF[ [#1005==1]&&[#1006==0]&&[#1007==0]&&[#1008==1] ]GOTO6
G4P10
#6=#6+10
END6
}
N6

(Herramienta 7: BCD=1000, IN5=1 IN6=0 IN7=0 IN8=0)
IF[#200==7]
{
#7=0
WHILE[#7<=8000]DO7
IF[ [#1005==1]&&[#1006==0]&&[#1007==0]&&[#1008==0] ]GOTO7
G4P10
#7=#7+10
END7
}
N7

(Herramienta 8: BCD=0111, IN5=0 IN6=1 IN7=1 IN8=1)
(BUG CORREGIDO: original usaba WHILE[#7<=8000], debe ser #8)
IF[#200==8]
{
#8=0
WHILE[#8<=8000]DO8
IF[ [#1005==0]&&[#1006==1]&&[#1007==1]&&[#1008==1] ]GOTO8
G4P10
#8=#8+10
END8
}
N8

(Herramienta 9: BCD=0110, IN5=0 IN6=1 IN7=1 IN8=0)
IF[#200==9]
{
#9=0
WHILE[#9<=8000]DO9
IF[ [#1005==0]&&[#1006==1]&&[#1007==1]&&[#1008==0] ]GOTO9
G4P10
#9=#9+10
END9
}
N9

(Herramienta 10: BCD=0101, IN5=0 IN6=1 IN7=0 IN8=1)
IF[#200==10]
{
#10=0
WHILE[#10<=8000]DO10
IF[ [#1005==0]&&[#1006==1]&&[#1007==0]&&[#1008==1] ]GOTO10
G4P10
#10=#10+10
END10
}
N10

(Herramienta 11: BCD=0100, IN5=0 IN6=1 IN7=0 IN8=0)
IF[#200==11]
{
#11=0
WHILE[#11<=8000]DO11
IF[ [#1005==0]&&[#1006==1]&&[#1007==0]&&[#1008==0] ]GOTO11
G4P10
#11=#11+10
END11
}
N11

(Herramienta 12: BCD=0011, IN5=0 IN6=0 IN7=1 IN8=1)
IF[#200==12]
{
#12=0
WHILE[#12<=8000]DO12
IF[ [#1005==0]&&[#1006==0]&&[#1007==1]&&[#1008==1] ]GOTO12
G4P10
#12=#12+10
END12
}
N12

(--- FIN DEL PROGRAMA DE CAMBIO DE HERRAMIENTA ---)
M30
