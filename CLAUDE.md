# Macro Torno CNC

Biblioteca de macros G-Code para torno CNC con controlador FANUC-compatible (FCNC4M / ADTECH GNC5620). Sin build system; los archivos `.NC` se cargan directamente al controlador vía USB/serial.

## Archivos del proyecto

| Archivo | Descripción |
|---------|-------------|
| `M_FUNC.NC` | Funciones M (husillo, I/O, LEDs, botones panel, toggles) |
| `T_FUNC (2).NC` | Función de cambio de herramienta (torreta 12 posiciones) |
| `MACRO ADDRESS.xlsx` | Mapa de direcciones de variables macro |
| `MACRO TRAINING.pdf` | Documentación de entrenamiento del controlador |

## Arquitectura de M_FUNC.NC

~1170 líneas, ~40+ subprogramas. Convención de O-codes: **pares = enable, impares = disable**.

### Grupos funcionales

| Rango O-code | Función |
|--------------|---------|
| O0008-O0009 | Refrigerante (M08/M09) |
| O0010-O0011 | Chuck husillo (M10/M11) |
| O0012-O0039 | Relés de salida OUT03-OUT16 |
| O0041-O0044 | Rotación husillo (M03/M04) |
| O0046-O0067 | Botones de función F0-F13 |
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

## Convenciones de código

- Comentarios en **chino simplificado** (con equivalente inglés en T_FUNC)
- `M3000` = fin de subprograma (M_FUNC)
- `M30` = fin de programa (T_FUNC)
- `%` = separador entre subprogramas
- `M88` = macro de verificación con timeout (`P`=condición, `L`=valor, `Q`=timeout ms)
