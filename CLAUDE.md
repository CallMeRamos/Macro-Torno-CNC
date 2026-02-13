# Macro Torno CNC

Biblioteca de macros G-Code para torno CNC con controlador FANUC-compatible (FCNC4M / ADTECH CNC9620). Sin build system; los archivos `.NC` se cargan directamente al controlador vía USB/serial.

## Archivos del proyecto

| Archivo | Descripción |
|---------|-------------|
| `M_FUNC.NC` | Funciones M (husillo, I/O, LEDs, botones panel, toggles) |
| `T_FUNC (2).NC` | Función de cambio de herramienta (torreta 12 posiciones) |
| `MACRO ADDRESS.xlsx` | Mapa de direcciones de variables macro |
| `MACRO TRAINING.pdf` | Documentación de entrenamiento del controlador |
| `image1.png` | Foto panel operador FCNC4M |
| `image2.png` | Foto controlador ADTECH CNC9620 |
| `nc_res.ncp` | Archivo de recursos de texto del firmware (tabla bilingüe chino/inglés) — **modificado** |
| `nc_res.ncp.bak` | Respaldo del nc_res.ncp original (sin modificar) |
| `NC_RES_CATALOGO.md` | Catálogo completo de 2,212 textos personalizables del firmware (15 categorías, índice por bytes) |

## Hardware de referencia

- **Panel operador FCNC4M** (`image1.png`): Botones START/PAUSE/E-stop, teclado numérico, selectores rotativos (OPERATION MODE, OVERRIDE TRAVERSE FEED, OVERRIDE SPINDLE)
- **Controlador ADTECH CNC9620** (`image2.png`): Pantalla LCD, teclado alfanumérico, teclas F1-F6, puerto USB, botones MONITOR/PROG/PARA/COORD/DORUN

## Arquitectura de M_FUNC.NC

~1170 líneas, ~40+ subprogramas. Convención de O-codes: **pares = enable, impares = disable**.

### Grupos funcionales

