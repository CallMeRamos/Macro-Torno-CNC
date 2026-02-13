(========================================================)
(  M_FUNC.NC - FUNCIONES MACRO DEL TORNO CNC           )
(  Controlador: ADTECH CNC9620 / Panel: FCNC4M         )
(  Traducido y documentado en espanol                   )
(========================================================)
(                                                       )
(  CONVENCIONES DE CODIGO:                              )
(  - O-code PAR  = ENCENDER o ACTIVAR                   )
(  - O-code IMPAR = APAGAR o DESACTIVAR                 )
(  - M3000 = Fin de subprograma                         )
(  - M30   = Fin de programa / salida de emergencia     )
(  - %     = Separador obligatorio entre subprogramas   )
(                                                       )
(  VARIABLES CLAVE DEL SISTEMA:                         )
(  #14xx  = Flag de estado del rele xx                  )
(  #18xx  = LED del panel del operador                  )
(  #3898  = Registro de senales sistema: bit 9=FWD,     )
(           bit 10=REV                                  )
(  #3906  = Modo actual: 0=EDIT, 1=AUTO, 2=MANUAL,     )
(           3=STEP/MPG, 4=HOME                          )
(  #3918  = Estado husillo: 0=detenido                  )
(  #4118  = Velocidad actual del husillo en RPM         )
(  #4120  = T-word actual completo (ej: 0505)           )
(  #4121  = Formato T-word: 2=TTOO x100, 1=TTO x10     )
(  #400   = Numero maximo de herramientas (12)          )
(  #10035 = Puerto asignado a lubricacion               )
(  #10036 = Puerto asignado a refrigerante              )
(  #1012  = Entrada IN12 - bloqueo externo chuck        )
(  #1004  = Entrada IN04 - sensor chuck (0=abierto, 1=cerrado) )
(                                                       )
(========================================================)
(                                                       )
(          TABLA COMPLETA DE SUBPROGRAMAS               )
(                                                       )
(========================================================)
(                                                       )
(  ===== REFRIGERANTE Y LUBRICACION =====               )
(  O0008 | Refrigerante ON           | M08              )
(  O0009 | Refrigerante OFF          | M09              )
(  O0032 | Lubricacion ON            | M32              )
(  O0033 | Lubricacion OFF           | M33              )
(  O208  | Refrigerante sistema ON   | M208 + LEDs      )
(  O209  | Refrigerante sistema OFF  | M209 + LEDs      )
(  O212  | Lubricacion sistema ON    | M212 + LEDs      )
(  O213  | Lubricacion sistema OFF   | M213 + LEDs      )
(                                                       )
(  ===== CHUCK DEL HUSILLO =====                        )
(  O0010 | Chuck cerrar - clamp      | M10              )
(  O0011 | Chuck abrir - unclamp     | M11              )
(  O2012 | Toggle chuck condicional  | Seguridad        )
(  O0100 | Verif. chuck cerrado       | M100 Seguridad  )
(                                                       )
(  ===== ILUMINACION Y HERRAMIENTA =====                )
(  O0012 | Iluminacion ON            | M12 OUT03        )
(  O0013 | Iluminacion OFF           | M13 OUT03        )
(  O0014 | Soltar herramienta ON     | M14 OUT06        )
(  O0015 | Soltar herramienta OFF    | M15 OUT06        )
(                                                       )
(  ===== TORRETA / CAMBIO DE HERRAMIENTA =====          )
(  O0016 | Disco torreta T++ manual  | M16 OUT07        )
(  O0017 | Disco torreta apagar      | M17 OUT07        )
(  O0018 | Torreta CW - T++         | M18 OUT08        )
(  O0019 | Torreta CW apagar         | M19 OUT08        )
(  O0020 | Torreta CCW - T--        | M20 OUT09        )
(  O0021 | Torreta CCW apagar        | M21 OUT09        )
(                                                       )
(  ===== AUXILIARES DE MAQUINA =====                    )
(  O0022 | Soplado ON                | M22 OUT10        )
(  O0023 | Soplado OFF               | M23 OUT10        )
(  O0024 | Transportador viruta ON   | M24 OUT11        )
(  O0025 | Transportador viruta OFF  | M25 OUT11        )
(  O0026 | Transp. viruta 2 ON       | OUT12 FCNC6D     )
(  O0027 | Transp. viruta 2 OFF      | OUT12 FCNC6D     )
(  O0128 | Refrigerante 2 ON         | OUT13 FCNC6D     )
(  O0129 | Refrigerante 2 OFF        | OUT13 FCNC6D     )
(  O0130 | Soltar material ON        | OUT14 FCNC6D     )
(  O0131 | Soltar material OFF       | OUT14 FCNC6D     )
(  O0034 | Expulsar pieza ON         | OUT15 FCNC6D     )
(  O0035 | Expulsar pieza OFF        | OUT15 FCNC6D     )
(  O0036 | Alimentar pieza ON        | OUT16 FCNC6D     )
(  O0037 | Alimentar pieza OFF       | OUT16 FCNC6D     )
(  O0038 | Husillo posicionam. ON    | OUT17 FCNC6D     )
(  O0039 | Husillo posicionam. OFF   | OUT17 FCNC6D     )
(                                                       )
(  ===== CONTROL DEL HUSILLO =====                      )
(  O0041 | Cambio engranaje 1        | M03/M04          )
(  O0042 | Cambio engranaje 2        | M03/M04          )
(  O0043 | Cambio engranaje 3        | M03/M04          )
(  O0044 | Cambio engranaje 4        | M03/M04          )
(  O203  | Toggle husillo giro CW    | M203             )
(  O204  | Toggle husillo giro CCW   | M204             )
(  O205  | Husillo parada total      | M205             )
(                                                       )
(  ===== BOTONES DE FUNCION DEL PANEL =====             )
(  O0052 | Boton F0 ON  INHABILITADO  | M40 OUT18        )
(  O0053 | Boton F0 OFF INHABILITADO  | M41 OUT18        )
(  O0054 | Boton F1 ON  INHABILITADO  | M42 OUT19        )
(  O0055 | Boton F1 OFF INHABILITADO  | M43 OUT19        )
(  O0056 | Boton F2 ON  INHABILITADO  | M44 OUT20        )
(  O0057 | Boton F2 OFF INHABILITADO  | M45 OUT20        )
(  O0046 | Boton F3 ON  INHABILITADO  | M46 OUT21        )
(  O0047 | Boton F3 OFF INHABILITADO  | M47 OUT21        )
(  O0048 | Boton F4 ON  INHABILITADO  | M48 OUT22        )
(  O0049 | Boton F4 OFF INHABILITADO  | M49 OUT22        )
(  O0050 | Boton F5 ON               | M50 OUT23        )
(  O0051 | Boton F5 OFF              | M51 OUT23        )
(  O0058 | Boton F9 ON               | M58 OUT27        )
(  O0059 | Boton F9 OFF              | M59 OUT27        )
(  O0060 | Boton F10 ON              | M60 OUT28        )
(  O0061 | Boton F10 OFF             | M61 OUT28        )
(  O0062 | Boton F11 ON              | M62 OUT29        )
(  O0063 | Boton F11 OFF             | M63 OUT29        )
(  O0064 | Boton F12 ON              | M64 OUT30        )
(  O0065 | Boton F12 OFF             | M65 OUT30        )
(  O0066 | Boton F13 ON              | M66 OUT31        )
(  O0067 | Boton F13 OFF             | M67 OUT31        )
(                                                       )
(  ===== RELES EXTENDIDOS OUT32-OUT47 =====             )
(  O0068/O0069 | Rele OUT32 ON/OFF                      )
(  O0070/O0071 | Rele OUT33 ON/OFF                      )
(  O0072/O0073 | Rele OUT34 ON/OFF                      )
(  O0074/O0075 | Rele OUT35 ON/OFF                      )
(  O0076/O0077 | Rele OUT36 ON/OFF                      )
(  O0078/O0079 | Rele OUT37 ON/OFF                      )
(  O0080/O0081 | Rele OUT38 ON/OFF                      )
(  O0082/O0083 | Rele OUT39 ON/OFF                      )
(  O0084/O0085 | Rele OUT40 ON/OFF                      )
(  O0086/O0087 | Rele OUT41 ON/OFF                      )
(  O0090/O0091 | Rele OUT42 ON/OFF                      )
(  O0092/O0093 | Rele OUT43 ON/OFF                      )
(  O0094/O0095 | Rele OUT44 ON/OFF                      )
(  O0096/O0097 | Rele OUT45 ON/OFF                      )
(  O0198/O0199 | Rele OUT46 ON/OFF                      )
(  O0100 | Verif. chuck cerrado (M100)                   )
(                                                       )
(  ===== TOGGLES DE ESTADO =====                        )
(  O3001-O3020 | Toggle variables #1926-#1945           )
(  Cada uno alterna 0/1 y muestra resultado en #3006    )
(                                                       )
(========================================================)
(  FIN DE TABLA - INICIO DE SUBPROGRAMAS                )
(========================================================)

(********************************************************)
(*                                                      *)
(*   SECCION 1: REFRIGERANTE                            *)
(*   Puerto dinamico segun parametro #10036             *)
(*   Usa referencia indirecta: #[#10036+1400]           *)
(*                                                      *)
(********************************************************)

O0008
(REFRIGERANTE ON - M08)
(Activa el rele del puerto asignado en #10036)
(Ej: si #10036=4, entonces activa #1404 = rele OUT04)
#[#10036+1400]=1
M3000
%
O0009
(REFRIGERANTE OFF - M09)
(Desactiva el rele del puerto asignado en #10036)
#[#10036+1400]=0
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 2: CHUCK DEL HUSILLO                       *)
(*   #1408 = rele clamp, #1409 = rele unclamp           *)
(*   #1812 = LED indicador, #1849 = LED chuck           *)
(*   M10 = cerrar chuck, M11 = abrir chuck              *)
(*                                                      *)
(********************************************************)

O0010
(CHUCK CERRAR - CLAMP - M10)
(Primero apaga unclamp, luego activa clamp)
#1409=0(Apagar rele unclamp)
#1408=1(Activar rele clamp)
#1812=1(LED indicador ON)
#1849=1(LED chuck ON)
M3000
%
O0011
(CHUCK ABRIR - UNCLAMP - M11)
(Primero apaga clamp, luego activa unclamp)
#1408=0(Apagar rele clamp)
#1409=1(Activar rele unclamp)
#1812=0(LED indicador OFF)
#1849=0(LED chuck OFF)
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 3: ILUMINACION                             *)
(*   #1406 = rele OUT03, #1852 = LED iluminacion        *)
(*                                                      *)
(********************************************************)

O0012
(ILUMINACION ON - M12 - OUT03)
#1406=1(Activar rele iluminacion)
#1852=1(LED iluminacion ON)
M3000
%
O0013
(ILUMINACION OFF - M13 - OUT03)
#1406=0(Apagar rele iluminacion)
#1852=0(LED iluminacion OFF)
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 4: SOLTAR/APRETAR HERRAMIENTA              *)
(*   #1407 = rele OUT06, #1854 = LED herramienta        *)
(*   Requiere modo automatico: #3906==2                  *)
(*                                                      *)
(********************************************************)

O0014
(SOLTAR HERRAMIENTA ON - M14 - OUT06)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1407=1(Activar rele soltar herramienta)
#1854=1(LED herramienta ON)
M3000
%
O0015
(SOLTAR HERRAMIENTA OFF - M15 - OUT06)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1407=0(Apagar rele soltar herramienta)
#1854=0(LED herramienta OFF)
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 5: TORRETA - CAMBIO DE HERRAMIENTA         *)
(*                                                      *)
(*   O0016 = Disco torreta manual T++ con cambio real   *)
(*   O0017 = Apagar disco torreta y limpiar reles       *)
(*   O0018 = Torreta CW T++ con cambio real             *)
(*   O0019 = Torreta CW apagar - safety fallback        *)
(*   O0020 = Torreta CCW T-- con cambio real            *)
(*   O0021 = Torreta CCW apagar - safety fallback       *)
(*                                                      *)
(*   LOGICA DE CAMBIO DE HERRAMIENTA:                   *)
(*   1. Leer formato T-word de #4121                    *)
(*      Si #4121==2: multiplicador=100 - formato TTOO   *)
(*      Si #4121==1: multiplicador=10  - formato TTO    *)
(*   2. Extraer numero de herramienta actual:           *)
(*      #1 = FIX[#4120 / multiplicador]                 *)
(*   3. Incrementar o decrementar la herramienta        *)
(*   4. Si pasa del maximo #400, volver a 1             *)
(*      Si baja de 1, ir al maximo #400                 *)
(*   5. Construir T-word completo:                      *)
(*      T-word = herramienta * multiplicador + offset   *)
(*      Ej: herram 5, mult 100 => T0505                 *)
(*   6. Ejecutar comando T para cambio real             *)
(*                                                      *)
(********************************************************)

O0016
(DISCO TORRETA MANUAL T++ - M16 - OUT07)
(Avanza herramienta +1 con cambio real via comando T)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
(Determinar multiplicador segun formato T-word)
#2=100
IF[#4121==2]{
#2=100
}
IF[#4121==1]{
#2=10
}
(Extraer numero de herramienta actual)
#1=FIX[#4120/#2]
(Incrementar herramienta +1)
#1=#1+1
IF[#1 > #400]{
#1=1
}
(Construir T-word: herramienta*multiplicador + offset)
#3=#1
#1=#1*#2
#1=#1+#3
(Encender LED durante el cambio)
#1855=1(LED disco torreta ON)
(Ejecutar cambio de herramienta real)
T#1
(Apagar LED despues del cambio)
#1855=0(LED disco torreta OFF)
M3000
%
O0017
(DISCO TORRETA APAGAR - M17 - OUT07)
(Limpia todos los reles y LEDs de torreta)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1402=0(Apagar rele torreta CW)
#1403=0(Apagar rele torreta CCW)
#1811=0(LED lubricacion/tool ready OFF)
#1855=0(LED disco torreta OFF)
M3000
%

O0018
(TORRETA CW T++ - M18 - OUT08)
(Avanza herramienta +1 en sentido horario con cambio real)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
(Determinar multiplicador segun formato T-word)
#2=100
IF[#4121==2]{#2=100}
IF[#4121==1]{#2=10}
(Extraer numero de herramienta actual)
#1=FIX[#4120/#2]
(Incrementar +1, si pasa del max volver a 1)
#1=#1+1
IF[#1 > #400]{#1=1}
(Construir T-word completo)
#3=#1
#1=#1*#2
#1=#1+#3
(Encender LED durante el cambio)
#1856=1(LED torreta CW ON)
(Ejecutar cambio de herramienta real)
T#1
(Apagar LED despues del cambio)
#1856=0(LED torreta CW OFF)
M3000
%
O0019
(TORRETA CW APAGAR - M19 - OUT08)
(Safety fallback: apaga rele y LED de torreta CW)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1402=0(Rele torreta CW OFF)
#1856=0(LED torreta CW OFF)
M3000
%

O0020
(TORRETA CCW T-- - M20 - OUT09)
(Retrocede herramienta -1 en sentido antihorario con cambio real)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
(Determinar multiplicador segun formato T-word)
#2=100
IF[#4121==2]{#2=100}
IF[#4121==1]{#2=10}
(Extraer numero de herramienta actual)
#1=FIX[#4120/#2]
(Decrementar -1, si baja de 1 ir al maximo)
#1=#1-1
IF[#1 < 1]{#1=#400}
(Construir T-word completo)
#3=#1
#1=#1*#2
#1=#1+#3
(Encender LED durante el cambio)
#1857=1(LED torreta CCW ON)
(Ejecutar cambio de herramienta real)
T#1
(Apagar LED despues del cambio)
#1857=0(LED torreta CCW OFF)
M3000
%
O0021
(TORRETA CCW APAGAR - M21 - OUT09)
(Safety fallback: apaga rele y LED de torreta CCW)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1403=0(Rele torreta CCW OFF)
#1857=0(LED torreta CCW OFF)
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 6: AUXILIARES DE MAQUINA                   *)
(*   Soplado, transportador de viruta, etc.             *)
(*   Requieren modo automatico: #3906==2                 *)
(*                                                      *)
(********************************************************)

O0022
(SOPLADO ON - M22 - OUT10)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1410=1(Rele soplado ON)
#1860=1(LED soplado ON)
M3000
%
O0023
(SOPLADO OFF - M23 - OUT10)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1410=0(Rele soplado OFF)
#1860=0(LED soplado OFF)
M3000
%

O0024
(TRANSPORTADOR DE VIRUTA ON - M24 - OUT11)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1411=1(Rele transportador viruta ON)
#1862=1(LED transportador viruta ON)
M3000
%
O0025
(TRANSPORTADOR DE VIRUTA OFF - M25 - OUT11)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1411=0(Rele transportador viruta OFF)
#1862=0(LED transportador viruta OFF)
M3000
%

O0026
(TRANSPORTADOR VIRUTA 2 ON - FCNC6D - OUT12)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1412=1(Rele viruta 2 ON)
#1883=1(LED viruta 2 ON)
M3000
%
O0027
(TRANSPORTADOR VIRUTA 2 OFF - FCNC6D - OUT12)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1412=0(Rele viruta 2 OFF)
#1883=0(LED viruta 2 OFF)
M3000
%

O0128
(REFRIGERANTE 2 ON - FCNC6D - OUT13)
#1413=1(Rele refrigerante 2 ON)
#1884=1(LED refrigerante 2 ON)
M3000
%
O0129
(REFRIGERANTE 2 OFF - FCNC6D - OUT13)
#1413=0(Rele refrigerante 2 OFF)
#1884=0(LED refrigerante 2 OFF)
M3000
%

O0130
(SOLTAR MATERIAL ON - FCNC6D - OUT14)
#1414=1(Rele soltar material ON)
#1885=1(LED soltar material ON)
M3000
%
O0131
(SOLTAR MATERIAL OFF - FCNC6D - OUT14)
#1414=0(Rele soltar material OFF)
#1885=0(LED soltar material OFF)
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 7: LUBRICACION                             *)
(*   Puerto dinamico segun parametro #10035             *)
(*   Usa referencia indirecta: #[#10035+1400]           *)
(*                                                      *)
(********************************************************)

O0032
(LUBRICACION ON - M32)
(Activa el rele del puerto asignado en #10035)
#[#10035+1400]=1
M3000
%
O0033
(LUBRICACION OFF - M33)
(Desactiva el rele del puerto asignado en #10035)
#[#10035+1400]=0
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 8: FUNCIONES FCNC6D ADICIONALES            *)
(*   Expulsar pieza, alimentar pieza,                   *)
(*   posicionamiento de husillo                         *)
(*                                                      *)
(********************************************************)

O0034
(EXPULSAR PIEZA ON - FCNC6D - OUT15)
#1415=1(Rele expulsar ON)
#1886=1(LED expulsar ON)
M3000
%
O0035
(EXPULSAR PIEZA OFF - FCNC6D - OUT15)
#1415=0(Rele expulsar OFF)
#1886=0(LED expulsar OFF)
M3000
%

O0036
(ALIMENTAR PIEZA ON - FCNC6D - OUT16)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1416=1(Rele alimentar ON)
#1887=1(LED alimentar ON)
M3000
%
O0037
(ALIMENTAR PIEZA OFF - FCNC6D - OUT16)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1416=0(Rele alimentar OFF)
#1887=0(LED alimentar OFF)
M3000
%

O0038
(HUSILLO POSICIONAMIENTO ON - FCNC6D - OUT17)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1417=1(Rele posicionamiento ON)
#1889=1(LED posicionamiento ON)
M3000
%
O0039
(HUSILLO POSICIONAMIENTO OFF - FCNC6D - OUT17)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
#1417=0(Rele posicionamiento OFF)
#1889=0(LED posicionamiento OFF)
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 9: CONTROL DEL HUSILLO - ENGRANAJES        *)
(*                                                      *)
(*   O0041-O0044 = Engranajes 1-4 del husillo           *)
(*   Cada uno carga la velocidad maxima del engranaje    *)
(*   correspondiente en #11502 y luego re-arranca el    *)
(*   husillo en la direccion actual.                    *)
(*                                                      *)
(*   #11502 = Parametro velocidad max activo            *)
(*   #11516 = Vel. max engranaje 1                      *)
(*   #11518 = Vel. max engranaje 2                      *)
(*   #11520 = Vel. max engranaje 3                      *)
(*   #11522 = Vel. max engranaje 4                      *)
(*   #3898  = Registro senales: bit9=FWD, bit10=REV     *)
(*   #4118  = Velocidad actual del husillo              *)
(*                                                      *)
(********************************************************)

O0041
(ENGRANAJE 1 DEL HUSILLO)
(Carga velocidad max del engranaje 1)
#11502=#11516
(Lee registro de senales del sistema)
#1=#3898
(Verificar si husillo gira en sentido horario - bit 9)
#2=#1 & 512
IF[#2](Husillo en giro horario)
{
M03S#4118(Re-arrancar CW a velocidad actual)
}
(Verificar si husillo gira en sentido antihorario - bit 10)
#2=#1 & 1024
IF[#2](Husillo en giro antihorario)
{
M04S#4118(Re-arrancar CCW a velocidad actual)
}
M3000
%
O0042
(ENGRANAJE 2 DEL HUSILLO)
(Carga velocidad max del engranaje 2)
#11502=#11518
#1=#3898
#2=#1 & 512
IF[#2](Husillo en giro horario)
{
M03S#4118
}
#2=#1 & 1024
IF[#2](Husillo en giro antihorario)
{
M04S#4118
}
M3000
%
O0043
(ENGRANAJE 3 DEL HUSILLO)
(Carga velocidad max del engranaje 3)
#11502=#11520
#1=#3898
#2=#1 & 512
IF[#2](Husillo en giro horario)
{
M03S#4118
}
#2=#1 & 1024
IF[#2](Husillo en giro antihorario)
{
M04S#4118
}
M3000
%
O0044
(ENGRANAJE 4 DEL HUSILLO)
(Carga velocidad max del engranaje 4)
#11502=#11522
#1=#3898
#2=#1 & 512
IF[#2](Husillo en giro horario)
{
M03S#4118
}
#2=#1 & 1024
IF[#2](Husillo en giro antihorario)
{
M04S#4118
}
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 10: BOTONES DE FUNCION DEL PANEL           *)
(*   F0-F5 y F9-F13                                     *)
(*   Cada boton tiene ON par y OFF impar                *)
(*   Activan/desactivan rele #14xx y LED #18xx          *)
(*                                                      *)
(********************************************************)

O0052
(BOTON F0 ON - INHABILITADO)
M3000
%
O0053
(BOTON F0 OFF - INHABILITADO)
M3000
%

O0054
(BOTON F1 ON - INHABILITADO)
M3000
%
O0055
(BOTON F1 OFF - INHABILITADO)
M3000
%

O0056
(BOTON F2 ON - INHABILITADO)
M3000
%
O0057
(BOTON F2 OFF - INHABILITADO)
M3000
%

O0046
(BOTON F3 ON - INHABILITADO)
M3000
%
O0047
(BOTON F3 OFF - INHABILITADO)
M3000
%

O0048
(BOTON F4 ON - INHABILITADO)
M3000
%
O0049
(BOTON F4 OFF - INHABILITADO)
M3000
%

O0050
(BOTON F5 ON - FCNC6D - M50 - OUT23)
#1423=1(Rele F5 ON)
#1874=1(LED F5 ON)
M3000
%
O0051
(BOTON F5 OFF - FCNC6D - M51 - OUT23)
#1423=0(Rele F5 OFF)
#1874=0(LED F5 OFF)
M3000
%



O0058
(BOTON F9 ON - FCNC6D - M58 - OUT27)
#1427=1(Rele F9 ON)
#1893=1(LED F9 ON)
M3000
%
O0059
(BOTON F9 OFF - FCNC6D - M59 - OUT27)
#1427=0(Rele F9 OFF)
#1893=0(LED F9 OFF)
M3000
%

O0060
(BOTON F10 ON - FCNC6D - M60 - OUT28)
#1428=1(Rele F10 ON)
#1894=1(LED F10 ON)
M3000
%
O0061
(BOTON F10 OFF - FCNC6D - M61 - OUT28)
#1428=0(Rele F10 OFF)
#1894=0(LED F10 OFF)
M3000
%

O0062
(BOTON F11 ON - FCNC6D - M62 - OUT29)
#1429=1(Rele F11 ON)
#1895=1(LED F11 ON)
M3000
%
O0063
(BOTON F11 OFF - FCNC6D - M63 - OUT29)
#1429=0(Rele F11 OFF)
#1895=0(LED F11 OFF)
M3000
%

O0064
(BOTON F12 ON - FCNC6D - M64 - OUT30)
#1430=1(Rele F12 ON)
#1896=1(LED F12 ON)
M3000
%
O0065
(BOTON F12 OFF - FCNC6D - M65 - OUT30)
#1430=0(Rele F12 OFF)
#1896=0(LED F12 OFF)
M3000
%

O0066
(BOTON F13 ON - FCNC6D - M66 - OUT31)
#1431=1(Rele F13 ON)
#1897=1(LED F13 ON)
M3000
%
O0067
(BOTON F13 OFF - FCNC6D - M67 - OUT31)
#1431=0(Rele F13 OFF)
#1897=0(LED F13 OFF)
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 11: RELES EXTENDIDOS OUT32-OUT47           *)
(*   Salidas de proposito general sin LED asociado      *)
(*   Solo activan/desactivan el flag #14xx              *)
(*                                                      *)
(********************************************************)

O0068
(RELE EXTENDIDO OUT32 ON)
#1432=1
M3000
%
O0069
(RELE EXTENDIDO OUT32 OFF)
#1432=0
M3000
%

O0070
(RELE EXTENDIDO OUT33 ON)
#1433=1
M3000
%
O0071
(RELE EXTENDIDO OUT33 OFF)
#1433=0
M3000
%

O0072
(RELE EXTENDIDO OUT34 ON)
#1434=1
M3000
%
O0073
(RELE EXTENDIDO OUT34 OFF)
#1434=0
M3000
%

O0074
(RELE EXTENDIDO OUT35 ON)
#1435=1
M3000
%
O0075
(RELE EXTENDIDO OUT35 OFF)
#1435=0
M3000
%

O0076
(RELE EXTENDIDO OUT36 ON)
#1436=1
M3000
%
O0077
(RELE EXTENDIDO OUT36 OFF)
#1436=0
M3000
%

O0078
(RELE EXTENDIDO OUT37 ON)
#1437=1
M3000
%
O0079
(RELE EXTENDIDO OUT37 OFF)
#1437=0
M3000
%

O0080
(RELE EXTENDIDO OUT38 ON)
#1438=1
M3000
%
O0081
(RELE EXTENDIDO OUT38 OFF)
#1438=0
M3000
%

O0082
(RELE EXTENDIDO OUT39 ON)
#1439=1
M3000
%
O0083
(RELE EXTENDIDO OUT39 OFF)
#1439=0
M3000
%

O0084
(RELE EXTENDIDO OUT40 ON)
#1440=1
M3000
%
O0085
(RELE EXTENDIDO OUT40 OFF)
#1440=0
M3000
%

O0086
(RELE EXTENDIDO OUT41 ON)
#1441=1
M3000
%
O0087
(RELE EXTENDIDO OUT41 OFF)
#1441=0
M3000
%

O0090
(RELE EXTENDIDO OUT42 ON)
#1442=1
M3000
%
O0091
(RELE EXTENDIDO OUT42 OFF)
#1442=0
M3000
%

O0092
(RELE EXTENDIDO OUT43 ON)
#1443=1
M3000
%
O0093
(RELE EXTENDIDO OUT43 OFF)
#1443=0
M3000
%

O0094
(RELE EXTENDIDO OUT44 ON)
#1444=1
M3000
%
O0095
(RELE EXTENDIDO OUT44 OFF)
#1444=0
M3000
%

O0096
(RELE EXTENDIDO OUT45 ON)
#1445=1
M3000
%
O0097
(RELE EXTENDIDO OUT45 OFF)
#1445=0
M3000
%

O0198
(RELE EXTENDIDO OUT46 ON)
#1446=1
M3000
%
O0199
(RELE EXTENDIDO OUT46 OFF)
#1446=0
M3000
%

O0100
(VERIFICACION CHUCK CERRADO - SEGURIDAD PRE-INICIO M100)
(IN04=#1004: 0=chuck abierto, 1=chuck cerrado)
IF[#1004==0]{
#3000=1(CHUCK ABIERTO - CERRAR CHUCK)
}
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 12: CONTROL DE HUSILLO - SISTEMA           *)
(*                                                      *)
(*   O203 = Toggle husillo giro CW: si esta parado      *)
(*          arranca M03, si esta girando para M05        *)
(*   O204 = Toggle husillo giro CCW: igual pero M04     *)
(*   O205 = Parada inmediata del husillo M05            *)
(*                                                      *)
(*   #3906 = Modo del sistema, requiere 2=automatico    *)
(*   #3918 = Estado husillo: 0=detenido, otro=girando   *)
(*   #4118 = Velocidad actual del husillo en RPM        *)
(*   #1808 = LED husillo giro horario FWD               *)
(*   #1809 = LED husillo giro antihorario REV           *)
(*                                                      *)
(********************************************************)
(**********************)
O203
(TOGGLE HUSILLO GIRO HORARIO CW - M203)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
IF[#3918==0](Si husillo esta detenido)
{
IF[#1004==0]{#3000=1(CHUCK ABIERTO)}
 M03S#4118(Arrancar husillo CW a velocidad actual)
#1808=1(LED husillo FWD ON)
}
ELSE(Si husillo esta girando)
{
 M05(Parar husillo)
#1808=0(LED husillo FWD OFF)
}
M3000
%
O204
(TOGGLE HUSILLO GIRO ANTIHORARIO CCW - M204)
IF[#3906!=2]M3000(Si no es modo automatico, salir)
IF[#3918==0](Si husillo esta detenido)
{
IF[#1004==0]{#3000=1(CHUCK ABIERTO)}
 M04S#4118(Arrancar husillo CCW a velocidad actual)
#1809=1(LED husillo REV ON)
}
ELSE(Si husillo esta girando)
{
 M05(Parar husillo)
#1809=0(LED husillo REV OFF)
}
M3000
%
O205
(HUSILLO PARADA TOTAL - M205)
M05(Parar husillo inmediatamente)
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 13: REFRIGERANTE Y LUBRICACION - SISTEMA   *)
(*   Versiones con control de LEDs del panel             *)
(*   Usan puerto dinamico + LEDs indicadores            *)
(*                                                      *)
(*   #10036 = Puerto refrigerante                       *)
(*   #1810  = LED refrigerante principal                *)
(*   #1861  = LED refrigerante secundario               *)
(*   #10035 = Puerto lubricacion                        *)
(*   #1811  = LED lubricacion principal                  *)
(*   #1859  = LED lubricacion secundario                *)
(*                                                      *)
(********************************************************)

O208
(REFRIGERANTE SISTEMA ON - M208)
(Activa refrigerante + enciende ambos LEDs del panel)
#[#10036+1400]=1(Activar rele refrigerante)
#1810=1(LED refrigerante principal ON)
#1861=1(LED refrigerante secundario ON)
M3000
%
O209
(REFRIGERANTE SISTEMA OFF - M209)
(Desactiva refrigerante + apaga ambos LEDs del panel)
#[#10036+1400]=0(Desactivar rele refrigerante)
#1810=0(LED refrigerante principal OFF)
#1861=0(LED refrigerante secundario OFF)
M3000
%

O212
(LUBRICACION SISTEMA ON - M212)
(Activa lubricacion + enciende ambos LEDs del panel)
#[#10035+1400]=1(Activar rele lubricacion)
#1811=1(LED lubricacion principal ON)
#1859=1(LED lubricacion secundario ON)
M3000
%
O213
(LUBRICACION SISTEMA OFF - M213)
(Desactiva lubricacion + apaga ambos LEDs del panel)
#[#10035+1400]=0(Desactivar rele lubricacion)
#1811=0(LED lubricacion principal OFF)
#1859=0(LED lubricacion secundario OFF)
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 14: TOGGLE CHUCK CONDICIONAL               *)
(*                                                      *)
(*   O2012 alterna chuck abierto/cerrado con seguridad: *)
(*   - Solo actua si IN12 no esta activa (#1012==0)     *)
(*   - Si el chuck esta cerrado Y el husillo gira,      *)
(*     NO permite abrir (seguridad anti-accidente)      *)
(*   - Si husillo detenido, alterna normalmente         *)
(*                                                      *)
(********************************************************)

O2012
(TOGGLE CHUCK CONDICIONAL CON SEGURIDAD)
IF[#1012==0](Solo si entrada IN12 no esta activa)
{
IF[#1408](Si chuck esta cerrado - clamp activo)
{
(Intentar abrir chuck - verificar seguridad primero)
#1=#3918(Leer estado del husillo)
IF[#1] M30(SEGURIDAD: si husillo gira, NO abrir - salir)
(Husillo detenido, seguro para abrir)
#1408=0(Desactivar clamp)
#1409=1(Activar unclamp)
#1812=0(LED indicador OFF)
#1849=0(LED chuck OFF)
}
ELSE(Chuck esta abierto - cerrar)
{
#1408=1(Activar clamp)
#1409=0(Desactivar unclamp)
#1812=1(LED indicador ON)
#1849=1(LED chuck ON)
}
}
M3000
%

(********************************************************)
(*                                                      *)
(*   SECCION 15: TOGGLES DE ESTADO                      *)
(*                                                      *)
(*   O3001-O3020 controlan variables #1926-#1945        *)
(*   Cada subprograma alterna su variable entre 0 y 1   *)
(*   y muestra el resultado en #3006 para confirmacion  *)
(*                                                      *)
(*   Patron:                                            *)
(*   IF[#19xx == 0] => #19xx = 1, mostrar "19xx=1"     *)
(*   ELSE           => #19xx = 0, mostrar "19xx=0"     *)
(*                                                      *)
(*   Uso: flags de usuario para logica personalizada    *)
(*                                                      *)
(********************************************************)


O3001
(TOGGLE ESTADO #1926)
IF[#1926 == 0]
{
#1926 = 1
#3006 = 1(1926=1)
}
ELSE
{
#1926 = 0
#3006 = 1(1926=0)
}
M3000
%
O3002
(TOGGLE ESTADO #1927)
IF[#1927 == 0]
{
#1927 = 1
#3006 = 1(1927=1)
}
ELSE
{
#1927 = 0
#3006 = 1(1927=0)
}
M3000
%
O3003
(TOGGLE ESTADO #1928)
IF[#1928 == 0]
{
#1928 = 1
#3006 = 1(1928=1)
}
ELSE
{
#1928 = 0
#3006 = 1(1928=0)
}
M3000
%
O3004
(TOGGLE ESTADO #1929)
IF[#1929 == 0]
{
#1929 = 1
#3006 = 1(1929=1)
}
ELSE
{
#1929 = 0
#3006 = 1(1929=0)
}
M3000
%
O3005
(TOGGLE ESTADO #1930)
IF[#1930 == 0]
{
#1930 = 1
#3006 = 1(1930=1)
}
ELSE
{
#1930 = 0
#3006 = 1(1930=0)
}
M3000
%
O3006
(TOGGLE ESTADO #1931)
IF[#1931 == 0]
{
#1931 = 1
#3006 = 1(1931=1)
}
ELSE
{
#1931 = 0
#3006 = 1(1931=0)
}
M3000
%
O3007
(TOGGLE ESTADO #1932)
IF[#1932 == 0]
{
#1932 = 1
#3006 = 1(1932=1)
}
ELSE
{
#1932 = 0
#3006 = 1(1932=0)
}
M3000
%
O3008
(TOGGLE ESTADO #1933)
IF[#1933 == 0]
{
#1933 = 1
#3006 = 1(1933=1)
}
ELSE
{
#1933 = 0
#3006 = 1(1933=0)
}
M3000
%
O3009
(TOGGLE ESTADO #1934)
IF[#1934 == 0]
{
#1934 = 1
#3006 = 1(1934=1)
}
ELSE
{
#1934 = 0
#3006 = 1(1934=0)
}
M3000
%
O3010
(TOGGLE ESTADO #1935)
IF[#1935 == 0]
{
#1935 = 1
#3006 = 1(1935=1)
}
ELSE
{
#1935 = 0
#3006 = 1(1935=0)
}
M3000
%
O3011
(TOGGLE ESTADO #1936)
IF[#1936 == 0]
{
#1936 = 1
#3006 = 1(1936=1)
}
ELSE
{
#1936 = 0
#3006 = 1(1936=0)
}
M3000
%
O3012
(TOGGLE ESTADO #1937)
IF[#1937 == 0]
{
#1937 = 1
#3006 = 1(1937=1)
}
ELSE
{
#1937 = 0
#3006 = 1(1937=0)
}
M3000
%
O3013
(TOGGLE ESTADO #1938)
IF[#1938 == 0]
{
#1938 = 1
#3006 = 1(1938=1)
}
ELSE
{
#1938 = 0
#3006 = 1(1938=0)
}
M3000
%
O3014
(TOGGLE ESTADO #1939)
IF[#1939 == 0]
{
#1939 = 1
#3006 = 1(1939=1)
}
ELSE
{
#1939 = 0
#3006 = 1(1939=0)
}
M3000
%
O3015
(TOGGLE ESTADO #1940)
IF[#1940 == 0]
{
#1940 = 1
#3006 = 1(1940=1)
}
ELSE
{
#1940 = 0
#3006 = 1(1940=0)
}
M3000
%
O3016
(TOGGLE ESTADO #1941)
IF[#1941 == 0]
{
#1941 = 1
#3006 = 1(1941=1)
}
ELSE
{
#1941 = 0
#3006 = 1(1941=0)
}
M3000
%
O3017
(TOGGLE ESTADO #1942)
IF[#1942 == 0]
{
#1942 = 1
#3006 = 1(1942=1)
}
ELSE
{
#1942 = 0
#3006 = 1(1942=0)
}
M3000
%
O3018
(TOGGLE ESTADO #1943)
IF[#1943 == 0]
{
#1943 = 1
#3006 = 1(1943=1)
}
ELSE
{
#1943 = 0
#3006 = 1(1943=0)
}
M3000
%
O3019
(TOGGLE ESTADO #1944)
IF[#1944 == 0]
{
#1944 = 1
#3006 = 1(1944=1)
}
ELSE
{
#1944 = 0
#3006 = 1(1944=0)
}
M3000
%
O3020
(TOGGLE ESTADO #1945)
IF[#1945 == 0]
{
#1945 = 1
#3006 = 1(1945=1)
}
ELSE
{
#1945 = 0
#3006 = 1(1945=0)
}
M3000
%


(========================================================)
(  FIN DE M_FUNC.NC                                     )
(  Total: 57 subprogramas en 16 secciones               )
(========================================================)