| Rango O-code | Función |
|--------------|---------|
| O0008-O0009 | Refrigerante (M08/M09) |
| O0010-O0011 | Chuck husillo (M10/M11) |
| O0012-O0039 | Relés de salida OUT03-OUT16 |
| O0041-O0044 | Rotación husillo (M03/M04) |
| O0046-O0067 | Botones de función F0-F13 (F0-F4 INHABILITADOS) |
| O0068-O0101 | Relés extendidos OUT32-OUT47 |
| O203-O213 | Control de sistema (husillo start/stop, refrigerante, tool ready) |
| O2012 | Toggle husillo condicional |
| O3001-O3020 | Toggles de estado (#1926-#1945) |

### Patrón de macro estándar

```gcode
O[XXXX]
(DESCRIPCION)
IF[condición]M3000
#variable=valor
M3000
%
```

## Arquitectura de T_FUNC (2).NC

~210 líneas, programa O0001. Torreta de 12 posiciones con optimización de ruta CW/CCW.

- **Validación** de herramienta con mensajes bilingües (chino/inglés, flag `#11028`)
- **Secuencia**: validar → desclampear → girar → clampear → verificar BCD
- **Verificación BCD**: 4 sensores (IN5-IN8 → `#1005-#1008`)
- **Timeout**: 8 segundos por posición

## Mapa de variables del sistema

| Variable | Uso |
|----------|-----|
| `#1-#33` | Variables locales temporales |
| `#100-#200` | Parámetros de propósito general |
| `#400` | Número máximo de herramientas |
| `#1004` | Sensor chuck (IN04): 0=abierto, 1=cerrado (sensor NC invertido). Param 031=**4** |
| `#1005-#1008` | Entradas sensores BCD torreta (IN5-IN8) |
| `#1400-#1450` | Flags de estado de salidas (relés) |
| `#1800-#1900` | Estados extendidos e indicadores LED |
| `#3006` | Flag de confirmación de acción |
| `#3906` | Modo del sistema (2=automático) |
| `#3918` | Estado del husillo (0=detenido) |
| `#4118` | Velocidad del husillo |
| `#4120-#4121` | Parámetros de herramienta/torreta |
| `#10035-#10036` | Registros de control (tool changer, refrigerante) |
| `#11028` | Selector de idioma (0=inglés, 1=chino) |

## Referencia de direcciones macro (del fabricante)

Rangos completos del sheet "Macro Table" de `MACRO ADDRESS.xlsx`:

| Rango | Tipo | Función |
|-------|------|---------|
| `#2000-#3088` | STR | Información de alarmas y G-code en ejecución |
| `#3898-#3899` | INT16U | Registros de señales del sistema (safety, E-stop, MPG) |
| `#3900-#3902` | INT32U | Conteo de piezas / cantidad máxima producción |
| `#3904-#3905` | INT16U | Botones internos CNC / entrada de teclas externas |
| `#3906` | INT8U | Modo actual (0=EDIT, 1=AUTO, 2=MANUAL, 3=STEP/MPG, 4=HOME) |
| `#3907-#3916` | Mixed | Ratios de velocidad (interpolación, rapid, husillo, jog, programación, actual, manual) |
| `#3918` | INT32U | Estado del husillo |
| `#3930-#3947` | Mixed | Estado del sistema (alarma, running status, MPG, breakpoint, DNC) |
| `#3950-#3998` | FLOAT | Control husillo (voltaje DA ch0/ch1, corriente trabajo) |
| `#4000-#4010` | INT16U | Valores modales G-code (grupos 0-10) |
| `#4050-#4065` | INT16U | Habilitación/inhibición movimiento por eje (X±, Y±, Z±, A±, B±, C±) |

> **Nota de compatibilidad**: El Excel lista columnas para múltiples modelos: CNC4960, CNC4940, CNC4640(20), FCNC4M, FDK4A, FCNC6D. Las direcciones macro son compartidas entre la familia ADTECH.

## Mapeo LED del panel

Tabla del sheet "LED add." — mapeo `#1800-#1897` → función + OUT/M-code asociado:

| Rango | Función | OUT/M-code |
|-------|---------|------------|
| `#1800-#1807` | Teclas menú F0-F7 | — |
| `#1808` | Husillo FWD | OUT00 (M203) |
| `#1809` | Husillo REV | OUT01 (M204) |
| `#1810` | Refrigerante | OUT04 (M208/M209) |
| `#1811` | Lubricación | OUT05 (M212/M213) |
| `#1812-#1815` | Block skip, Single block, Pause, Start | — |
| `#1816-#1819` | Home X, Y, Z, A | — |
| `#1820-#1823` | Ready, Running, Stop, Alarm | — |
| `#1843` | Panel F0 | OUT18 (M40/M41) |
| `#1848` | Panel F1 | OUT19 (M42/M43) |
| `#1849` | Chuck | OUT02 (M10/M11) |
| `#1852` | Iluminación | OUT03 (M12/M13) |
| `#1853` | Panel F2 | OUT20 (M44/M45) |
| `#1854` | Soltar/apretar herramienta | OUT06 (M14/M15) |
| `#1855` | Disco torreta (manual) | OUT07 (M16/M17) |
| `#1856-#1857` | Torreta CW/CCW | OUT08-09 (M18-M21) |
| `#1858` | Panel F3 | OUT21 (M46/M47) |
| `#1860` | Soplado | OUT10 (M22/M23) |
| `#1862` | Transportador viruta | OUT11 (M24/M25) |
| `#1863` | Panel F4 | OUT22 (M48/M49) |
| `#1874` | Panel F5 | OUT23 (M50/M51) |
| `#1883-#1887` | Viruta2, Refri2, Soltar material, Expulsar, Alimentar | OUT12-16 |
| `#1888` | Husillo stop | M205 |
| `#1889` | Husillo posicionamiento | OUT17 (M38/M39) |
| `#1890-#1897` | F6-F13 | OUT24-31 (M52-M67) |

## Comandos #5111

Interfaz de comandos del sistema vía escritura a `#5111`:

| Valor | Comando |
|-------|---------|
| 1 | Crear archivo recibido de host |
| 2-6 | Parámetros: backup/restore/import/export/reset |
| 7 | Importar programa |
| 8 | Comunicación USB |
| 9 | Reinicio del sistema |
| 10-11 | Tool probe: escanear / medir |
| 12 | Encriptar archivo de mecanizado |
| 13-14 | Macro variables: guardar / cargar |
| 15-20 | Home por eje individual (X/Y/Z/A/B/C) |
| 21-22 | Backup/restore FRAM |
| 23-24 | Dual drive: cancelar / configurar |
| 25 | Copiar recursos de USB a D:\ADT |
| 26 | Home husillo servo |
| 27 | Buscar señal tool setter |
| 28-29 | Soft limits: activar / desactivar |

## Personalización de textos del firmware (nc_res.ncp)

El archivo `nc_res.ncp` (carpeta `D:\ADT` del controlador) contiene la tabla de textos bilingüe que el firmware muestra en pantalla.

### Estructura de cada entrada
```
[Texto chino UTF-8] 0x09 0x3A [Texto inglés ASCII] 0x0D 0x0A
                     TAB  ':'                       CR   LF
```

### Textos personalizados

| Original | Personalizado | Param | Contexto |
|----------|--------------|-------|----------|
| `Safe Single Valid` | `CHUCK ABIERTO!!!!` | Param 029 = `4` (IN04) | Se muestra cuando chuck abierto + START |
| `System [Reset] Exit` | `PULSE RESET!!!!!!!!` | Alarma 0052 | Indica al operador que presione RESET para salir |

### Traducciones SCRAM → EMERG (parada de emergencia)

9 textos traducidos de "SCRAM" a "EMERG" para mayor claridad del operador hispanohablante:

| Original | Traducción | Bytes |
|----------|-----------|-------|
| `035,ExScram2 Check Input` | `035,EmergExt2 NumEntrada` | 24 |
| `SCRAM` (aislado) | `EMERG` | 5 |
| `Scram I61` | `Emerg I61` | 9 |
| `075,SCRAM` | `075,EMERG` | 9 |
| `ScramTheNot` | `EmergInvert` | 11 |
| `088, Handwheel scram` | `088, Emerg. Volante ` | 20 |
| `SCRAM64` | `EMERG64` | 7 |
| `MotionErrScram` | `MotionErrEmerg` | 14 |
| `SCRAM33` | `EMERG33` | 7 |

### Método de personalización
- Reemplazo byte-por-byte (misma longitud exacta) para no alterar la estructura
- Solo se modifica el texto inglés — el texto chino queda intacto
- Respaldo siempre en `nc_res.ncp.bak`
- Para aplicar: copiar `nc_res.ncp` a USB → File Manager del controlador → pegar en `D:\ADT` → reiniciar

### Param 029 — Safe Signal Check Input
- Valor: **`4`** → usa IN04 (sensor de chuck) como señal de seguridad
- Firmware bloquea START cuando IN04=0 (chuck abierto)
- Mensaje original: "Safe Single Valid" → ahora: **"CHUCK ABIERTO!!!!"**

## Convenciones de código

- Comentarios en **chino simplificado** (con equivalente inglés en T_FUNC)
- `M3000` = fin de subprograma (M_FUNC)
- `M30` = fin de programa (T_FUNC)
- `%` = separador entre subprogramas
- `M88` = macro de verificación con timeout (`P`=condición, `L`=valor, `Q`=timeout ms)
