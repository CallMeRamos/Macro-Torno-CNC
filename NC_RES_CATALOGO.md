# Catalogo de textos personalizables — nc_res.ncp

> Referencia completa de las entradas de texto del firmware ADTECH CNC9620
> que se pueden personalizar para el operador del torno CNC.

## Informacion del archivo

| Campo | Valor |
|-------|-------|
| Archivo | `nc_res.ncp` (10,882,608 bytes) |
| Ubicacion en controlador | `D:\ADT\nc_res.ncp` |
| Total de lineas | 8,607 |
| Entradas con texto ingles | **2,212** |
| Entradas ya personalizadas | **2** |
| Respaldo | `nc_res.ncp.bak` (original sin modificar) |

### Entradas ya personalizadas

| # Linea | Bytes | Texto original | Texto personalizado | Contexto |
|---------|-------|----------------|---------------------|----------|
| 5937 | 17 | `Safe Single Valid` | `CHUCK ABIERTO!!!!` | Param 029=4 |
| 6238 | 19 | `System [Reset] Exit` | `PULSE RESET!!!!!!!!` | Alarma 0052 |

---

## Guia rapida de personalizacion

### Reglas obligatorias

1. **Misma longitud exacta**: El texto de reemplazo DEBE tener **exactamente** los mismos bytes que el original
2. **Solo ASCII**: Caracteres del 32 al 126 (sin tildes, sin enie, sin caracteres especiales)
3. **Rellenar con espacios o signos**: Si el texto nuevo es mas corto, rellenar con espacios o `!`
4. **Nunca mas largo**: Si el reemplazo es mas largo que el original, se corrompe el archivo

### Caracteres permitidos

```
A-Z  a-z  0-9  espacio  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
```

### Workflow de aplicacion

```
1. Editar nc_res.ncp en PC (editor hexadecimal o script)
2. Copiar nc_res.ncp a USB
3. En controlador: File Manager → navegar a USB
4. Copiar a D:\ADT\nc_res.ncp
5. Reiniciar controlador
```

### Snippet Python para verificar longitud

```python
original = 'Safe Single Valid'
nuevo    = 'CHUCK ABIERTO!!!!'
assert len(original) == len(nuevo), f'ERROR: {len(original)} != {len(nuevo)}'
print(f'OK: {len(nuevo)} bytes')
```

---

## Resumen por categoria

| # | Categoria | Prioridad | Entradas | Descripcion |
|---|-----------|-----------|----------|-------------|
| 1 | [Alarmas de seguridad](#safety_alarms) | CRITICA | 32 | Mensajes de seguridad criticos: chuck, husillo, presion, E-stop, limites de ejes |
| 2 | [Errores de ciclos G-code](#gcode_errors) | ALTA | 85 | Errores en ciclos de torneado G71/G72/G74/G75/G76/G92/G32 y codigos G |
| 3 | [Errores de movimiento y programa](#motion_errors) | ALTA | 159 | Limites soft/hard, alarmas servo, abortos de programa, errores de formato |
| 4 | [Errores de macro](#macro_errors) | MEDIA | 29 | Errores de expresiones macro, WHILE, goto, nesting, variables |
| 5 | [Mensajes de husillo](#spindle_messages) | MEDIA | 92 | Velocidad, encoder, orientacion, alarmas de husillo |
| 6 | [Estado del sistema](#system_status) | MEDIA | 203 | Modos de operacion, estado running/ready/stop, version |
| 7 | [Mensajes de herramienta](#tool_messages) | MEDIA | 125 | Cambio de herramienta, offsets, verificacion, tool setter |
| 8 | [Coordenadas y posicion](#coordinates) | BAJA | 66 | G54-G599, posiciones absolutas/relativas/maquina, offsets de ejes |
| 9 | [Operaciones de archivo](#file_operations) | BAJA | 138 | Cargar, guardar, eliminar archivos, USB, carpetas |
| 10 | [Etiquetas I/O](#io_labels) | BAJA | 228 | Nombres de entradas (IN00-IN95) y salidas (OUT00-OUT95) |
| 11 | [Varios / Sistema](#misc) | BAJA | 291 | USB, Modbus, EtherCAT, debug, mensajes varios |
| 12 | [Nombres de parametros](#param_names) | BAJA | 220 | Etiquetas de parametros de configuracion (General, Spindle, Port, Tool, Axis) |
| 13 | [Contrasenas y acceso](#passwords) | BAJA | 22 | Password, superuser, operador, niveles de acceso |
| 14 | [Instrucciones de Teach/programacion guiada](#teach_instruct) | BAJA | 73 | Mensajes del modo Teach-in, spline, arcos, instrucciones de ayuda |
| 15 | [Elementos de interfaz (UI)](#ui_elements) | BAJA | 449 | Menus, botones, soft keys, etiquetas de pantalla |

---

## Alarmas de seguridad <a id="safety_alarms"></a>

**Prioridad**: CRITICA — Mensajes de seguridad criticos: chuck, husillo, presion, E-stop, limites de ejes

**32 entradas**

| # Linea | Bytes | Texto original | Contexto |
|---------|-------|----------------|----------|
| 5289 | 25 | `022,OilPressure Open(min)` | Sensor de presion de aceite |
| 5290 | 25 | `023,OilPressure Keep(sec)` | Sensor de presion de aceite |
| 5291 | 27 | `024,OilPressureOut Freq(Hz)` | Sensor de presion de aceite |
| 5408 | 23 | `002,Tool Safe Signal In` | Param 029 - senal de seguridad |
| 5435 | 27 | `029,Safe Signal Check Input` | Param 029 - senal de seguridad |
| 5437 | 21 | `031,Chuck Alarm Input` | Param 031 - alarma chuck abierto |
| 5438 | 28 | `032,Oil Pressure Alarm Input` | Sensor de presion de aceite |
| 5441 | 24 | `035,ExScram2 Check Input` | Parada de emergencia (E-stop) |
| 5442 | 22 | `036,Cooler Alarm Input` | Alarma de refrigerante |
| 5659 | 5 | `SCRAM` | Parada de emergencia (E-stop) |
| 5666 | 17 | `workpiece no lock` | Chuck no asegurado |
| 5667 | 24 | `safe signal can't detect` | Param 029 - senal de seguridad |
| 5669 | 13 | `air no enough` | Sensor de presion de aire |
| 5670 | 25 | `chuck signal alarm detect` | Param 031 - alarma chuck abierto |
| 5671 | 21 | `OilPressure no enough` | Sensor de presion de aceite |
| 5672 | 20 | `Spindle alarm occurs` | Alarma interna del husillo |
| 5673 | 23 | `Transducer alarm occurs` | Alarma del transductor/variador |
| 5893 | 12 | `Cooler alarm` | Alarma de refrigerante |
| 5901 | 16 | `Chuck unlock err` |  |
| 5937 | 17 | `CHUCK ABIERTO!!!!` ← YA PERSONALIZADO (original: `Safe Single Valid`, Param 029=4) | PERSONALIZADO - Param 029=4 |
| 5999 | 9 | `Scram I61` | Parada de emergencia (E-stop) |
| 6238 | 19 | `PULSE RESET!!!!!!!!` ← YA PERSONALIZADO (original: `System [Reset] Exit`, Alarma 0052) | PERSONALIZADO - Alarma 0052 |
| 6250 | 9 | `075,SCRAM` | Parada de emergencia (E-stop) |
| 6433 | 11 | `ScramTheNot` | Parada de emergencia (E-stop) |
| 6512 | 26 | `External emergency stop109` |  |
| 6670 | 20 | `088, Handwheel scram` | Parada de emergencia (E-stop) |
| 6679 | 7 | `SCRAM64` | Parada de emergencia (E-stop) |
| 6852 | 14 | `MotionErrScram` | Parada de emergencia (E-stop) |
| 6901 | 7 | `SCRAM33` | Parada de emergencia (E-stop) |
| 7113 | 8 | `IN04 EMS` |  |
| 7172 | 31 | `items number for csv incorrect!` |  |
| 7224 | 7 | `EMS I65` |  |

## Errores de ciclos G-code <a id="gcode_errors"></a>

**Prioridad**: ALTA — Errores en ciclos de torneado G71/G72/G74/G75/G76/G92/G32 y codigos G

**85 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 5076 | 44 | `G71 G72 or G73 outline descrip not monotony.` |
| 5077 | 34 | `G71 G72 G73 initial position wrong` |
| 5079 | 32 | `G72 Rough cycle depth of cut Err` |
| 5082 | 24 | `G32 thread process error` |
| 5083 | 24 | `G92 thread process error` |
| 5084 | 33 | `thread process lead can't be zero` |
| 5085 | 50 | `thread process not detect spindle encoder AB phase` |
| 5086 | 31 | `screw process not spindle Z ECZ` |
| 5087 | 53 | `thread process spindle encoder line number can't be 0` |
| 5088 | 57 | `motion or reset alarm abnormal exit during thread process` |
| 5089 | 31 | `taper thread R-value prog error` |
| 5090 | 31 | `G74 radial offset exceeds range` |
| 5091 | 46 | `G74-Z axis depth of cut zero or exceeds range` |
| 5092 | 37 | `G74 radial tool retract exceeds range` |
| 5093 | 60 | `final position of G74-Z axis Unspecified or movement is zero` |
| 5094 | 60 | `final position of G75-X axis Unspecified or movement is zero` |
| 5095 | 45 | `G75 radial cut depth is zero or exceeds range` |
| 5096 | 31 | `G75-Z axis offset exceeds range` |
| 5097 | 36 | `G75 axial tool retract exceeds range` |
| 5100 | 27 | `G90 G92 Z increment is zero` |
| 5282 | 26 | `015,G73(M)LoopObligate(mm)` |
| 5320 | 25 | `053,screw Acc pitch P(mm)` |
| 5321 | 26 | `054,screw slow pitch D(mm)` |
| 5322 | 26 | `055,screw back value V(mm)` |
| 5434 | 31 | `028,sv Spi Rigid tapping output` |
| 5608 | 24 | `Screw Value Repeat Error` |
| 5627 | 22 | `G41G42 StartLine Error` |
| 5628 | 20 | `G41G42 EndLine Error` |
| 5629 | 52 | `G41G42 StartPoint and EndPoint Equation in LastTrack` |
| 5630 | 52 | `G41G42 StartPoint and EndPoint Equation in NextTrack` |
| 5633 | 19 | `NURBS Node too many` |
| 5634 | 16 | `NURBS para error` |
| 5682 | 59 | `G71 G72 FT margin can't be bigger than rough turn cut depth` |
| 5683 | 60 | `thread or tap process spindle encoder line number can't be 0` |
| 5684 | 29 | `G33 tap order execution error` |
| 5724 | 53 | `G32 long axis greater than lead of screw thread error` |
| 5725 | 53 | `G92 long axis greater than lead of screw thread error` |
| 5726 | 27 | `G76 Z increment value error` |
| 5727 | 24 | `G76 starting point error` |
| 5728 | 28 | `G76 screw tooth high is zero` |
| 5729 | 19 | `G76 FT margin error` |
| 5730 | 13 | `G76 DOC error` |
| 5731 | 21 | `G76 screw pitch error` |
| 5833 | 238 | `Which time input M98 start circulation processing?(If it input 0, it will skip to the given of b112eginning prcess113,Y ScrewPitch Compensate EN line no.direct114,Z ScrewPitch Compensate ENly in main prog115,A ScrewPitch Compensate ENram)` |
| 6229 | 18 | `ScrewPitch Comp EN` |
| 6230 | 22 | `ScrewPitch Spacing(mm)` |
| 6231 | 24 | `ScrewPitch Start Pos(mm)` |
| 6232 | 22 | `ScrewPitch End Pos(mm)` |
| 6411 | 22 | `MultipleThreadStartErr` |
| 6592 | 23 | `rigidity tapping output` |
| 6712 | 11 | `022,TapMode` |
| 6713 | 14 | `023,TapAdcMode` |
| 6714 | 16 | `024,TapIfEncode?` |
| 6715 | 19 | `025,TapFPGASetSPeed` |
| 6716 | 18 | `026,TapAccFilterEn` |
| 6717 | 14 | `027,TapParamKp` |
| 6718 | 14 | `028,TapParamKi` |
| 6719 | 14 | `029,TapParamKd` |
| 6720 | 20 | `030,TapParamKdFilter` |
| 6721 | 19 | `031,TapParamKilimit` |
| 6722 | 19 | `032,TapParamKdLimit` |
| 6723 | 14 | `033,TapParamK2` |
| 6724 | 15 | `034,TapPreDelay` |
| 6725 | 18 | `035,TapReturnDelay` |
| 6726 | 18 | `036,TapCollectData` |
| 6727 | 16 | `037,TapMaxErrVal` |
| 6864 | 17 | `MotionErrRigidTap` |
| 6867 | 17 | `MotionErrRigidTap` |
| 6899 | 8 | `TapDelay` |
| 6903 | 9 | `TapMaxErr` |
| 6904 | 9 | `TapDynErr` |
| 6906 | 15 | `TapEncoderTotal` |
| 6907 | 16 | `TapSpEncoderVal0` |
| 6908 | 16 | `TapSpEncoderVal1` |
| 6909 | 14 | `TapEncoderVal0` |
| 6910 | 14 | `TapEncoderVal1` |
| 6911 | 12 | `TapFollowErr` |
| 6913 | 25 | `G01 Rolling Path Optimize` |
| 7063 | 17 | `36.GG taper depth` |
| 7064 | 14 | `GG taper depth` |
| 7065 | 19 | `37.G Agl TaperDepth` |
| 7066 | 16 | `G Agl TaperDepth` |
| 7154 | 17 | `36.GG Taper depth` |
| 7155 | 14 | `GG Taper depth` |
| 7257 | 27 | `Real time error of tapping:` |

## Errores de movimiento y programa <a id="motion_errors"></a>

**Prioridad**: ALTA — Limites soft/hard, alarmas servo, abortos de programa, errores de formato

**159 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 4940 | 28 | `axis No redefine error,check` |
| 5227 | 62 | `file name format error, file name consist by number and letter` |
| 5310 | 22 | `043,abnormal memory En` |
| 5384 | 21 | `020,Spi.Servo HomeDir` |
| 5391 | 29 | `027,servo spindle ready level` |
| 5392 | 31 | `028,servo spi stop to pos level` |
| 5393 | 30 | `029,servo spi zero speed level` |
| 5416 | 25 | `010,Servo Spi ready input` |
| 5417 | 24 | `011,Servo Spi stop input` |
| 5418 | 30 | `012,Servo Spi zero speed input` |
| 5419 | 31 | `013,Servo Spi speed reach input` |
| 5431 | 23 | `025,Servo Spi En Output` |
| 5432 | 25 | `026,Servo Spi Stop Output` |
| 5433 | 26 | `027,Servo Spi Pulse Output` |
| 5471 | 21 | `049,X Servo En Output` |
| 5472 | 25 | `Y Servo En Output` |
| 5473 | 25 | `Z Servo En Output` |
| 5474 | 25 | `4 Servo En Output` |
| 5475 | 25 | `B Servo En Output` |
| 5476 | 25 | `C Servo En Output` |
| 5571 | 16 | `M98 Format Error` |
| 5572 | 16 | `Motion Run Error` |
| 5574 | 22 | `G Program Format Error` |
| 5575 | 21 | `M99 Instruction Abort` |
| 5576 | 12 | `Motion Abort` |
| 5577 | 12 | `Illegal char` |
| 5579 | 14 | `Illegal G Code` |
| 5580 | 26 | `GCode RadialOffset Num Err` |
| 5581 | 31 | `Noneffective GCode RadialOffset` |
| 5582 | 19 | `Arc Appointed Error` |
| 5584 | 21 | `M98 Instruction Abort` |
| 5586 | 23 | `MCode Instruction Abort` |
| 5588 | 21 | `Motion Repeat Request` |
| 5590 | 20 | `Missing X Code Error` |
| 5591 | 20 | `Missing Y Code Error` |
| 5592 | 20 | `Missing Z Code Error` |
| 5593 | 20 | `Missing A Code Error` |
| 5594 | 20 | `Missing B Code Error` |
| 5595 | 20 | `Missing C Code Error` |
| 5596 | 20 | `Missing D Code Error` |
| 5597 | 20 | `Missing R Code Error` |
| 5598 | 20 | `Missing F Code Error` |
| 5599 | 20 | `Missing T Code Error` |
| 5600 | 20 | `Missing S Code Error` |
| 5601 | 20 | `Missing P Code Error` |
| 5602 | 20 | `Missing M Code Error` |
| 5603 | 20 | `Missing G Code Error` |
| 5604 | 20 | `Missing I Code Error` |
| 5605 | 20 | `Missing J Code Error` |
| 5606 | 20 | `Missing K Code Error` |
| 5607 | 20 | `Missing Q Code Error` |
| 5609 | 12 | `System Abort` |
| 5610 | 17 | `Factitious return` |
| 5625 | 31 | `The i_gcode Error in Last track` |
| 5626 | 31 | `The i_gcode Error in Next track` |
| 5631 | 41 | `Radii Expiate Value BigThan Program for R` |
| 5632 | 37 | `Radii Expiate Can't Support This Code` |
| 5637 | 16 | `no U order error` |
| 5638 | 16 | `no W order error` |
| 5640 | 18 | `multi M code error` |
| 5643 | 27 | `4 - direction program limit` |
| 5644 | 27 | `4 + direction program limit` |
| 5645 | 27 | `Z - direction program limit` |
| 5646 | 27 | `Z + direction program limit` |
| 5647 | 27 | `Y - direction program limit` |
| 5648 | 27 | `Y + direction program limit` |
| 5649 | 27 | `X - direction program limit` |
| 5650 | 27 | `X + direction program limit` |
| 5651 | 27 | `4 - direction machine limit` |
| 5652 | 27 | `4 + direction machine limit` |
| 5653 | 27 | `Z - direction machine limit` |
| 5654 | 27 | `Z + direction machine limit` |
| 5655 | 27 | `Y - direction machine limit` |
| 5656 | 27 | `Y + direction machine limit` |
| 5657 | 27 | `X - direction machine limit` |
| 5658 | 27 | `X + direction machine limit` |
| 5660 | 20 | `X Sevor driver alarm` |
| 5661 | 20 | `Y Sevor driver alarm` |
| 5662 | 20 | `Z Sevor driver alarm` |
| 5663 | 20 | `A Sevor driver alarm` |
| 5664 | 29 | `Axis's physical line redefine` |
| 5681 | 28 | `addition panel abnormal work` |
| 5689 | 21 | `preprocessing Lib Ver` |
| 5690 | 20 | `Abnormal memory code` |
| 5691 | 66 | `Processing abnormalities, whether the line to jump to an exception` |
| 5715 | 33 | `Format error,whether to re-enter?` |
| 5717 | 29 | `preprocessing exception error` |
| 5718 | 53 | `Program coordinates the value of super-soft limit set` |
| 6068 | 24 | `B - direction soft limit` |
| 6069 | 24 | `B + direction soft limit` |
| 6070 | 24 | `C - direction soft limit` |
| 6071 | 24 | `C + direction soft limit` |
| 6072 | 27 | `B - direction machine limit` |
| 6073 | 27 | `B + direction machine limit` |
| 6074 | 27 | `C - direction machine limit` |
| 6075 | 27 | `C + direction machine limit` |
| 6076 | 20 | `B Sevor driver alarm` |
| 6077 | 20 | `C Sevor driver alarm` |
| 6207 | 19 | `ServoAlarmIn ELevel` |
| 6208 | 19 | `ServoResetOut ELeve` |
| 6224 | 14 | `Servo Home Dir` |
| 6254 | 27 | `7 - direction program limit` |
| 6255 | 27 | `7 + direction program limit` |
| 6256 | 27 | `8 - direction program limit` |
| 6257 | 27 | `8 + direction program limit` |
| 6258 | 27 | `7 - direction machine limit` |
| 6259 | 27 | `7 + direction machine limit` |
| 6260 | 27 | `8 - direction machine limit` |
| 6261 | 27 | `8 + direction machine limit` |
| 6262 | 20 | `7 Sevor driver alarm` |
| 6263 | 20 | `8 Sevor driver alarm` |
| 6271 | 17 | `7 Servo En Output` |
| 6272 | 17 | `8 Servo En Output` |
| 6445 | 31 | `Spindle non-servo spindle error` |
| 6446 | 42 | `not configured servo position signal input` |
| 6480 | 25 | `X1 - direction soft limit` |
| 6481 | 25 | `X1 + direction soft limit` |
| 6482 | 25 | `Y1 - direction soft limit` |
| 6483 | 25 | `Y1 + direction soft limit` |
| 6484 | 28 | `X1 - direction machine limit` |
| 6485 | 28 | `X1 + direction machine limit` |
| 6486 | 28 | `Y1 - direction machine limit` |
| 6487 | 28 | `Y1 + direction machine limit` |
| 6488 | 21 | `X1 Sevor driver alarm` |
| 6489 | 21 | `Y1 Sevor driver alarm` |
| 6490 | 25 | `Z1 - direction soft limit` |
| 6491 | 25 | `A1 - direction soft limit` |
| 6492 | 25 | `B1 - direction soft limit` |
| 6493 | 25 | `C1 - direction soft limit` |
| 6494 | 25 | `Z1 + direction soft limit` |
| 6495 | 25 | `A1 + direction soft limit` |
| 6496 | 25 | `B1 + direction soft limit` |
| 6497 | 25 | `C1 + direction soft limit` |
| 6498 | 28 | `Z1 - direction machine limit` |
| 6499 | 28 | `A1 - direction machine limit` |
| 6500 | 28 | `B1 - direction machine limit` |
| 6501 | 28 | `C1 - direction machine limit` |
| 6502 | 28 | `Z1 + direction machine limit` |
| 6503 | 28 | `A1 + direction machine limit` |
| 6504 | 28 | `B1 + direction machine limit` |
| 6505 | 28 | `C1 + direction machine limit` |
| 6506 | 21 | `Z1 Sevor driver alarm` |
| 6507 | 21 | `A1 Sevor driver alarm` |
| 6508 | 21 | `B1 Sevor driver alarm` |
| 6509 | 21 | `C1 Sevor driver alarm` |
| 6572 | 32 | `008,Zero soft limit alarm not en` |
| 6574 | 29 | `077,Abnormal jump config(bit)` |
| 6579 | 15 | `Servo en output` |
| 6580 | 17 | `Servo alarm input` |
| 6581 | 18 | `Servo reset output` |
| 6585 | 17 | `Servo device addr` |
| 6590 | 17 | `Servo stop output` |
| 6591 | 26 | `Servo control pulse output` |
| 6770 | 16 | `AbsServoInitFail` |
| 6882 | 5 | `Servo` |
| 6883 | 6 | `ServoP` |
| 7178 | 12 | `update servo` |
| 7210 | 15 | `servo type erro` |
| 7261 | 21 | `Modbus Commu abnormal` |

## Errores de macro <a id="macro_errors"></a>

**Prioridad**: MEDIA — Errores de expresiones macro, WHILE, goto, nesting, variables

**29 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 4977 | 37 | `macroparameter local variable 1 floor` |
| 4978 | 37 | `macroparameter local variable 2 floor` |
| 4979 | 37 | `macroparameter local variable 3 floor` |
| 4980 | 37 | `macroparameter local variable 4 floor` |
| 4981 | 37 | `macroparameter local variable 5 floor` |
| 4982 | 21 | `macro para global var` |
| 5040 | 39 | `macro-variable add: mismatch,can't load` |
| 5251 | 5 | `Macro` |
| 5351 | 27 | `017,macro key word valid En` |
| 5613 | 19 | `Call false in Macro` |
| 5614 | 22 | `Macro expression error` |
| 5615 | 21 | `MacroValue addr error` |
| 5617 | 9 | `goto fail` |
| 5618 | 28 | `WHILE key \"[ ]\" pair error` |
| 5619 | 23 | `\"WHILE\"  Nested error` |
| 5620 | 26 | `SubProgram Nested too much` |
| 5621 | 34 | `no def macro value getaddrfunction` |
| 5624 | 19 | `Constant Call Error` |
| 5636 | 38 | `Composite program has expression error` |
| 5639 | 32 | `multiple G code expression error` |
| 5641 | 44 | `custom macro prog repeat call times overflow` |
| 6304 | 21 | `Macro function error!` |
| 6305 | 25 | `Undefined macro function!` |
| 6378 | 23 | `MacroFuncParameterError` |
| 6379 | 24 | `UndefinedMacroFuncError` |
| 6408 | 12 | `MacroFuncSel` |
| 6410 | 13 | `MacroFuncUser` |
| 6477 | 35 | `Macro Definition Information Output` |
| 7236 | 33 | `056Double G Start close meanwhile` |

## Mensajes de husillo <a id="spindle_messages"></a>

**Prioridad**: MEDIA — Velocidad, encoder, orientacion, alarmas de husillo

**92 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 5028 | 8 | `SPI rate` |
| 5150 | 9 | `SPI Cw 00` |
| 5151 | 10 | `SPI Ccw 01` |
| 5288 | 22 | `021,SpindleControlMode` |
| 5325 | 23 | `058,SPI Brake Delay(ms)` |
| 5328 | 26 | `061,Hand Wheel Encoder Dir` |
| 5364 | 7 | `Spindle` |
| 5365 | 30 | `001,spindle assign port axis #` |
| 5378 | 22 | `014,Spi.Encode bits(p)` |
| 5389 | 25 | `025,Spi.Encoder Logic Dir` |
| 5394 | 28 | `030,sv spi speed reach level` |
| 5395 | 21 | `031,Spi Current Speed` |
| 5396 | 26 | `032,Auto Stop Close Spi En` |
| 5397 | 21 | `033,Spi Minimum Speed` |
| 5398 | 28 | `034,Second Spi Maximum Speed` |
| 5399 | 20 | `034,Second Spi Speed` |
| 5400 | 30 | `036,Spi CodeCommand Invalid En` |
| 5401 | 25 | `037,Machine Spi One Speed` |
| 5402 | 25 | `038,Machine Spi Two Speed` |
| 5403 | 27 | `039,Machine Spi Three Speed` |
| 5404 | 26 | `040,Machine Spi Four Speed` |
| 5405 | 26 | `041,Spindle Stop Delay(ms)` |
| 5414 | 22 | `008,Spi Alarm Check In` |
| 5424 | 21 | `018,Spindle CW Output` |
| 5425 | 22 | `019,Spindle CCW Output` |
| 5426 | 22 | `020,Spindle2 CW Output` |
| 5427 | 23 | `021,Spindle2 CCW Output` |
| 5429 | 23 | `023,Spindle Blow Output` |
| 5430 | 24 | `024,Spindle Brake Output` |
| 5498 | 23 | `Spindle Blow Hold(#410)` |
| 5510 | 7 | `Spindle` |
| 5511 | 7 | `Spindle` |
| 5512 | 7 | `Spindle` |
| 5585 | 30 | `Spindle Appointed Number Error` |
| 5587 | 17 | `Spi Appointed Err` |
| 5665 | 14 | `spi no to home` |
| 5794 | 6 | `DA (G)` |
| 5795 | 7 | `SPI (X)` |
| 5796 | 8 | `SPI Info` |
| 5797 | 9 | `SPI Speed` |
| 5798 | 15 | `SPI Encode bits` |
| 5799 | 12 | `SPI Position` |
| 5800 | 9 | `SPI Angle` |
| 5803 | 99 | `Stop and EDIT,Press the 'S',enter the num zero by Z-phase,manually test the spindle before turning.` |
| 5865 | 18 | `Spindle Speed(rpm)` |
| 5903 | 8 | `SPI 2 Cw` |
| 5904 | 9 | `SPI 2 Ccw` |
| 6187 | 21 | `043,Spindle Auto Open` |
| 6188 | 22 | `044,Spindle Auto Close` |
| 6192 | 26 | `042,Alarm Close Spindle En` |
| 6217 | 14 | `Encoder bit(p)` |
| 6294 | 24 | `Spindle sampl period(ms)` |
| 6295 | 23 | `Spindle  record time(s)` |
| 6302 | 22 | `Save D Disk SPI_AB.CSV` |
| 6303 | 22 | `T Key Spindle sampling` |
| 6418 | 12 | `SpindleOtime` |
| 6539 | 12 | `Spindle axis` |
| 6540 | 15 | `Spindle channel` |
| 6550 | 11 | `Encoder pos` |
| 6587 | 30 | `Abs encoder calibration origin` |
| 6593 | 19 | `spindle ready input` |
| 6594 | 23 | `spindle must stop input` |
| 6595 | 24 | `spindle zero speed input` |
| 6596 | 19 | `spindle speed input` |
| 6611 | 27 | `003, Spindle max speed(rpm)` |
| 6612 | 27 | `004, Spindle time delay(ms)` |
| 6613 | 18 | `005, Spindle speed` |
| 6614 | 24 | `006, Pause close spindle` |
| 6615 | 28 | `007, Spindle min speed(rpm)` |
| 6616 | 29 | `008, 2 spindle max speed(rpm)` |
| 6617 | 20 | `009, 2 spindle speed` |
| 6618 | 25 | `010, Spindle S invalid En` |
| 6619 | 25 | `011, spindle 2 speed(rpm)` |
| 6620 | 25 | `012, spindle 2 speed(rpm)` |
| 6621 | 25 | `013, spindle 3 speed(rpm)` |
| 6622 | 25 | `014, spindle 4 speed(rpm)` |
| 6623 | 28 | `015, Spindle stop delay(ms)` |
| 6624 | 28 | `016, Alarm closed spindle En` |
| 6625 | 22 | `017, Spindle auto open` |
| 6626 | 22 | `018, Spindle auto stop` |
| 6627 | 25 | `019, Spindle pulse number` |
| 6628 | 27 | `020, Spindle Gear Numerator` |
| 6629 | 29 | `021, Spindle Gear Denominator` |
| 6686 | 19 | `HandwheelEncoderVal` |
| 6890 | 18 | `AbsoluteEncoderErr` |
| 6905 | 8 | `SpindleS` |
| 6918 | 28 | `AbsoluteEncoderTurnsPosition` |
| 6919 | 28 | `AbsoluteEncoderTurnsPositio2` |
| 7128 | 11 | `OUT00 Spi +` |
| 7129 | 11 | `OUT02 Spi -` |
| 7263 | 16 | `Spi follow error` |
| 7266 | 17 | `Num turns encoder` |

## Estado del sistema <a id="system_status"></a>

**Prioridad**: MEDIA — Modos de operacion, estado running/ready/stop, version

**203 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 4917 | 8 | `StepOver` |
| 4918 | 5 | `Stop` |
| 4919 | 8 | `Running` |
| 4920 | 6 | `Pause` |
| 4921 | 5 | `Close` |
| 4922 | 4 | `EDIT` |
| 4923 | 3 | `MPG` |
| 4924 | 4 | `STEP` |
| 4925 | 4 | `AUTO` |
| 4926 | 3 | `JOG` |
| 4927 | 4 | `HOME` |
| 4928 | 10 | `CNC READY!` |
| 4929 | 11 | `System VER:` |
| 4930 | 10 | `BuildData:` |
| 4931 | 9 | `FPGA VER:` |
| 4932 | 9 | `DLIB VER:` |
| 4933 | 9 | `GLIB VER:` |
| 4939 | 21 | `system history alarm` |
| 4947 | 18 | `jump in auto mode?` |
| 4952 | 15 | `start MDI prog?` |
| 5029 | 8 | `JOG rate` |
| 5030 | 8 | `JOG rate` |
| 5037 | 13 | `close system?` |
| 5044 | 4 | `Edit` |
| 5105 | 4 | `Edit` |
| 5131 | 8 | `MPG1 I24` |
| 5132 | 8 | `MPGX I25` |
| 5133 | 8 | `MPG2 I26` |
| 5134 | 8 | `MPGY I27` |
| 5135 | 8 | `MPG3 I28` |
| 5136 | 8 | `MPGZ I29` |
| 5138 | 8 | `MPGA I31` |
| 5139 | 9 | `pause I32` |
| 5140 | 8 | `stop I33` |
| 5141 | 10 | `Xalarm I34` |
| 5142 | 10 | `Yalarm I35` |
| 5143 | 10 | `Zalarm I36` |
| 5144 | 10 | `Aalarm I37` |
| 5190 | 52 | `TSysParam verify error, sys auto recovery to Default` |
| 5191 | 54 | `TKnifeParam verify error, sys auto recovery to Default` |
| 5195 | 9 | `Prog edit` |
| 5199 | 4 | `Edit` |
| 5200 | 3 | `MDI` |
| 5201 | 11 | `MDI running` |
| 5254 | 12 | `(X)Close Sys` |
| 5256 | 32 | `2 Y HOME move over,To Z,X pos...` |
| 5257 | 32 | `2 X HOME move over,To Y,Z pos...` |
| 5258 | 32 | `2 Z HOME move over,To X,Y pos...` |
| 5263 | 12 | `5 back HOME!` |
| 5275 | 23 | `008,MaxMPGSpeed(mm/min)` |
| 5292 | 26 | `025,BackHome ModeConf(bit)` |
| 5298 | 24 | `031,HOME Check for alarm` |
| 5299 | 21 | `032,HOME Check Enable` |
| 5315 | 23 | `048,HOME Mode Cls coord` |
| 5366 | 20 | `002,Spi.Alarm ELevel` |
| 5368 | 24 | `004,,Spi.ECZ Home Enable` |
| 5375 | 23 | `011,Spi.HomeDect ELevel` |
| 5376 | 24 | `012,Spi.ExtHome Check En` |
| 5383 | 19 | `019,Spi.Ext HomeDir` |
| 5386 | 23 | `022,Spi.Home Speed(rpm)` |
| 5415 | 29 | `009,Transduser Alarm Check In` |
| 5428 | 29 | `022,Transduser Alarm Rest Out` |
| 5436 | 28 | `030,Air Pressure Alarm Input` |
| 5440 | 24 | `034,ExPause2 Check Input` |
| 5443 | 22 | `037,Oiling Alarm Input` |
| 5446 | 21 | `040,AlarmLight Output` |
| 5448 | 20 | `042,StopLight Output` |
| 5449 | 25 | `043,SYS ReadyLight Output` |
| 5465 | 20 | `048,X Ext Home Input` |
| 5466 | 24 | `Y Ext Home Input` |
| 5467 | 24 | `Z Ext Home Input` |
| 5468 | 24 | `4 Ext Home Input` |
| 5469 | 24 | `B Ext Home Input` |
| 5470 | 24 | `C Ext Home Input` |
| 5528 | 59 | `if find old version backup file, recover automatic,comfirm?` |
| 5529 | 36 | `sys start auto recover para,comfirm?` |
| 5544 | 45 | `must call in state file in stop and auto mode` |
| 5554 | 17 | `sys unknown alarm` |
| 5569 | 30 | `Appointed M01 Instruction Stop` |
| 5622 | 16 | `userdefine alarm` |
| 5623 | 16 | `userdefine alarm` |
| 5733 | 68 | `2&gt; F2: G code: the form data to G code mode is 0 invalid (EDIT mode)` |
| 5735 | 55 | `4&gt; F4:Del: delete the whole instruct data(EDIT/JOG/MPG)` |
| 5736 | 53 | `5&gt; F5:Save: save the form file to DAT file(EDIT mode)` |
| 5738 | 49 | `7&gt; F7: Load: upload DAT file into form(EDIT mode)` |
| 5739 | 73 | `8&gt; F8: Ins line: insert at currtent chosen line's previous row(EDIT mode)` |
| 5740 | 62 | `9&gt; F9: Del line:  delete the current chosen line(EDIT/JOG/MPG)` |
| 5741 | 53 | `10&gt; press XYZA key lock coord under JOG hand MPG mode` |
| 5744 | 54 | `13&gt;Press[EOB] enter EDIT interface before write G code` |
| 5745 | 50 | `14&gt; [EDIT] mode: insert a line before select [EOB]` |
| 5746 | 47 | `15&gt;[EDIT/JOG/MPG] mode:[CAN] delete select line` |
| 5747 | 60 | `16&gt;[S] save instruct data:[O] load instruct file;(EDIT mode)` |
| 5756 | 64 | `G code mode: pls type-in EDIT mode, and press end key to confirm` |
| 5838 | 10 | `(7)MPG RUN` |
| 5881 | 34 | `Hole Bottom, pause time(M=4 valid)` |
| 5887 | 7 | `Non  RZ` |
| 5888 | 9 | `Prompt RZ` |
| 5889 | 7 | `Auto RZ` |
| 5890 | 71 | `Note that this parameter is set after a system restart after auto-zero?` |
| 5898 | 43 | `resume the running state of the breakpoint?` |
| 5899 | 7 | `Pos mem` |
| 5900 | 7 | `Sta mem` |
| 5924 | 29 | `1,move A axis to machine home` |
| 5935 | 9 | `prog home` |
| 5936 | 8 | `mac home` |
| 5946 | 10 | `X Home I08` |
| 5947 | 10 | `Y Home I09` |
| 5948 | 10 | `Z Home I10` |
| 5949 | 10 | `A Home I11` |
| 5950 | 10 | `B Home I12` |
| 5951 | 10 | `C Home I13` |
| 6004 | 11 | `X Alarm I66` |
| 6005 | 11 | `Y Alarm I67` |
| 6006 | 11 | `Z Alarm I68` |
| 6007 | 11 | `A Alarm I69` |
| 6008 | 11 | `B Alarm I70` |
| 6009 | 11 | `C Alarm I71` |
| 6082 | 13 | `Custom Alarm4` |
| 6083 | 13 | `Custom Alarm5` |
| 6084 | 13 | `Custom Alarm6` |
| 6085 | 13 | `Custom Alarm7` |
| 6086 | 13 | `Custom Alarm8` |
| 6087 | 13 | `Custom Alarm9` |
| 6088 | 14 | `Custom Alarm10` |
| 6089 | 14 | `Custom Alarm11` |
| 6090 | 14 | `Custom Alarm12` |
| 6091 | 14 | `Custom Alarm13` |
| 6092 | 14 | `Custom Alarm14` |
| 6093 | 14 | `Custom Alarm15` |
| 6094 | 14 | `Custom Alarm16` |
| 6097 | 12 | `Close System` |
| 6098 | 7 | `MPG Run` |
| 6179 | 20 | `home deviation alarm` |
| 6202 | 7 | `HomeDir` |
| 6204 | 17 | `JOG Speed(mm/min)` |
| 6209 | 15 | `ECZ Home Enable` |
| 6210 | 15 | `ECZ Home ELevel` |
| 6214 | 15 | `Ext Home ELevel` |
| 6225 | 15 | `Ext Home Eanble` |
| 6227 | 10 | `HomeSpeed2` |
| 6228 | 10 | `HomeSpeed3` |
| 6234 | 8 | `JogSpeed` |
| 6239 | 30 | `Spinlde Current overload alarm` |
| 6251 | 8 | `074,STOP` |
| 6253 | 21 | `Alarm Quit Line GCode` |
| 6269 | 16 | `7 Ext Home Input` |
| 6270 | 16 | `8 Ext Home Input` |
| 6275 | 22 | `076,X axis Alarm Input` |
| 6276 | 18 | `Y axis Alarm Input` |
| 6277 | 18 | `Z axis Alarm Input` |
| 6278 | 18 | `4 axis Alarm Input` |
| 6279 | 18 | `B axis Alarm Input` |
| 6280 | 18 | `C axis Alarm Input` |
| 6281 | 18 | `7 axis Alarm Input` |
| 6282 | 18 | `8 axis Alarm Input` |
| 6306 | 26 | `067, automatic arc enabled` |
| 6307 | 29 | `068, automatic arc value (mm)` |
| 6308 | 32 | `069, coordinate automatic  knife` |
| 6323 | 58 | `Move the cursor to the end of the block,Then press [EDIT].` |
| 6324 | 58 | `Move the cursor to the end of the block,Then press [EDIT].` |
| 6380 | 24 | `067,ChamferOrAutomaticEn` |
| 6381 | 26 | `068,ChamferOrAutomatic(mm)` |
| 6424 | 8 | `TNotStop` |
| 6442 | 9 | `AutoAngle` |
| 6443 | 7 | `AutoArc` |
| 6462 | 12 | `ProgramEdit2` |
| 6463 | 5 | `Edit2` |
| 6515 | 13 | `Axis alarm119` |
| 6516 | 13 | `SystemAlarm17` |
| 6517 | 13 | `SystemAlarm18` |
| 6518 | 13 | `SystemAlarm19` |
| 6519 | 13 | `SystemAlarm20` |
| 6520 | 13 | `SystemAlarm21` |
| 6521 | 13 | `SystemAlarm22` |
| 6522 | 13 | `SystemAlarm23` |
| 6523 | 13 | `SystemAlarm24` |
| 6524 | 13 | `SystemAlarm25` |
| 6525 | 13 | `SystemAlarm26` |
| 6526 | 13 | `SystemAlarm27` |
| 6527 | 13 | `SystemAlarm28` |
| 6528 | 13 | `SystemAlarm29` |
| 6529 | 13 | `SystemAlarm30` |
| 6530 | 13 | `SystemAlarm31` |
| 6566 | 7 | `STEP eM` |
| 6671 | 8 | `MPG1 I56` |
| 6672 | 8 | `MPGX I57` |
| 6673 | 8 | `MPG2 I58` |
| 6674 | 8 | `MPGY I59` |
| 6675 | 8 | `MPG3 I60` |
| 6676 | 8 | `MPGZ I61` |
| 6677 | 8 | `MPGC I62` |
| 6678 | 8 | `MPGA I63` |
| 6846 | 17 | `MotionErrAxisStop` |
| 7159 | 26 | `Data Backup,Auto overwrite` |
| 7165 | 26 | `Data Backup,Auto overwrite` |
| 7223 | 8 | `STOP I64` |
| 7239 | 25 | `030,Air alarm input port` |
| 7242 | 27 | `091,Ext pause 1 input port` |
| 7243 | 26 | `092,Ext pause 2 input port` |
| 7247 | 27 | `096,stop light output 2port` |
| 7259 | 28 | `Modbus ext_output comu alarm` |
| 7260 | 28 | `Modbus ext_intput comu alarm` |
| 7556 | 3 | `MDI` |

## Mensajes de herramienta <a id="tool_messages"></a>

**Prioridad**: MEDIA — Cambio de herramienta, offsets, verificacion, tool setter

**125 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 4988 | 26 | `search tool set coordinate` |
| 5014 | 34 | `start auto search tool set device?` |
| 5016 | 9 | `offset No` |
| 5017 | 7 | `tool No` |
| 5018 | 13 | `length offset` |
| 5019 | 8 | `R offset` |
| 5233 | 5 | `T Cut` |
| 5236 | 6 | `TCheck` |
| 5255 | 56 | `can't change frame when tool setting,press reset to exit` |
| 5259 | 51 | `3 X,Y coord in place, searching tool setting device` |
| 5260 | 51 | `3 Z,X coord in place, searching tool setting device` |
| 5261 | 51 | `3 Y,Z coord in place, searching tool setting device` |
| 5262 | 48 | `4 comfirm tool setting device in place,resetting` |
| 5300 | 26 | `033,X diameter prog enable` |
| 5379 | 21 | `015,Spi.ZeroOffset(p)` |
| 5407 | 27 | `001,Tool Checking signal In` |
| 5409 | 20 | `003,Tool Changer Out` |
| 5410 | 30 | `004,Tool Changer Dustproof Out` |
| 5411 | 29 | `005,Tool Changer Dustproof In` |
| 5412 | 20 | `006,Tool Limit Input` |
| 5413 | 20 | `007,Tool Blow Output` |
| 5445 | 22 | `039,Tool Locking Input` |
| 5487 | 22 | `Current Tool No(#4120)` |
| 5488 | 20 | `Tool Max Count(#400)` |
| 5492 | 22 | `Tool Safe Height(#404)` |
| 5493 | 22 | `Tool Rapid Speed(#405)` |
| 5494 | 21 | `Tool Slow Speed(#406)` |
| 5496 | 15 | `Tool Pos2(#408)` |
| 5497 | 15 | `Tool pos3(#409)` |
| 5501 | 19 | `Tool Interval(#413)` |
| 5502 | 22 | `Stuck Pos Offset(#414)` |
| 5506 | 21 | `Tool Bit Elevel(#404)` |
| 5513 | 5 | `Tools` |
| 5514 | 4 | `Tool` |
| 5515 | 4 | `Tool` |
| 5563 | 12 | `Tool Invalid` |
| 5674 | 13 | `PutTools Fail` |
| 5675 | 13 | `GetTools Fail` |
| 5676 | 22 | `ToolsDoor Can't detect` |
| 5677 | 16 | `bayonet lock err` |
| 5678 | 14 | `knife-song err` |
| 5680 | 22 | `TCheck Error for Limit` |
| 5693 | 12 | `current tool` |
| 5694 | 5 | `Diame` |
| 5697 | 9 | `Cut Diame` |
| 5698 | 7 | `Cut Len` |
| 5699 | 20 | `Input X Diame offset` |
| 5700 | 18 | `Input Z Len offset` |
| 5701 | 14 | `Input T Radius` |
| 5702 | 11 | `Input T Dir` |
| 5703 | 43 | `T after cutting the value of the measured D` |
| 5704 | 12 | `current tool` |
| 5706 | 5 | `T cut` |
| 5707 | 45 | `T after cutting the value of the measured Len` |
| 5734 | 64 | `3&gt; F3: Cur Pos: tool will move to the current form's coord value` |
| 5808 | 22 | `Is not enabled TCheck?` |
| 5809 | 6 | `Offset` |
| 5810 | 8 | `X Offset` |
| 5811 | 8 | `Y Offset` |
| 5812 | 8 | `Z Offset` |
| 5813 | 8 | `A Offset` |
| 5814 | 8 | `B Offset` |
| 5815 | 8 | `C Offset` |
| 5862 | 14 | `T Diameter(mm)` |
| 6112 | 6 | `Tool +` |
| 6113 | 6 | `Tool -` |
| 6116 | 11 | `Tool Seting` |
| 6117 | 17 | `01,X Coord Offset` |
| 6118 | 17 | `02,Y Coord Offset` |
| 6119 | 17 | `03,Z Coord Offset` |
| 6120 | 17 | `04,A Coord Offset` |
| 6121 | 17 | `05,B Coord Offset` |
| 6122 | 17 | `06,C Coord Offset` |
| 6123 | 15 | `07,Tool X Coord` |
| 6124 | 15 | `08,Tool Y Coord` |
| 6125 | 15 | `09,Tool Z Coord` |
| 6126 | 15 | `10,Tool A Coord` |
| 6127 | 15 | `11,Tool B Coord` |
| 6128 | 15 | `12,Tool C Coord` |
| 6129 | 19 | `13,Tool Axis Select` |
| 6130 | 30 | `14,ToolChecking RunAfter TCode` |
| 6131 | 23 | `15,ToolChecking Limit X` |
| 6132 | 23 | `16,ToolChecking Limit Y` |
| 6133 | 23 | `17,ToolChecking Limit Z` |
| 6134 | 23 | `18,ToolChecking Limit A` |
| 6135 | 23 | `19,ToolChecking Limit B` |
| 6136 | 23 | `20,ToolChecking Limit C` |
| 6137 | 26 | `21,Tool Search X Direction` |
| 6138 | 26 | `22,Tool Search Y Direction` |
| 6139 | 26 | `23,Tool Search Z Direction` |
| 6140 | 26 | `24,Tool Search A Direction` |
| 6141 | 26 | `25,Tool Search B Direction` |
| 6142 | 26 | `26,Tool Search C Direction` |
| 6143 | 21 | `27,Auto Add Offset En` |
| 6144 | 13 | `28,Tool Speed` |
| 6145 | 22 | `29,Tool Start Using En` |
| 6146 | 18 | `30,Tool X Safe Pos` |
| 6147 | 18 | `31,Tool Y Safe Pos` |
| 6148 | 18 | `32,Tool Z Safe Pos` |
| 6149 | 18 | `33,Tool A Safe Pos` |
| 6150 | 18 | `34,Tool B Safe Pos` |
| 6151 | 18 | `35,Tool C Safe Pos` |
| 6152 | 21 | `36,Tool Safe Check En` |
| 6154 | 44 | `38,Tool Seting(0-1Reference 1-Not Reference)` |
| 6175 | 20 | `current tool setting` |
| 6176 | 16 | `all tool setting` |
| 6178 | 4 | `Tool` |
| 6201 | 15 | `HOME Offset(mm)` |
| 6382 | 24 | `069,CoorToolSettingsMode` |
| 6414 | 15 | `ToolDebugCancel` |
| 6415 | 17 | `ToolFailPleaCheck` |
| 6416 | 17 | `SetToolNumTooMany` |
| 6417 | 11 | `ToolNoError` |
| 6419 | 12 | `ToolOutOtime` |
| 6423 | 13 | `ToolBackOTime` |
| 6425 | 10 | `ToolCOTime` |
| 6448 | 32 | `015, spindle zero offset (Angle)` |
| 6586 | 21 | `Axis lap offset(mm/r)` |
| 6707 | 52 | `&gt; Pos is completed,The tool auto back to a safe pos!` |
| 6708 | 15 | `Tool Parameters` |
| 6709 | 18 | `Z-phase offset pos` |
| 7028 | 20 | `19.2GG A OffsetAngle` |
| 7029 | 17 | `2GG A OffsetAngle` |
| 7229 | 23 | `C workpiece tool offset` |
| 7230 | 27 | `CurTool C WP Len compensate` |

## Coordenadas y posicion <a id="coordinates"></a>

**Prioridad**: BAJA — G54-G599, posiciones absolutas/relativas/maquina, offsets de ejes

**66 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 4985 | 7 | `Abs pos` |
| 4986 | 11 | `machine pos` |
| 4987 | 8 | `Rela pos` |
| 4992 | 17 | `current coord sys` |
| 4993 | 20 | `work boundary point1` |
| 4994 | 20 | `work boundary point2` |
| 4995 | 20 | `work boundary point3` |
| 4996 | 20 | `work boundary point4` |
| 4997 | 20 | `R of round workpiece` |
| 4998 | 16 | `centre reckoning` |
| 4999 | 32 | `current workpiece coord sys-&gt;G54` |
| 5000 | 32 | `current workpiece coord sys-&gt;G55` |
| 5001 | 32 | `current workpiece coord sys-&gt;G56` |
| 5002 | 32 | `current workpiece coord sys-&gt;G57` |
| 5003 | 32 | `current workpiece coord sys-&gt;G58` |
| 5004 | 32 | `current workpiece coord sys-&gt;G59` |
| 5005 | 33 | `current workpiece coord sys-&gt;G591` |
| 5006 | 33 | `current workpiece coord sys-&gt;G592` |
| 5007 | 33 | `current workpiece coord sys-&gt;G593` |
| 5008 | 33 | `current workpiece coord sys-&gt;G594` |
| 5009 | 33 | `current workpiece coord sys-&gt;G595` |
| 5010 | 33 | `current workpiece coord sys-&gt;G596` |
| 5011 | 33 | `current workpiece coord sys-&gt;G597` |
| 5012 | 33 | `current workpiece coord sys-&gt;G598` |
| 5013 | 33 | `current workpiece coord sys-&gt;G599` |
| 5015 | 21 | `ensure measure coord?` |
| 5046 | 5 | `COORD` |
| 5103 | 5 | `Coord` |
| 5202 | 11 | `machine pos` |
| 5203 | 7 | `abs pos` |
| 5229 | 5 | `Coord` |
| 5240 | 5 | `Coord` |
| 5241 | 5 | `Coord` |
| 5247 | 7 | `Abs Pos` |
| 5266 | 54 | `use all machine coord value set to current coord sys?` |
| 5532 | 5 | `Coord` |
| 5546 | 11 | `Refer coord` |
| 5547 | 12 | `Refer coord2` |
| 5548 | 12 | `Refer coord3` |
| 5549 | 12 | `Refer coord4` |
| 5722 | 31 | `move it to the form coordinate?` |
| 5752 | 49 | `linear mode: pls insert linear ending coord value` |
| 5753 | 43 | `arc mode: pls insert arc ending coord value` |
| 5754 | 51 | `arc mode: pls insert arc random point's coord value` |
| 5755 | 42 | `spline mode: pls insert spline coord value` |
| 5779 | 50 | `the coord valve invalid , can't execute this order` |
| 5817 | 9 | `A Forward` |
| 5818 | 9 | `A Reverse` |
| 5819 | 9 | `X Forward` |
| 5820 | 9 | `X Reverse` |
| 5821 | 9 | `Y Forward` |
| 5822 | 9 | `Y Reverse` |
| 5823 | 9 | `Z Forward` |
| 5824 | 9 | `Z Reverse` |
| 5834 | 6 | `A Comp` |
| 5835 | 6 | `Z Comp` |
| 5836 | 6 | `Y Comp` |
| 5837 | 6 | `X Comp` |
| 5894 | 12 | `Positive Dir` |
| 5895 | 12 | `Negative Dir` |
| 5912 | 9 | `Abs Coord` |
| 5913 | 9 | `Mac Coord` |
| 6095 | 6 | `Z Comp` |
| 6549 | 11 | `machine pos` |
| 6701 | 50 | `&gt; Z axis safe pos, move to the X, Y coordinates...` |
| 6789 | 9 | `Mac Coord` |

## Operaciones de archivo <a id="file_operations"></a>

**Prioridad**: BAJA — Cargar, guardar, eliminar archivos, USB, carpetas

**138 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 4916 | 17 | `FileLoad Success!` |
| 4934 | 16 | `Current NC File:` |
| 4935 | 13 | `Current Prog:` |
| 4937 | 18 | `NOs of saved prog` |
| 4941 | 30 | `template over 128K,can't load` |
| 4942 | 12 | `save success` |
| 4943 | 16 | `new Prog failure` |
| 4944 | 16 | `new prog success` |
| 4946 | 20 | `Del current Prog No?` |
| 4951 | 9 | `Prog size` |
| 4954 | 30 | `template over 128K,can't load` |
| 4955 | 8 | `Del all?` |
| 4956 | 4 | `Save` |
| 4958 | 19 | `cover current file?` |
| 4959 | 15 | `can't find file` |
| 4960 | 18 | `can't open catalog` |
| 4961 | 33 | `DXF over 2M,no resource to handle` |
| 4962 | 25 | `can't spot file like this` |
| 4963 | 17 | `load G code file?` |
| 4964 | 12 | `load success` |
| 4965 | 11 | `Del folder?` |
| 4966 | 18 | `Del folder failure` |
| 4967 | 9 | `Del file?` |
| 4968 | 19 | `cat't del this file` |
| 4969 | 7 | `reboot?` |
| 4970 | 16 | `input file name` |
| 4971 | 32 | `can't cover current process file` |
| 4972 | 20 | `replace file folder?` |
| 4973 | 20 | `copy catalog failure` |
| 4974 | 17 | `copy file failure` |
| 4975 | 9 | `file size` |
| 4976 | 13 | `build success` |
| 5023 | 9 | `Prog rate` |
| 5033 | 7 | `Program` |
| 5035 | 9 | `file name` |
| 5036 | 4 | `Prog` |
| 5038 | 12 | `Save failure` |
| 5039 | 17 | `data save success` |
| 5041 | 12 | `load failure` |
| 5042 | 17 | `data load success` |
| 5073 | 44 | `lead in system configuration table CSV file?` |
| 5074 | 30 | `fail,cut the power and reboot.` |
| 5080 | 46 | `pls alter prog since G7X cycles more than 2000` |
| 5081 | 35 | `pls alter prog since G7X cycle is 0` |
| 5192 | 76 | `repeat prog found in process file,only can load the code before the repeated` |
| 5193 | 44 | `process file has mismatch bracket, load fail` |
| 5197 | 8 | `Prog sec` |
| 5204 | 62 | `pls enter prog #,consist by 4 digits, no repeated prog number` |
| 5205 | 67 | `no change prog section in sys work condition,pls reset system first` |
| 5207 | 12 | `File manager` |
| 5210 | 4 | `Copy` |
| 5213 | 4 | `File` |
| 5226 | 57 | `File name too long, pls enter file name less than 8 chars` |
| 5228 | 65 | `replace file or not, enter to cover original file, cancel to exit` |
| 5530 | 27 | `sys finish recover, reboot?` |
| 5559 | 11 | `Prog No End` |
| 5564 | 22 | `G Program Repeat Error` |
| 5565 | 22 | `G Program Number Error` |
| 5568 | 13 | `Program Abend` |
| 5570 | 26 | `No Appointed ProgramNumber` |
| 5573 | 25 | `Current Program No Repair` |
| 5635 | 41 | `Composite prog segments too many overflow` |
| 5686 | 11 | `config file` |
| 5687 | 12 | `Wait USB Com` |
| 5688 | 10 | `USB Com...` |
| 5711 | 21 | `File exception error?` |
| 5713 | 23 | `Pro number del success?` |
| 5782 | 6 | `Save` |
| 5784 | 4 | `Load` |
| 5786 | 8 | `Del line` |
| 5806 | 47 | `System load NC_RES.NCP resource package failed.` |
| 5891 | 9 | `Copy File` |
| 5892 | 9 | `Load Code` |
| 5915 | 12 | `File Encrypt` |
| 6065 | 7 | `Save As` |
| 6310 | 29 | `Not contain a program number!` |
| 6313 | 13 | `can not copy!` |
| 6314 | 13 | `can not copy!` |
| 6319 | 8 | `Blk Copy` |
| 6322 | 8 | `Row Copy` |
| 6429 | 15 | `GLoadBordScanEn` |
| 6449 | 18 | `Load the main code` |
| 6450 | 24 | `TheSecondChannelCodeLoad` |
| 6451 | 20 | `USBConnectionFail...` |
| 6452 | 11 | `USB IDLE...` |
| 6453 | 26 | `USB  WaitFor Connection...` |
| 6454 | 20 | `USB Begin Connect...` |
| 6455 | 31 | `USB Success Connection Began...` |
| 6465 | 16 | `DeleteDirFile...` |
| 6466 | 21 | `Load GFile To GCMain` |
| 6468 | 18 | `File Exists Cover?` |
| 6469 | 14 | `Load Main Code` |
| 6470 | 38 | `TheSystemLoadSecondChannel GcodeFiles?` |
| 6471 | 22 | `LoadSecondChannelGCode` |
| 6475 | 4 | `Copy` |
| 6533 | 64 | `pfopen global file buffer space is not enough,load file fail\r\n` |
| 6573 | 28 | `009,USB flash disk online en` |
| 6604 | 20 | `026,Open screensaver` |
| 6795 | 16 | `CopyUpTO5120Char` |
| 6796 | 11 | `NewFileFail` |
| 6797 | 11 | `NewFileSucc` |
| 6798 | 14 | `NewFileLoaded?` |
| 6817 | 4 | `Save` |
| 6835 | 11 | `FileDataErr` |
| 6841 | 12 | `OpenFileFail` |
| 6872 | 22 | `LoadPositioningWait...` |
| 6926 | 9 | `SAVE[EOB]` |
| 6928 | 19 | `P select teach file` |
| 6929 | 19 | `teach file not exis` |
| 6930 | 17 | `file load success` |
| 6931 | 21 | `file name less 8 char` |
| 6932 | 23 | `No occupy sys file name` |
| 6933 | 16 | `File open failed` |
| 6934 | 16 | `File save sucess` |
| 6941 | 4 | `copy` |
| 6943 | 6 | `SaveAS` |
| 6944 | 4 | `load` |
| 6967 | 9 | `SAVE[EOB]` |
| 6969 | 19 | `P select teach file` |
| 6970 | 19 | `teach file not exis` |
| 6971 | 17 | `file load success` |
| 6972 | 21 | `file name less 8 char` |
| 6973 | 23 | `No occupy sys file name` |
| 6974 | 16 | `File open failed` |
| 6975 | 16 | `File save sucess` |
| 6982 | 4 | `copy` |
| 6984 | 6 | `SaveAS` |
| 6985 | 4 | `load` |
| 7078 | 6 | `Unload` |
| 7166 | 24 | `Init PARAM from CSV file` |
| 7168 | 17 | `Save PARAM to CSV` |
| 7169 | 12 | `SAVE SUCCESS` |
| 7170 | 9 | `SAVE FAIL` |
| 7175 | 15 | `save ,wait.....` |
| 7211 | 12 | `FAIL ,reload` |
| 7212 | 23 | `delet file and save it` |
| 7213 | 22 | `delet file and save it` |
| 7214 | 12 | `save success` |

## Etiquetas I/O <a id="io_labels"></a>

**Prioridad**: BAJA — Nombres de entradas (IN00-IN95) y salidas (OUT00-OUT95)

**228 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 5101 | 26 | `compound code format wrong` |
| 5111 | 6 | `IN04` |
| 5112 | 6 | `IN05` |
| 5113 | 4 | `IN06` |
| 5114 | 4 | `IN07` |
| 5115 | 4 | `IN08` |
| 5116 | 4 | `IN09` |
| 5117 | 6 | `IN10` |
| 5118 | 6 | `IN11` |
| 5119 | 6 | `IN12` |
| 5120 | 6 | `IN13` |
| 5121 | 6 | `IN14` |
| 5122 | 5 | `IN15` |
| 5123 | 10 | `X-limitI16` |
| 5124 | 10 | `X+limitI17` |
| 5125 | 10 | `Y-limitI18` |
| 5126 | 10 | `Y+limitI19` |
| 5127 | 10 | `Z-limitI20` |
| 5128 | 10 | `Z+limitI21` |
| 5129 | 10 | `A-limitI22` |
| 5130 | 10 | `A+limitI23` |
| 5152 | 5 | `OUT02` |
| 5153 | 5 | `OUT03` |
| 5154 | 5 | `OUT04` |
| 5155 | 5 | `OUT05` |
| 5156 | 5 | `OUT06` |
| 5157 | 5 | `OUT07` |
| 5158 | 5 | `OUT08` |
| 5159 | 5 | `OUT09` |
| 5160 | 5 | `OUT10` |
| 5161 | 5 | `OUT11` |
| 5162 | 5 | `OUT12` |
| 5163 | 5 | `OUT13` |
| 5164 | 5 | `OUT14` |
| 5165 | 5 | `OUT15` |
| 5166 | 5 | `OUT16` |
| 5167 | 5 | `OUT17` |
| 5168 | 5 | `OUT18` |
| 5169 | 5 | `OUT19` |
| 5170 | 5 | `OUT20` |
| 5171 | 5 | `OUT21` |
| 5172 | 5 | `OUT22` |
| 5173 | 5 | `OUT23` |
| 5218 | 13 | `local disk(c)` |
| 5219 | 13 | `local disk(d)` |
| 5220 | 16 | `data traveler(U)` |
| 5222 | 13 | `local disk(c)` |
| 5223 | 13 | `local disk(d)` |
| 5224 | 16 | `data traveler(U)` |
| 5225 | 28 | `Sys RAM lack, can't continue` |
| 5253 | 11 | `(G)Skip Fun` |
| 5331 | 23 | `064,Hand Wheel ACC(Kps)` |
| 5839 | 11 | `(8)Mac Lock` |
| 5840 | 6 | `(9)M01` |
| 5841 | 9 | `(M)Fast0%` |
| 5842 | 10 | `(Y)Fast25%` |
| 5843 | 10 | `(4)Fast50%` |
| 5844 | 11 | `(5)Fast100%` |
| 5845 | 12 | `(6)Tailstock` |
| 5846 | 5 | `(F)F0` |
| 5847 | 5 | `(Z)F1` |
| 5848 | 5 | `(1)F2` |
| 5849 | 5 | `(2)F3` |
| 5850 | 5 | `(3)F4` |
| 5851 | 8 | `(R)Tlock` |
| 5852 | 7 | `(A)Blow` |
| 5854 | 6 | `(0)T--` |
| 5938 | 11 | `X+Limit I00` |
| 5939 | 11 | `X-Limit I01` |
| 5940 | 11 | `Y+Limit I02` |
| 5941 | 11 | `Y-Limit I03` |
| 5942 | 11 | `Z+Limit I04` |
| 5943 | 11 | `Z-Limit I05` |
| 5944 | 11 | `A+Limit I06` |
| 5945 | 11 | `A-Limit I07` |
| 5954 | 11 | `B+Limit I16` |
| 5955 | 11 | `B-Limit I17` |
| 5956 | 11 | `C+Limit I18` |
| 5957 | 11 | `C-Limit I19` |
| 5994 | 11 | `Wheel X I56` |
| 5995 | 11 | `Wheel Y I56` |
| 5996 | 11 | `Wheel Z I56` |
| 5997 | 11 | `Wheel A I56` |
| 5998 | 11 | `Wheel C I56` |
| 6000 | 11 | `Wheel B I56` |
| 6001 | 10 | `Wheel1 I63` |
| 6002 | 10 | `Wheel2 I64` |
| 6003 | 10 | `Wheel3 I65` |
| 6078 | 54 | `The number of Workpiece  exceeds the maximum set limit` |
| 6079 | 13 | `Housing Error` |
| 6080 | 25 | `Pressure Transducer Error` |
| 6081 | 12 | `Vacuum Error` |
| 6096 | 7 | `(O)Skip` |
| 6101 | 9 | `(X)Fast0%` |
| 6102 | 10 | `(Z)Fast50%` |
| 6103 | 11 | `(4)Fast100%` |
| 6104 | 12 | `(5)Tailstock` |
| 6110 | 12 | `(A)T Locking` |
| 6114 | 14 | `(0)Chip Remove` |
| 6688 | 12 | `(7)Handwheel` |
| 6729 | 10 | `B-limitI14` |
| 6730 | 10 | `B+limitI15` |
| 6731 | 4 | `IN24` |
| 6732 | 4 | `IN25` |
| 6733 | 4 | `IN26` |
| 6734 | 4 | `IN27` |
| 6735 | 4 | `IN28` |
| 6736 | 4 | `IN29` |
| 6737 | 4 | `IN30` |
| 6738 | 4 | `IN31` |
| 6739 | 4 | `IN32` |
| 6740 | 4 | `IN33` |
| 6741 | 4 | `IN34` |
| 6742 | 4 | `IN35` |
| 6743 | 4 | `IN36` |
| 6744 | 4 | `IN37` |
| 6745 | 4 | `IN40` |
| 6746 | 4 | `IN43` |
| 6747 | 4 | `IN46` |
| 6748 | 4 | `IN49` |
| 6749 | 4 | `IN52` |
| 6753 | 5 | `OUT24` |
| 6754 | 5 | `OUT25` |
| 6755 | 5 | `OUT26` |
| 6756 | 5 | `OUT27` |
| 6757 | 5 | `OUT28` |
| 7100 | 16 | `11.Pos C back Dt` |
| 7101 | 13 | `Pos C back Dt` |
| 7102 | 17 | `12.fender drop Dt` |
| 7103 | 14 | `fender drop Dt` |
| 7104 | 15 | `13.fender up Dt` |
| 7105 | 14 | `14.CM C Rel Dt` |
| 7106 | 11 | `CM C Rel Dt` |
| 7107 | 13 | `15.UL C UL Dt` |
| 7109 | 11 | `IN00 X zero` |
| 7110 | 11 | `IN00 Y zero` |
| 7111 | 11 | `IN00 Z zero` |
| 7112 | 11 | `IN00 A zero` |
| 7114 | 12 | `IN05 Ext sta` |
| 7115 | 12 | `IN06 Ext sto` |
| 7116 | 14 | `IN07 M detct S` |
| 7117 | 12 | `IN08 FR Back` |
| 7118 | 15 | `IN09 TM Place S` |
| 7119 | 12 | `IN10 X Pso S` |
| 7120 | 12 | `IN16 X-limit` |
| 7121 | 12 | `IN17 X+limit` |
| 7122 | 12 | `IN18 Y-limit` |
| 7123 | 12 | `IN19 Y+limit` |
| 7124 | 12 | `IN20 Z-limit` |
| 7125 | 12 | `IN21 Z+limit` |
| 7126 | 12 | `IN22 A-limit` |
| 7127 | 12 | `IN23 A+limit` |
| 7130 | 15 | `OUT02 FR A/R F0` |
| 7131 | 15 | `OUT03 FR U/D F1` |
| 7132 | 12 | `OUT04 TMC F2` |
| 7133 | 12 | `OUT05 CMC F3` |
| 7134 | 12 | `OUT06 ULC F4` |
| 7135 | 8 | `OUT07 FC` |
| 7136 | 13 | `OUT08 coolant` |
| 7137 | 11 | `OUT09 Pos C` |
| 7138 | 11 | `OUT10 UL CV` |
| 7143 | 23 | `SW(infeed set)set PARAM` |
| 7149 | 12 | `RET GG X Len` |
| 7150 | 16 | `34.RET GG Z high` |
| 7151 | 13 | `RET GG Z high` |
| 7152 | 15 | `35.RET GG Speed` |
| 7153 | 15 | `35.RET GG Speed` |
| 7156 | 11 | `A6 COM fail` |
| 7158 | 26 | `UART1/UART2/UART3 only one` |
| 7160 | 19 | `Data backup success` |
| 7161 | 16 | `Data backup fail` |
| 7162 | 14 | `Data recovery?` |
| 7163 | 23 | `sucessful! restart SYS?` |
| 7164 | 19 | `Data recovery fail!` |
| 7167 | 12 | `Init success` |
| 7171 | 13 | `read CSV fail` |
| 7173 | 26 | `Sure CSV index are correct` |
| 7174 | 36 | `Init fail!drive selection correct!!!` |
| 7176 | 14 | `Init, wait....` |
| 7177 | 13 | `5axis G PARAM` |
| 7192 | 13 | `12-axis PARAM` |
| 7193 | 13 | `11-axis PARAM` |
| 7194 | 13 | `10-axis PARAM` |
| 7195 | 12 | `9-axis PARAM` |
| 7196 | 12 | `8-axis PARAM` |
| 7197 | 12 | `7-axis PARAM` |
| 7198 | 12 | `C-axis PARAM` |
| 7199 | 12 | `B-axis PARAM` |
| 7200 | 12 | `A-axis PARAM` |
| 7468 | 6 | `IN05` |
| 7469 | 6 | `IN06` |
| 7470 | 6 | `IN07` |
| 7471 | 6 | `IN08` |
| 7472 | 6 | `IN09` |
| 7473 | 6 | `IN10` |
| 7474 | 6 | `IN11` |
| 7475 | 6 | `IN12` |
| 7476 | 6 | `IN13` |
| 7477 | 6 | `IN14` |
| 7478 | 6 | `IN15` |
| 7508 | 5 | `OUT02` |
| 7509 | 5 | `OUT03` |
| 7510 | 5 | `OUT04` |
| 7511 | 5 | `OUT05` |
| 7512 | 5 | `OUT06` |
| 7513 | 5 | `OUT07` |
| 7514 | 5 | `OUT08` |
| 7515 | 5 | `OUT09` |
| 7516 | 5 | `OUT10` |
| 7517 | 5 | `OUT11` |
| 7518 | 5 | `OUT12` |
| 7519 | 5 | `OUT13` |
| 7520 | 5 | `OUT14` |
| 7521 | 5 | `OUT15` |
| 7522 | 5 | `OUT16` |
| 7523 | 5 | `OUT17` |
| 7524 | 5 | `OUT18` |
| 7525 | 5 | `OUT19` |
| 7526 | 5 | `OUT20` |
| 7527 | 5 | `OUT21` |
| 7528 | 5 | `OUT22` |
| 7529 | 5 | `OUT23` |
| 8194 | 6 | `(9)M01` |
| 8200 | 5 | `(F)F0` |
| 8201 | 5 | `(Z)F1` |
| 8202 | 5 | `(1)F2` |
| 8203 | 5 | `(2)F3` |
| 8204 | 5 | `(3)F4` |

## Varios / Sistema <a id="misc"></a>

**Prioridad**: BAJA — USB, Modbus, EtherCAT, debug, mensajes varios

**291 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 4938 | 11 | `used space` |
| 4945 | 29 | `input wanted character string` |
| 4948 | 32 | `jump to current line to process?` |
| 4953 | 18 | `return to default?` |
| 4983 | 20 | `input variable value` |
| 4984 | 12 | `variable add` |
| 4989 | 34 | `1,move Y axis to machine zeropoint` |
| 4990 | 34 | `1,move Z axis to machine zeropoint` |
| 4991 | 34 | `1,move X axis to machine zeropoint` |
| 5024 | 11 | `actual rate` |
| 5050 | 12 | `[cancel]quit` |
| 5052 | 12 | `[EOB]confirm` |
| 5070 | 18 | `initialize success` |
| 5071 | 40 | `wipe system accumulative processing Nos?` |
| 5072 | 35 | `wipe current system processing Nos?` |
| 5078 | 26 | `G7X outline describe wrong` |
| 5098 | 28 | `G94 X axis increment is zero` |
| 5578 | 31 | `Noneffective Exegesis Character` |
| 5583 | 28 | `Appointed Noneffective Plane` |
| 5589 | 23 | `Appointed Arc Nonentity` |
| 5611 | 18 | `no parameter input` |
| 5612 | 39 | `no store address for Gcode pro num form` |
| 5616 | 11 | `Value error` |
| 5642 | 18 | `no  \"return zero\` |
| 5709 | 11 | `Find Error!` |
| 5712 | 19 | `Pro number is full?` |
| 5714 | 29 | `Parameters failed to restore!` |
| 5716 | 35 | `Pro Num repeat,whether to re-enter?` |
| 5719 | 24 | `G code reserved succeed` |
| 5720 | 32 | `insert one line before this line` |
| 5721 | 24 | `confirm delete this line` |
| 5805 | 16 | `Param Backup OK!` |
| 5807 | 25 | `M98 began processing line` |
| 5855 | 15 | `(.)chip removal` |
| 5857 | 20 | `X Axis Start Pos(mm)` |
| 5858 | 20 | `Y Axis Start Pos(mm)` |
| 5859 | 26 | `Z Axis Plane Start Pos(mm)` |
| 5880 | 25 | `Processing of repetitions` |
| 5896 | 32 | `whether do you need return Zero?` |
| 5897 | 24 | `Press[EOB] 3 Sec to exit` |
| 5911 | 11 | `preproccess` |
| 5914 | 24 | `No Enough Of Disk Space` |
| 5916 | 24 | `No Enough Of Disk Space` |
| 6153 | 33 | `37,Dustproof Appliance Drop Delay` |
| 6165 | 11 | `Output Test` |
| 6174 | 11 | `Demo Screen` |
| 6177 | 18 | `three cylinder SPI` |
| 6193 | 14 | `Gear Numerator` |
| 6194 | 16 | `Gear Denominator` |
| 6195 | 17 | `FastSpeed(mm/min)` |
| 6196 | 20 | `StartupSpeed(mm/min)` |
| 6197 | 18 | `Acceleration(Kpps)` |
| 6198 | 18 | `Soft PosLimit+(mm)` |
| 6199 | 18 | `Soft PosLimit-(mm)` |
| 6211 | 13 | `Limit  ELevel` |
| 6218 | 12 | `Reset to 360` |
| 6221 | 21 | `Rolling Display Usage` |
| 6222 | 25 | `G00 Rolling Path Optimize` |
| 6223 | 18 | `Max Acc of X(Kpps)` |
| 6235 | 16 | `-axis first zero` |
| 6236 | 17 | `-axis second zero` |
| 6237 | 16 | `-axis third zero` |
| 6265 | 14 | `7 Limit- Input` |
| 6266 | 14 | `7 Limit+ Input` |
| 6267 | 14 | `8 Limit- Input` |
| 6268 | 14 | `8 Limit+ Input` |
| 6284 | 18 | `Y axis Reset Input` |
| 6285 | 18 | `Z axis Reset Input` |
| 6286 | 18 | `4 axis Reset Input` |
| 6287 | 18 | `B axis Reset Input` |
| 6288 | 18 | `C axis Reset Input` |
| 6289 | 18 | `7 axis Reset Input` |
| 6290 | 18 | `8 axis Reset Input` |
| 6300 | 21 | `More than 8000 reset!` |
| 6311 | 28 | `Last not contain procedures!` |
| 6312 | 14 | `Out of memory!` |
| 6315 | 15 | `can not delete!` |
| 6316 | 15 | `can not delete!` |
| 6327 | 12 | `MachineRange` |
| 6383 | 16 | `SystemOffInputNO` |
| 6384 | 17 | `SystemOffOutputNO` |
| 6387 | 15 | `Inverted arc _R` |
| 6388 | 19 | `Error inverted arc` |
| 6389 | 11 | `Full screen` |
| 6409 | 14 | `[EOB]    [CAN]` |
| 6412 | 12 | `FirstInError` |
| 6413 | 13 | `SecondInError` |
| 6420 | 11 | `LoosenOTime` |
| 6431 | 17 | `ZSafePosDropSpeed` |
| 6432 | 17 | `ASafePosDropSpeed` |
| 6447 | 36 | `G7XG8X  Z and R point Location error` |
| 6456 | 16 | `CNC System Start` |
| 6464 | 15 | `AbsPosReadFail!` |
| 6476 | 36 | `con Greater 9M,No Resource Handling!` |
| 6478 | 49 | `Arc to Angle transition function is not supported` |
| 6479 | 37 | `line or arc transition Angle of error` |
| 6510 | 23 | `second channel not zero` |
| 6511 | 42 | `Motion library error please restart system` |
| 6513 | 31 | `Motion target pos data error110` |
| 6514 | 31 | `EtherCAT communication fail 118` |
| 6531 | 12 | `memory over!` |
| 6532 | 102 | `The U disk online processing, U disk is drawn, please insert the U drive again to continue processing!` |
| 6534 | 17 | `First of the jump` |
| 6535 | 14 | `Second of jump` |
| 6536 | 13 | `Third of jump` |
| 6537 | 13 | `[Axis group1]` |
| 6538 | 13 | `[Axis group2]` |
| 6541 | 14 | `second channel` |
| 6542 | 13 | `third channel` |
| 6543 | 16 | `[Channel GRUNC4]` |
| 6544 | 16 | `[Channel GRUNC5]` |
| 6545 | 16 | `[Channel GRUNC6]` |
| 6546 | 16 | `[Channel GRUNC7]` |
| 6547 | 13 | `[Axis group7]` |
| 6548 | 13 | `[Axis group8]` |
| 6551 | 18 | `Origin pos confirm` |
| 6559 | 12 | `Main channel` |
| 6563 | 14 | `Standard Pulse` |
| 6576 | 20 | `Negative limit input` |
| 6577 | 19 | `positive limit inpu` |
| 6578 | 17 | `Extend zero input` |
| 6582 | 23 | `Axis corner speed level` |
| 6583 | 22 | `Axis second zero speed` |
| 6584 | 21 | `Axis third zero speed` |
| 6683 | 14 | `Run rate(&lt;100)` |
| 6690 | 14 | `Auxiliary info` |
| 6700 | 43 | `&gt; Move the knife shaft to the safe place...` |
| 6702 | 50 | `&gt; Y axis safe pos, move to the Z, X cyordinates...` |
| 6703 | 50 | `&gt; X axis safe pos, move to the Y, Z cyordinates...` |
| 6704 | 51 | `&gt;  Move Z axis to start scanning mobile location...` |
| 6705 | 63 | `&gt; Knife shaft scanning in place,In search of knife apparatus...` |
| 6706 | 80 | `&gt; In place of knife instrument signal is detected,In the repeated positioning...` |
| 6778 | 17 | `Find End Not Find` |
| 6801 | 11 | `FindReplEnd` |
| 6803 | 15 | `OutputSignalErr` |
| 6804 | 18 | `SpaceArcModifySucc` |
| 6805 | 18 | `SpaceArcModifySucc` |
| 6806 | 18 | `SpaceArcModifySucc` |
| 6807 | 18 | `SpaceArcModifySucc` |
| 6808 | 18 | `SpaceArcModifySucc` |
| 6809 | 18 | `SpaceArcModifySucc` |
| 6810 | 18 | `SpaceArcModifySucc` |
| 6811 | 18 | `SpaceArcModifySucc` |
| 6827 | 11 | `MotionErrNo` |
| 6828 | 15 | `EtherCATErrAxis` |
| 6829 | 14 | `InvalidFunCode` |
| 6830 | 11 | `InvalidAddr` |
| 6831 | 11 | `InvalidData` |
| 6836 | 14 | `InvalidNetPath` |
| 6837 | 13 | `DeviceNotResp` |
| 6838 | 13 | `ModbusDataErr` |
| 6842 | 11 | `BaseAddrErr` |
| 6843 | 11 | `DecimalPErr` |
| 6844 | 14 | `MotionErrParam` |
| 6845 | 13 | `MotionErrData` |
| 6847 | 17 | `MotionErrConflict` |
| 6848 | 20 | `MotionErrModifyParam` |
| 6849 | 18 | `MotionErrInputData` |
| 6850 | 19 | `MotionErrAccDecMode` |
| 6851 | 15 | `MotionErrSCurve` |
| 6853 | 18 | `MotionErrTargetPos` |
| 6854 | 23 | `MotionErrInvalidCommand` |
| 6855 | 15 | `MotionErrFPGARW` |
| 6856 | 17 | `MotionErrFifoFull` |
| 6857 | 17 | `MotionErrFifoFull` |
| 6858 | 13 | `MotionErrRate` |
| 6859 | 17 | `MotionErrFirmware` |
| 6860 | 13 | `MotionErrAxis` |
| 6861 | 17 | `MotionErrEtherCAT` |
| 6862 | 13 | `MotionErrAxis` |
| 6863 | 16 | `MotionErrMailBox` |
| 6865 | 18 | `MotionErrFifoEvent` |
| 6866 | 16 | `MotionErrFPGABus` |
| 6869 | 20 | `JumpMemoryPosExecute` |
| 6871 | 18 | `JumpExecuteWait...` |
| 6900 | 12 | `TabCycleTyep` |
| 6902 | 42 | `SimulationDataGeneratedWhetherToSimulation` |
| 6935 | 18 | `paste data cur loc` |
| 6936 | 16 | `clear cur param?` |
| 6947 | 12 | `days Remain:` |
| 6948 | 24 | `switch user mode do this` |
| 6949 | 12 | `01.Rr 1 MC 0` |
| 6950 | 13 | `Type(Rr1,MC0)` |
| 6951 | 12 | `MC Pro teeth` |
| 6952 | 12 | `MC Pro teeth` |
| 6953 | 17 | `03.B angle Pro TS` |
| 6954 | 23 | `TS the MC need machined` |
| 6955 | 14 | `04.Spiral lead` |
| 6956 | 11 | `Spiral lead` |
| 6957 | 21 | `05.X Search pos speed` |
| 6958 | 18 | `X Search pos speed` |
| 6959 | 21 | `06.X pos and feed dis` |
| 6960 | 24 | `X pos and feed point dis` |
| 6961 | 17 | `07.GW start speed` |
| 6962 | 14 | `GW start speed` |
| 6963 | 17 | `08.Grinding speed` |
| 6976 | 18 | `paste data cur loc` |
| 6977 | 16 | `clear cur param?` |
| 6988 | 12 | `days Remain:` |
| 6989 | 24 | `switch user mode do this` |
| 6990 | 11 | `01.RB1 MK 0` |
| 6991 | 14 | `Type(RB1 MK 0)` |
| 6992 | 15 | `02.MC PRO teeth` |
| 6993 | 12 | `MC PRO teeth` |
| 6994 | 20 | `03.B_angle Pro times` |
| 6995 | 18 | `MC Angle Pro times` |
| 6996 | 11 | `04.Spr lead` |
| 6998 | 19 | `05.X find pos speed` |
| 6999 | 16 | `X find POS speed` |
| 7000 | 23 | `06.Feed dis after X POS` |
| 7001 | 20 | `Feed dis after X POS` |
| 7002 | 17 | `07.GW start speed` |
| 7003 | 14 | `GW start speed` |
| 7006 | 12 | `09.G Ang_Vel` |
| 7008 | 23 | `10 A Dfl_Ang when Xzero` |
| 7009 | 20 | `A Dfl_Ang when Xzero` |
| 7011 | 16 | `11.X CB distance` |
| 7012 | 13 | `X CB distance` |
| 7013 | 11 | `12.X GG POS` |
| 7014 | 14 | `X GG Start POS` |
| 7015 | 11 | `13.Y GG POS` |
| 7016 | 14 | `Y GG Start POS` |
| 7017 | 11 | `14.Z GG POS` |
| 7018 | 14 | `Z GG Start POS` |
| 7019 | 11 | `15.A GG POS` |
| 7020 | 14 | `A GG Start POS` |
| 7021 | 17 | `16.SL F_angle Pro` |
| 7022 | 14 | `SL F_angle Pro` |
| 7023 | 11 | `17.GW depth` |
| 7025 | 12 | `18.2GG(Y1N0)` |
| 7026 | 12 | `MC need 2GG?` |
| 7030 | 12 | `20.2GG Y POS` |
| 7032 | 12 | `21.2GG depth` |
| 7034 | 16 | `22.X G angle pos` |
| 7035 | 15 | `X G agl Sta_pos` |
| 7036 | 14 | `23.Y G agl pos` |
| 7037 | 15 | `Y G agl sta_pos` |
| 7038 | 16 | `24.Z G angle pos` |
| 7039 | 17 | `Z G angle Sta_pos` |
| 7040 | 16 | `25.A G angle pos` |
| 7041 | 17 | `A G angle Sta_pos` |
| 7042 | 18 | `26.B_Corner pro SL` |
| 7043 | 15 | `B_Corner pro SL` |
| 7044 | 19 | `27. Agl depth of GW` |
| 7045 | 15 | `Agl depth of GW` |
| 7046 | 17 | `28.2G Agl A O_Agl` |
| 7047 | 14 | `2G Agl A O_Agl` |
| 7048 | 15 | `29.2G Agl Z POS` |
| 7049 | 12 | `2G Agl Z POS` |
| 7050 | 20 | `30.2GG Agl Pro depth` |
| 7051 | 17 | `2GG Agl Pro depth` |
| 7052 | 17 | `31. CM return dis` |
| 7053 | 14 | `CM return dis` |
| 7054 | 14 | `32 UseThimble?` |
| 7055 | 11 | `UseThimble?` |
| 7056 | 14 | `33.Ret G X Len` |
| 7057 | 11 | `Ret G X Len` |
| 7059 | 16 | `34.Ret GG Z high` |
| 7060 | 13 | `Ret GG Z high` |
| 7061 | 16 | `35.Ret  GG Speed` |
| 7062 | 13 | `Ret  GG Speed` |
| 7073 | 14 | `41.G B_corner?` |
| 7074 | 11 | `G B_corner?` |
| 7075 | 16 | `42.G 2 B_corner?` |
| 7076 | 13 | `G 2 B_corner?` |
| 7079 | 11 | `1.CM Rel Dt` |
| 7082 | 14 | `2.Flap lift Dt` |
| 7084 | 16 | `3.FeedRack go Dt` |
| 7085 | 14 | `FeedRack go Dt` |
| 7086 | 16 | `5.FeedBack up Dt` |
| 7087 | 14 | `FeedBack up Dt` |
| 7088 | 11 | `5.TMC TM Dt` |
| 7090 | 12 | `6.CM C CM Dt` |
| 7092 | 14 | `7.TM C back Dt` |
| 7093 | 12 | `TM C back Dt` |
| 7094 | 12 | `8.FR fall Dt` |
| 7096 | 12 | `9.FR back Dt` |
| 7098 | 14 | `10.Pos C go Dt` |
| 7099 | 11 | `Pos C go Dt` |
| 7201 | 12 | `Z-axis PARAM` |
| 7202 | 12 | `Y-axis PARAM` |
| 7203 | 12 | `X-axis PARAM` |
| 7207 | 11 | `high 32 bit` |
| 7208 | 12 | `Clbt H 32bit` |
| 7220 | 17 | `38, the knife way` |
| 7221 | 12 | `Config PARAM` |
| 7225 | 16 | `Saxis Zphase I76` |
| 7226 | 22 | `ECAT_WKC R error count` |
| 7227 | 22 | `ECAT_WKC W error count` |
| 7264 | 19 | `Slave Followe error` |
| 7267 | 17 | `origin calibrat` |

## Nombres de parametros <a id="param_names"></a>

**Prioridad**: BAJA — Etiquetas de parametros de configuracion (General, Spindle, Port, Tool, Axis)

**220 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 5268 | 21 | `001,Inp Speed(mm/min)` |
| 5269 | 25 | `002,InpStartSpeed(mm/min)` |
| 5270 | 27 | `003,InpAcceleration(mm/sec)` |
| 5271 | 19 | `004,ZeroReturn Mode` |
| 5272 | 23 | `005, IO FilterWave(1~8)` |
| 5274 | 24 | `007,MaxFeedSpeed(mm/min)` |
| 5276 | 22 | `009, Wheel Coefficient` |
| 5277 | 25 | `010, M Code Delaytime(ms)` |
| 5278 | 15 | `011,Line number` |
| 5281 | 22 | `014,Circle InpUnit(mm)` |
| 5283 | 26 | `016,G83(M)LoopObligate(mm)` |
| 5284 | 16 | `017,Arc Inp Mode` |
| 5285 | 28 | `018,interpolation speed mode` |
| 5286 | 23 | `019,GCode pre-treatment` |
| 5287 | 15 | `020,'O'Pro Scan` |
| 5293 | 21 | `026,Arc Acc.for Radii` |
| 5294 | 21 | `027,Arc Acc.for Speed` |
| 5295 | 24 | `028,PretreatmentCode Set` |
| 5296 | 21 | `029,Inp AccSpeed Mode` |
| 5297 | 25 | `030,'S'Speed Acceleration` |
| 5301 | 26 | `034,default process plane` |
| 5302 | 15 | `035,T code form` |
| 5307 | 25 | `040,Pretreatment segments` |
| 5308 | 25 | `041,feed speed setting En` |
| 5309 | 26 | `042,enable of G00 Inp mode` |
| 5311 | 25 | `044,Z rise to safe pos En` |
| 5312 | 25 | `045,A rise to safe pos En` |
| 5313 | 27 | `046,Pro RZ to reference pos` |
| 5314 | 27 | `047,Mac RZ to reference pos` |
| 5316 | 17 | `049,Z safe height` |
| 5317 | 17 | `050,A safe height` |
| 5318 | 27 | `051,Z axis feed speed limit` |
| 5319 | 27 | `052,A axis feed speed limit` |
| 5323 | 20 | `056,M98 Jump Line EN` |
| 5324 | 24 | `057,System boot zero way` |
| 5326 | 27 | `059,ProCoordOversizeConvert` |
| 5327 | 28 | `060,4 axis max rotate speed` |
| 5329 | 27 | `062,Hand Wheel Control Mode` |
| 5330 | 23 | `063,Hand Wheel Max Rate` |
| 5332 | 30 | `065,machining end to reference` |
| 5333 | 16 | `axis config para` |
| 5335 | 18 | `001,Select SupMode` |
| 5338 | 14 | `004,Initialize` |
| 5339 | 24 | `005,Initialize IO Config` |
| 5341 | 15 | `007,para backup` |
| 5342 | 16 | `008,para recover` |
| 5343 | 23 | `009,generate cryptogram` |
| 5344 | 18 | `010,menu click way` |
| 5345 | 25 | `011,clear add up work num` |
| 5346 | 26 | `012,clear current work num` |
| 5347 | 20 | `013,maximum work num` |
| 5349 | 26 | `015,startup display module` |
| 5350 | 20 | `016,sys language bag` |
| 5352 | 27 | `018,startup picture display` |
| 5353 | 28 | `019,sys display axis setting` |
| 5354 | 28 | `020,sys debug information En` |
| 5355 | 30 | `021,axis control composite key` |
| 5356 | 27 | `022,additional panel enable` |
| 5360 | 23 | `026,Screen Safeguard En` |
| 5361 | 25 | `027,Modbus Poll/Slave Set` |
| 5367 | 20 | `003,Spi.Reset ELevel` |
| 5369 | 18 | `005,Spi.ECZ Elevel` |
| 5370 | 22 | `006,Spi. Limit+ Enable` |
| 5371 | 22 | `007,Spi. Limit- Enable` |
| 5372 | 20 | `008,Spi.Limit Elevel` |
| 5373 | 18 | `009,Spi.Pulse Mode` |
| 5374 | 24 | `010,Spi.Pulse Logic Mode` |
| 5377 | 21 | `013,Spi.Round Setting` |
| 5380 | 24 | `016,Spi.PulseLogic Level` |
| 5381 | 29 | `017,Spi.Rolling Display Usage` |
| 5382 | 21 | `018,Spi.Max Acc(Kpps)` |
| 5385 | 22 | `021,Spi.Max Speed(rpm)` |
| 5387 | 22 | `023,Spi.Gear Numerator` |
| 5388 | 24 | `024,Spi.Gear Denominator` |
| 5390 | 25 | `026,Spi.OpenDelayTime(ms)` |
| 5406 | 12 | `port config` |
| 5420 | 22 | `014,VFD 0 Level Output` |
| 5421 | 22 | `015,VFD 1 Level Output` |
| 5422 | 22 | `016,VFD 2 Level Output` |
| 5423 | 22 | `017,VFD 3 Level Output` |
| 5439 | 24 | `033,ExStart2 Check Input` |
| 5444 | 19 | `038,Ext Reset Input` |
| 5447 | 19 | `041,RunLight Output` |
| 5450 | 14 | `044,Oil Output` |
| 5451 | 15 | `045,Cool Output` |
| 5452 | 19 | `046,Oil Pump Output` |
| 5453 | 18 | `047,X Limit- Input` |
| 5454 | 22 | `X Limit+ Input` |
| 5455 | 22 | `Y Limit- Input` |
| 5456 | 22 | `Y Limit+ Input` |
| 5457 | 22 | `Z Limit- Input` |
| 5458 | 22 | `Z Limit+ Input` |
| 5459 | 22 | `4 Limit- Input` |
| 5460 | 22 | `4 Limit+ Input` |
| 5461 | 22 | `B Limit- Input` |
| 5462 | 22 | `B Limit+ Input` |
| 5463 | 22 | `C Limit- Input` |
| 5464 | 22 | `C Limit+ Input` |
| 5477 | 27 | `050,Input Check Level 00~31` |
| 5478 | 27 | `051,Input Check Level 32~63` |
| 5479 | 27 | `052,Input Check Level 64~95` |
| 5480 | 23 | `053,IO Conf Reset 00~31` |
| 5481 | 23 | `054,IO Conf Reset 32~63` |
| 5482 | 23 | `055,IO Conf Reset 64~95` |
| 5483 | 18 | `056,Led Reset 0~31` |
| 5484 | 19 | `057,Led Reset 32~63` |
| 5485 | 19 | `058,Led Reset 64~95` |
| 5489 | 20 | `X Standard Pos(#401)` |
| 5490 | 20 | `Y Standard Pos(#402)` |
| 5491 | 20 | `Z Standard Pos(#403)` |
| 5495 | 23 | `Rapid Descend Pos(#407)` |
| 5499 | 16 | `X safe Pos(#411)` |
| 5500 | 16 | `Y safe Pos(#412)` |
| 5503 | 18 | `max time(ms)(#401)` |
| 5525 | 41 | `synthesize para recover to factory value?` |
| 5526 | 39 | `IO confi para recover to factory value?` |
| 5527 | 39 | `this operate will wipe all para,comfrm?` |
| 5883 | 24 | `129,System boot zero way` |
| 6181 | 21 | `028,British system En` |
| 6186 | 30 | `066,Feed Rate Change Increment` |
| 6189 | 23 | `059,Start Out Open 0~31` |
| 6190 | 24 | `060,Start Out Open 32~63` |
| 6191 | 24 | `061,Start Out Open 64~95` |
| 6200 | 22 | `BacklashExpiate(pulse)` |
| 6203 | 16 | `ZeroReturn Speed` |
| 6205 | 21 | `restrain acc (mm/s^2)` |
| 6206 | 17 | `max restrain rate` |
| 6233 | 22 | `010,System Main Chanel` |
| 6240 | 30 | `029,additional panel baud rate` |
| 6241 | 12 | `062,Wheel0.1` |
| 6242 | 13 | `063,Wheel0.01` |
| 6243 | 14 | `064,Wheel0.001` |
| 6244 | 11 | `065,X Wheel` |
| 6245 | 11 | `066,Y Wheel` |
| 6246 | 11 | `067,Z Wheel` |
| 6247 | 11 | `068,A Wheel` |
| 6248 | 11 | `069,B Wheel` |
| 6249 | 11 | `070,C Wheel` |
| 6252 | 11 | `073,STARTUP` |
| 6273 | 11 | `071,7 Wheel` |
| 6274 | 11 | `072,8 Wheel` |
| 6283 | 22 | `077,X axis Reset Input` |
| 6292 | 26 | `014, System Shutdown Input` |
| 6293 | 27 | `015, System Shutdown Output` |
| 6309 | 43 | `070, dual-drive zero maximum deviation (mm)` |
| 6440 | 27 | `051,Z+axis feed speed limit` |
| 6441 | 27 | `052,A+axis feed speed limit` |
| 6571 | 19 | `005,IO Filter(0~15)` |
| 6575 | 21 | `078,Remote IP address` |
| 6598 | 28 | `010,System axis group config` |
| 6599 | 32 | `014,Import CSV sys config tables` |
| 6600 | 28 | `019,System axis group config` |
| 6630 | 22 | `047, Input level 00~31` |
| 6631 | 22 | `048, Input level 32~63` |
| 6632 | 22 | `049, Input level 64~95` |
| 6633 | 23 | `050, Input level 96~127` |
| 6634 | 24 | `051, Input level 128~159` |
| 6635 | 19 | `054, Reset IO 00~31` |
| 6636 | 19 | `055, Reset IO 32~63` |
| 6637 | 19 | `056, Reset IO 64~95` |
| 6638 | 20 | `057, Reset IO 96~127` |
| 6639 | 21 | `058, Reset IO 128~159` |
| 6640 | 21 | `059, Reset IO 160~191` |
| 6641 | 21 | `060, Reset IO 192~223` |
| 6642 | 19 | `061, Reset LED 0~31` |
| 6643 | 20 | `062, Reset LED 32~63` |
| 6644 | 20 | `063, Reset LED 64~95` |
| 6645 | 21 | `064, Reset LED 96~127` |
| 6646 | 22 | `065, Reset LED 128~159` |
| 6647 | 22 | `066, Reset LED 160~191` |
| 6648 | 22 | `067, Reset LED 192~223` |
| 6649 | 27 | `068, Start output open 0~31` |
| 6650 | 28 | `069, Start output open 32~63` |
| 6651 | 29 | `070, Start output open 64~95` |
| 6652 | 29 | `071, Start output open 96~127` |
| 6653 | 30 | `072, Start output open 128~159` |
| 6654 | 30 | `073, Start output open 160~191` |
| 6655 | 30 | `074, Start output open 192~223` |
| 6656 | 18 | `075, Handwheel 0.1` |
| 6657 | 19 | `076, Handwheel 0.01` |
| 6658 | 20 | `077, Handwheel 0.001` |
| 6659 | 26 | `078, Handwheel to choose X` |
| 6660 | 26 | `079, Handwheel to choose Y` |
| 6662 | 26 | `080, Handwheel to choose Z` |
| 6663 | 26 | `081, Handwheel to choose A` |
| 6664 | 26 | `082, Handwheel to choose B` |
| 6665 | 26 | `083, Handwheel to choose C` |
| 6666 | 26 | `084, Handwheel to choose 7` |
| 6667 | 26 | `085, Handwheel to choose 8` |
| 6668 | 23 | `086, Handwheel to start` |
| 6669 | 25 | `087, Handwheel to suspend` |
| 6681 | 153 | `Handwheel mode, When handwheel rotation speed is less than the corresponding list of speed, The current processing ratio for run rate value of the group.` |
| 6682 | 15 | `HandwheelS(rmp)` |
| 6684 | 14 | `HandwheelParam` |
| 6685 | 12 | `HandwheelRPM` |
| 6687 | 12 | `HandwheelPos` |
| 6710 | 12 | `Dual channel` |
| 6891 | 14 | `012,UART0 Baud` |
| 6892 | 11 | `036,LocalIP` |
| 6893 | 21 | `079,ModbusPollTimeOut` |
| 6894 | 16 | `080,ModbusResend` |
| 6895 | 14 | `081,UART3 Baud` |
| 6896 | 12 | `082,LocalIP2` |
| 6898 | 14 | `029,UART1 Baud` |
| 6912 | 25 | `HandwheelModelCan'tDoThis` |
| 6920 | 30 | `052, Input Check Level 160~191` |
| 6921 | 30 | `053, Input Check Level 192~223` |
| 7215 | 21 | `022,oilpump timing on` |
| 7216 | 26 | `023,oilpump hold time(sec)` |
| 7217 | 24 | `024,oilpump ctr freq(Hz)` |
| 7218 | 15 | `004,data backup` |
| 7219 | 16 | `005,data recovey` |
| 7237 | 21 | `059,G91 to G90 enable` |
| 7238 | 22 | `085,B-feed speed Limit` |
| 7240 | 27 | `089,Ext start 1 input port` |
| 7241 | 27 | `090,Ext start 2 input port` |
| 7244 | 27 | `093,Ext reset 1 input port` |
| 7245 | 26 | `094,Ext reset 1 input port` |
| 7246 | 27 | `095,Run light output 1port` |
| 8039 | 41 | `038,- - - - - - - - - - - - - - - - - - -` |

## Contrasenas y acceso <a id="passwords"></a>

**Prioridad**: BAJA — Password, superuser, operador, niveles de acceso

**22 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 5051 | 12 | `password set` |
| 5053 | 18 | `Administrator code` |
| 5054 | 21 | `operator Pre-Password` |
| 5055 | 21 | `operator New Password` |
| 5056 | 22 | `superuser Pre-Password` |
| 5057 | 22 | `superuser New Password` |
| 5058 | 22 | `pls enter Pre-Password` |
| 5059 | 22 | `pls enter New Password` |
| 5060 | 21 | `re-enter New Password` |
| 5063 | 24 | `pre-password input error` |
| 5064 | 22 | `Password reset success` |
| 5065 | 25 | `2 passwords Inconsistent` |
| 5066 | 27 | `pls input operater password` |
| 5067 | 28 | `pls input superuser password` |
| 5068 | 25 | `superuser password wrong?` |
| 5069 | 24 | `operater password wrong?` |
| 5075 | 35 | `only superuser can amend parameter.` |
| 5336 | 25 | `002,AlterSuperuserPasswor` |
| 5337 | 23 | `003,Alter User Password` |
| 5531 | 30 | `above operator can modify para` |
| 6467 | 17 | `Please Superuser!` |
| 6472 | 15 | `Must Superuser!` |

## Instrucciones de Teach/programacion guiada <a id="teach_instruct"></a>

**Prioridad**: BAJA — Mensajes del modo Teach-in, spline, arcos, instrucciones de ayuda

**73 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 5025 | 9 | `feed rate` |
| 5504 | 24 | `rest lock time(ms)(#402)` |
| 5505 | 26 | `delay of re-lock(ms)(#403)` |
| 5566 | 27 | `G7X8X Instruction Run Error` |
| 5723 | 35 | `delete all of the instruction data?` |
| 5732 | 73 | `1&gt; F1 Mode: change type 0: invalid 1:straight line 2:arc 3:spline 4:Gcode` |
| 5737 | 52 | `6&gt; F6: Help: quit aid interface press[F1]-[F6]/[CAN]` |
| 5742 | 49 | `11&gt; the number of spline curve's point at least 4` |
| 5748 | 50 | `data can not formation arc whit the previous value` |
| 5749 | 49 | `pls choose mode! 1-linear 2-arc 3-Spline  4G code` |
| 5750 | 27 | `more than 4 data for spline` |
| 5751 | 28 | `not allow  insert in the arc` |
| 5757 | 48 | `no input arc ending value, not allow switch mode` |
| 5758 | 6 | `X lock` |
| 5759 | 6 | `Y lock` |
| 5760 | 8 | `X Y lock` |
| 5761 | 6 | `Z lock` |
| 5762 | 8 | `X Z lock` |
| 5763 | 8 | `Y Z lock` |
| 5764 | 10 | `X Y Z lock` |
| 5765 | 6 | `A lock` |
| 5766 | 8 | `X A lock` |
| 5767 | 8 | `Y A lock` |
| 5768 | 10 | `X Y A lock` |
| 5769 | 9 | `Z A  lock` |
| 5770 | 10 | `X Z A lock` |
| 5771 | 10 | `Y Z A lock` |
| 5773 | 38 | `spline input number exceed upper limit` |
| 5774 | 45 | `no valid instruct data, can't generate G code` |
| 5775 | 45 | `input spline data can't generate spline curve` |
| 5776 | 57 | `the number of input SPL less than 4,can't generate G code` |
| 5777 | 54 | `input arc information incomplete,can't generate G code` |
| 5778 | 36 | `the first input point must be linear` |
| 5780 | 65 | `The first point must be line mode, enter the end point of a line!` |
| 5783 | 5 | `Teach` |
| 5787 | 8 | `Ins line` |
| 5788 | 7 | `Cur Pos` |
| 5825 | 23 | `X two-way plane milling` |
| 5826 | 23 | `Y two-way plane milling` |
| 5827 | 23 | `X one-way plane milling` |
| 5828 | 23 | `Y one-way plane milling` |
| 5829 | 25 | `XY plane circular milling` |
| 5830 | 24 | `XY plane Rectangular Box` |
| 5831 | 21 | `XY plane Circular Box` |
| 5832 | 26 | `Hole loop of circular mode` |
| 5856 | 18 | `Each cutting width` |
| 5860 | 24 | `X-axis workpiece len(mm)` |
| 5861 | 24 | `Y-axis workpiece len(mm)` |
| 5863 | 24 | `Each machining depth(mm)` |
| 5864 | 25 | `Total machining depth(mm)` |
| 5866 | 17 | `Feed rate(mm/min)` |
| 5867 | 33 | `Each cutting radius increment(mm)` |
| 5868 | 21 | `The circle radius(mm)` |
| 5869 | 22 | `cutting Dir:2-CW 3-CCW` |
| 5870 | 27 | `Box Mode:0-inside 1-outside` |
| 5871 | 21 | `The circle radius(mm)` |
| 5872 | 21 | `The circle radius(mm)` |
| 5873 | 20 | `The center X pos(mm)` |
| 5874 | 20 | `The center Y pos(mm)` |
| 5875 | 17 | `Cutting Mode(1-4)` |
| 5876 | 14 | `Starting angle` |
| 5877 | 11 | `Hole Number` |
| 5878 | 16 | `initial position` |
| 5879 | 24 | `Each machining depth(mm)` |
| 5882 | 19 | `Hole Bottom Pos(mm)` |
| 6099 | 4 | `Lock` |
| 6172 | 6 | `Spline` |
| 6802 | 11 | `CanNotTeach` |
| 6818 | 5 | `Teach` |
| 6825 | 5 | `Teach` |
| 7157 | 29 | `SYS use time end !need unlock` |
| 7205 | 9 | `open lock` |
| 7206 | 11 | `open w lock` |

## Elementos de interfaz (UI) <a id="ui_elements"></a>

**Prioridad**: BAJA — Menus, botones, soft keys, etiquetas de pantalla

**449 entradas**

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 4936 | 5 | `left` |
| 4949 | 1 | `P` |
| 4957 | 4 | `Open` |
| 5020 | 10 | `actual pos` |
| 5021 | 8 | `cut time` |
| 5022 | 8 | `sys time` |
| 5026 | 5 | `Count` |
| 5027 | 9 | `Fast rate` |
| 5031 | 5 | `Speed` |
| 5032 | 4 | `Mode` |
| 5034 | 7 | `Machine` |
| 5043 | 3 | `RUN` |
| 5045 | 5 | `PARAM` |
| 5047 | 4 | `TEST` |
| 5048 | 3 | `EOB` |
| 5049 | 6 | `cancel` |
| 5061 | 3 | `EOB` |
| 5062 | 6 | `cancle` |
| 5102 | 4 | `Test` |
| 5104 | 4 | `Para` |
| 5106 | 3 | `Run` |
| 5107 | 10 | `X zero I00` |
| 5108 | 10 | `Y zero I01` |
| 5109 | 10 | `Z zero I02` |
| 5110 | 10 | `A zero I03` |
| 5137 | 9 | `start I30` |
| 5145 | 9 | `X ECZ I40` |
| 5146 | 9 | `Y ECZ I43` |
| 5147 | 9 | `Z ECZ I46` |
| 5148 | 9 | `A ECZ I49` |
| 5149 | 9 | `S ECZ I52` |
| 5174 | 6 | `XOUT24` |
| 5175 | 6 | `YOUT25` |
| 5176 | 6 | `ZOUT26` |
| 5177 | 6 | `AOUT27` |
| 5179 | 8 | `Sys info` |
| 5180 | 4 | `D A` |
| 5181 | 7 | `DA Test` |
| 5182 | 6 | `Output` |
| 5183 | 6 | `O Test` |
| 5184 | 5 | `Input` |
| 5185 | 6 | `I Test` |
| 5186 | 5 | `Alert` |
| 5187 | 10 | `Alert info` |
| 5188 | 5 | `dgnos` |
| 5189 | 5 | `dgnos` |
| 5194 | 4 | `Skip` |
| 5196 | 4 | `Seek` |
| 5198 | 4 | `New` |
| 5206 | 5 | `To pc` |
| 5208 | 3 | `Cut` |
| 5209 | 5 | `Paste` |
| 5211 | 4 | `New` |
| 5212 | 7 | `Devices` |
| 5214 | 4 | `news` |
| 5215 | 7 | `confirm` |
| 5216 | 6 | `cancel` |
| 5217 | 10 | `My Devices` |
| 5221 | 10 | `My Devices` |
| 5230 | 5 | `Exp` |
| 5231 | 5 | `Set` |
| 5232 | 5 | `Halve` |
| 5234 | 4 | `Test` |
| 5235 | 7 | `Measure` |
| 5237 | 5 | `HALVE` |
| 5238 | 3 | `Set` |
| 5239 | 7 | `Expiate` |
| 5242 | 7 | `General` |
| 5243 | 7 | `All Pos` |
| 5244 | 3 | `Rel` |
| 5245 | 7 | `rel pos` |
| 5246 | 3 | `Abs` |
| 5248 | 3 | `Pos` |
| 5249 | 3 | `Aid` |
| 5250 | 4 | `Part` |
| 5252 | 4 | `User` |
| 5267 | 7 | `General` |
| 5334 | 6 | `Manage` |
| 5486 | 8 | `end mark` |
| 5507 | 4 | `Port` |
| 5508 | 4 | `Port` |
| 5509 | 7 | `IO para` |
| 5516 | 6 | `Manage` |
| 5517 | 6 | `Manage` |
| 5518 | 6 | `Manage` |
| 5519 | 4 | `Axis` |
| 5520 | 4 | `Axis` |
| 5521 | 4 | `Axis` |
| 5522 | 4 | `Genl` |
| 5523 | 7 | `general` |
| 5524 | 4 | `para` |
| 5533 | 5 | `Plane` |
| 5536 | 7 | `Preview` |
| 5537 | 8 | `Tracking` |
| 5538 | 3 | `Cls` |
| 5539 | 4 | `Path` |
| 5540 | 12 | `Path picture` |
| 5541 | 12 | `input line #` |
| 5542 | 10 | `input Nxxx` |
| 5543 | 20 | `can't find the N add` |
| 5545 | 27 | `This parameter is read-only` |
| 5555 | 9 | `Seek line` |
| 5556 | 6 | `Seek N` |
| 5558 | 5 | `Reset` |
| 5560 | 28 | `No Appointed Motion Function` |
| 5561 | 25 | `No GCode GetLine Function` |
| 5562 | 10 | `M6Tx Abort` |
| 5567 | 16 | `PortNumber Error` |
| 5668 | 7 | `GCodeRe` |
| 5679 | 7 | `Reserve` |
| 5705 | 3 | `Exp` |
| 5710 | 10 | `Find Over!` |
| 5781 | 5 | `Del` |
| 5785 | 4 | `Help` |
| 5789 | 6 | `G code` |
| 5790 | 4 | `Mode` |
| 5791 | 3 | `Num` |
| 5792 | 4 | `mode` |
| 5793 | 6 | `Module` |
| 5801 | 3 | `Nos` |
| 5802 | 5 | `Angle` |
| 5804 | 5 | `Check` |
| 5816 | 3 | `Nos` |
| 5853 | 6 | `(-)T++` |
| 5902 | 5 | `Exp` |
| 5905 | 5 | `Adi 2` |
| 5906 | 10 | `Time Split` |
| 5907 | 9 | `Pos Split` |
| 5908 | 5 | `Angle` |
| 5909 | 5 | `Speed` |
| 5910 | 9 | `Real Time` |
| 5917 | 1 | `A` |
| 5921 | 1 | `M` |
| 5923 | 1 | `R` |
| 5925 | 6 | `Refer1` |
| 5926 | 6 | `Refer2` |
| 5927 | 6 | `Refer3` |
| 5928 | 6 | `Refer4` |
| 5929 | 9 | `Work Time` |
| 5930 | 8 | `Sys Time` |
| 5931 | 7 | `Inp Add` |
| 5932 | 10 | `Totalcount` |
| 5933 | 1 | `B` |
| 5934 | 1 | `C` |
| 6010 | 9 | `X ECZ I72` |
| 6011 | 9 | `Y ECZ I73` |
| 6012 | 9 | `Z ECZ I74` |
| 6013 | 9 | `A ECZ I75` |
| 6014 | 9 | `B ECZ I76` |
| 6015 | 9 | `C ECZ I77` |
| 6016 | 9 | `X ECA I78` |
| 6017 | 9 | `X ECB I79` |
| 6018 | 9 | `Y ECA I80` |
| 6019 | 9 | `Y ECB I81` |
| 6020 | 9 | `Z ECA I82` |
| 6021 | 9 | `Z ECB I83` |
| 6022 | 9 | `A ECA I84` |
| 6023 | 9 | `A ECB I85` |
| 6024 | 9 | `B ECA I86` |
| 6025 | 9 | `B ECB I87` |
| 6026 | 9 | `C ECA I88` |
| 6027 | 9 | `C ECB I89` |
| 6066 | 7 | `Encrypt` |
| 6067 | 7 | `SD Disk` |
| 6111 | 4 | `Blow` |
| 6155 | 8 | `Middle` |
| 6156 | 5 | `Demo7` |
| 6157 | 5 | `Demo6` |
| 6158 | 5 | `Demo5` |
| 6159 | 5 | `Demo4` |
| 6160 | 5 | `Demo3` |
| 6161 | 5 | `Demo2` |
| 6162 | 5 | `Demo1` |
| 6163 | 4 | `Demo` |
| 6164 | 6 | `Output` |
| 6166 | 5 | `Input` |
| 6167 | 10 | `Input Test` |
| 6168 | 7 | `IO Test` |
| 6169 | 7 | `Invalid` |
| 6170 | 4 | `Line` |
| 6171 | 3 | `Arc` |
| 6173 | 5 | `GCode` |
| 6180 | 6 | `EXT IO` |
| 6182 | 7 | `S Curve` |
| 6183 | 8 | `S Curve2` |
| 6184 | 7 | `Deviate` |
| 6185 | 9 | `Devia Pos` |
| 6291 | 10 | `ProductSet` |
| 6297 | 10 | `Work range` |
| 6298 | 9 | `Axis Mini` |
| 6299 | 8 | `Axis MAX` |
| 6317 | 7 | `Blk Del` |
| 6318 | 9 | `Blk Paste` |
| 6320 | 7 | `Row Del` |
| 6321 | 9 | `Row Paste` |
| 6326 | 9 | `OutputSet` |
| 6328 | 7 | `AxisMax` |
| 6329 | 7 | `AxisMin` |
| 6386 | 10 | `Chamfer _C` |
| 6390 | 8 | `ViewInfo` |
| 6391 | 8 | `circle 1` |
| 6392 | 8 | `circle 2` |
| 6393 | 9 | `circle 3` |
| 6394 | 10 | `Slotting 1` |
| 6395 | 10 | `Slotting 2` |
| 6396 | 7 | `CircleZ` |
| 6397 | 7 | `CircleY` |
| 6398 | 7 | `CircleX` |
| 6399 | 4 | `Move` |
| 6400 | 10 | `Arc slot 1` |
| 6401 | 10 | `Arc slot 2` |
| 6402 | 10 | `Arc slot 3` |
| 6403 | 7 | `Track 1` |
| 6404 | 7 | `Track 2` |
| 6405 | 8 | `tenon 1` |
| 6406 | 7 | `tenon2` |
| 6407 | 10 | `BorderScan` |
| 6421 | 10 | `AContOTime` |
| 6422 | 10 | `BContOTime` |
| 6426 | 10 | `CustomErr1` |
| 6427 | 10 | `CustomErr2` |
| 6428 | 10 | `CustomErr3` |
| 6430 | 8 | `InpCycle` |
| 6434 | 7 | `AMT In1` |
| 6435 | 7 | `AMT In2` |
| 6436 | 5 | `0.5ms` |
| 6437 | 3 | `1ms` |
| 6438 | 3 | `2ms` |
| 6439 | 3 | `4ms` |
| 6444 | 6 | `DiskIn` |
| 6457 | 6 | `path 1` |
| 6458 | 6 | `Path 2` |
| 6459 | 6 | `Path 3` |
| 6460 | 6 | `Path 4` |
| 6461 | 4 | `NULL` |
| 6473 | 8 | `Disk(D:)` |
| 6474 | 6 | `Decode` |
| 6552 | 2 | `No` |
| 6553 | 3 | `Odd` |
| 6554 | 4 | `Even` |
| 6555 | 6 | `No ext` |
| 6556 | 7 | `485 ext` |
| 6557 | 6 | `ET1616` |
| 6558 | 6 | `EM8200` |
| 6560 | 9 | `Channel 1` |
| 6561 | 8 | `Rel type` |
| 6562 | 8 | `Abs type` |
| 6564 | 6 | `QX,QS8` |
| 6565 | 5 | `DO13i` |
| 6567 | 8 | `QXE-ECAT` |
| 6568 | 9 | `Panasonic` |
| 6569 | 4 | `CPU1` |
| 6570 | 2 | `VM` |
| 6689 | 6 | `T_FUNC` |
| 6691 | 6 | `M_FUNC` |
| 6692 | 5 | `GRUN7` |
| 6693 | 5 | `GRUN6` |
| 6694 | 5 | `GRUN5` |
| 6695 | 5 | `GRUN4` |
| 6696 | 6 | `path 1` |
| 6697 | 6 | `path 2` |
| 6698 | 6 | `path 3` |
| 6699 | 6 | `path 4` |
| 6711 | 6 | `Auxil3` |
| 6728 | 10 | `B zero I04` |
| 6750 | 8 | `SP Z I77` |
| 6751 | 7 | `SP1_I93` |
| 6752 | 7 | `SP2_I94` |
| 6758 | 7 | `X OUT48` |
| 6759 | 7 | `Y OUT49` |
| 6760 | 7 | `Z OUT50` |
| 6761 | 7 | `A OUT51` |
| 6762 | 7 | `B OUT52` |
| 6763 | 7 | `C OUT53` |
| 6764 | 7 | `SP2 O54` |
| 6765 | 7 | `SP4 O55` |
| 6766 | 7 | `SP6 O56` |
| 6767 | 7 | `SP1 O57` |
| 6768 | 7 | `SP3 O58` |
| 6769 | 7 | `SP5 O59` |
| 6771 | 5 | `FindS` |
| 6772 | 8 | `ReplaceS` |
| 6773 | 4 | `Find` |
| 6774 | 7 | `Replace` |
| 6775 | 3 | `CAN` |
| 6776 | 7 | `FindErr` |
| 6777 | 10 | `FindS Wait` |
| 6779 | 7 | `XY Plan` |
| 6780 | 7 | `XZ Plan` |
| 6781 | 7 | `XY Plan` |
| 6782 | 7 | `XC Plan` |
| 6783 | 7 | `XZ Plan` |
| 6784 | 7 | `CZ Plan` |
| 6785 | 4 | `ArcC` |
| 6786 | 4 | `ArcR` |
| 6787 | 6 | `CW/CCW` |
| 6788 | 5 | `Speed` |
| 6790 | 8 | `SpaceArc` |
| 6791 | 6 | `AStart` |
| 6792 | 7 | `AMiddle` |
| 6793 | 4 | `AEnd` |
| 6794 | 5 | `Speed` |
| 6799 | 10 | `ReplaceErr` |
| 6800 | 9 | `RelaceErr` |
| 6812 | 3 | `New` |
| 6813 | 4 | `Jump` |
| 6814 | 4 | `Repl` |
| 6815 | 4 | `Find` |
| 6816 | 3 | `Del` |
| 6819 | 5 | `Modif` |
| 6820 | 5 | `XZArc` |
| 6821 | 5 | `YZArc` |
| 6822 | 5 | `XYArc` |
| 6823 | 6 | `SpaceA` |
| 6824 | 4 | `Line` |
| 6826 | 4 | `Repl` |
| 6832 | 10 | `ActionFail` |
| 6833 | 10 | `ActionExec` |
| 6834 | 7 | `IsBusy` |
| 6839 | 4 | `Time` |
| 6840 | 9 | `Undefined` |
| 6868 | 10 | `CantNotRun` |
| 6870 | 2 | `No` |
| 6873 | 10 | `UART0_POLL` |
| 6874 | 10 | `UART1_POLL` |
| 6875 | 10 | `UART3_POLL` |
| 6876 | 8 | `TCP_POLL` |
| 6877 | 8 | `UDP_POLL` |
| 6878 | 2 | `NO` |
| 6879 | 4 | `Dect` |
| 6880 | 2 | `No` |
| 6881 | 3 | `Val` |
| 6884 | 8 | `ECATZero` |
| 6885 | 9 | `DELTA_ABS` |
| 6886 | 8 | `YIFE-ABS` |
| 6887 | 6 | `HC_ABS` |
| 6888 | 7 | `EM_ECAT` |
| 6889 | 7 | `HC_ECAT` |
| 6897 | 8 | `MacAddr2` |
| 6915 | 6 | `F rate` |
| 6916 | 7 | `F pitch` |
| 6922 | 5 | `POLIH` |
| 6923 | 3 | `YES` |
| 6924 | 2 | `NO` |
| 6925 | 9 | `OPEN[EOB]` |
| 6927 | 5 | `RESET` |
| 6937 | 4 | `help` |
| 6938 | 3 | `CAM` |
| 6939 | 5 | `Empty` |
| 6940 | 5 | `paste` |
| 6942 | 6 | `delete` |
| 6945 | 5 | `serch` |
| 6946 | 4 | `type` |
| 6964 | 3 | `YES` |
| 6965 | 2 | `NO` |
| 6966 | 9 | `OPEN[EOB]` |
| 6968 | 5 | `RESET` |
| 6978 | 4 | `help` |
| 6979 | 3 | `CAM` |
| 6980 | 5 | `Empty` |
| 6981 | 5 | `paste` |
| 6983 | 6 | `delete` |
| 6986 | 5 | `serch` |
| 6987 | 4 | `type` |
| 6997 | 8 | `Spr lead` |
| 7004 | 10 | `08.G speed` |
| 7005 | 7 | `G speed` |
| 7007 | 9 | `G Ang_Vel` |
| 7010 | 6 | `degree` |
| 7024 | 8 | `GW depth` |
| 7027 | 4 | `Y1N0` |
| 7031 | 9 | `2GG Y POS` |
| 7033 | 9 | `2GG depth` |
| 7058 | 4 | `Fast` |
| 7067 | 8 | `38.Feed?` |
| 7068 | 4 | `Feed` |
| 7069 | 7 | `39.Knif` |
| 7070 | 4 | `Knif` |
| 7071 | 6 | `40.GG?` |
| 7072 | 3 | `GG?` |
| 7077 | 8 | `43.Unlod` |
| 7080 | 9 | `CM Rel Dt` |
| 7081 | 6 | `second` |
| 7083 | 10 | `Flap up Dt` |
| 7089 | 9 | `TMC TM Dt` |
| 7091 | 10 | `CM C CM Dt` |
| 7095 | 10 | `FR fall Dt` |
| 7097 | 10 | `FR back Dt` |
| 7108 | 10 | `UL C UL Dt` |
| 7139 | 9 | `PARAM SET` |
| 7140 | 7 | `descrip` |
| 7141 | 5 | `unit:` |
| 7142 | 6 | `range:` |
| 7144 | 2 | `MC` |
| 7145 | 9 | `Act PARAM` |
| 7146 | 3 | `Dly` |
| 7147 | 7 | `Act Dly` |
| 7148 | 4 | `Test` |
| 7179 | 6 | `X axis` |
| 7180 | 6 | `Export` |
| 7181 | 6 | `Y-axis` |
| 7182 | 6 | `Z-axis` |
| 7183 | 6 | `A-axis` |
| 7184 | 6 | `B-axis` |
| 7185 | 6 | `C-axis` |
| 7186 | 6 | `7-axis` |
| 7187 | 6 | `8-axis` |
| 7188 | 6 | `9-axis` |
| 7189 | 7 | `10-axis` |
| 7190 | 7 | `11-axis` |
| 7191 | 7 | `12-axis` |
| 7204 | 7 | `X Param` |
| 7209 | 2 | `A6` |
| 7222 | 9 | `start I62` |
| 7228 | 5 | `DEBUG` |
| 7231 | 9 | `Panasonic` |
| 7232 | 5 | `PARAM` |
| 7233 | 8 | `Cur Page` |
| 7234 | 2 | `TY` |
| 7235 | 2 | `PE` |
| 7248 | 6 | `Chute1` |
| 7249 | 6 | `Chute2` |
| 7250 | 5 | `hole1` |
| 7251 | 5 | `hole2` |
| 7252 | 5 | `MR XY` |
| 7253 | 5 | `MR XZ` |
| 7254 | 5 | `MR YZ` |
| 7255 | 6 | `In_arc` |
| 7256 | 5 | `P_arc` |
| 7258 | 5 | `Wear` |
| 7262 | 9 | `syn error` |
| 7265 | 10 | `All errors` |
| 7268 | 1 | `T` |
| 7269 | 5 | `index` |
| 7270 | 3 | `sin` |
| 7530 | 6 | `XOUT24` |
| 7531 | 6 | `YOUT25` |
| 7532 | 6 | `ZOUT26` |
| 7533 | 6 | `AOUT27` |
| 7536 | 6 | `D A` |
| 7904 | 1 | `X` |
| 7905 | 1 | `Y` |
| 7906 | 1 | `Z` |
| 7907 | 1 | `A` |
| 8033 | 7 | `Reserve` |
| 8049 | 1 | `R` |
| 8050 | 1 | `T` |
| 8285 | 1 | `B` |
| 8286 | 1 | `C` |

---

## Indice por longitud de bytes

Util para buscar textos de reemplazo del mismo largo.
Agrupado por cantidad de bytes del texto original.

### 1-5 bytes (302 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 4949 | 1 | `P` |
| 5917 | 1 | `A` |
| 5921 | 1 | `M` |
| 5923 | 1 | `R` |
| 5933 | 1 | `B` |
| 5934 | 1 | `C` |
| 7268 | 1 | `T` |
| 7904 | 1 | `X` |
| 7905 | 1 | `Y` |
| 7906 | 1 | `Z` |
| 7907 | 1 | `A` |
| 8049 | 1 | `R` |
| 8050 | 1 | `T` |
| 8285 | 1 | `B` |
| 8286 | 1 | `C` |
| 6552 | 2 | `No` |
| 6570 | 2 | `VM` |
| 6870 | 2 | `No` |
| 6878 | 2 | `NO` |
| 6880 | 2 | `No` |
| 6924 | 2 | `NO` |
| 6965 | 2 | `NO` |
| 7144 | 2 | `MC` |
| 7209 | 2 | `A6` |
| 7234 | 2 | `TY` |
| 7235 | 2 | `PE` |
| 4923 | 3 | `MPG` |
| 4926 | 3 | `JOG` |
| 5043 | 3 | `RUN` |
| 5048 | 3 | `EOB` |
| 5061 | 3 | `EOB` |
| 5106 | 3 | `Run` |
| 5200 | 3 | `MDI` |
| 5208 | 3 | `Cut` |
| 5238 | 3 | `Set` |
| 5244 | 3 | `Rel` |
| 5246 | 3 | `Abs` |
| 5248 | 3 | `Pos` |
| 5249 | 3 | `Aid` |
| 5538 | 3 | `Cls` |
| 5705 | 3 | `Exp` |
| 5791 | 3 | `Num` |
| 5801 | 3 | `Nos` |
| 5816 | 3 | `Nos` |
| 6171 | 3 | `Arc` |
| 6437 | 3 | `1ms` |
| 6438 | 3 | `2ms` |
| 6439 | 3 | `4ms` |
| 6553 | 3 | `Odd` |
| 6775 | 3 | `CAN` |
| 6812 | 3 | `New` |
| 6816 | 3 | `Del` |
| 6881 | 3 | `Val` |
| 6923 | 3 | `YES` |
| 6938 | 3 | `CAM` |
| 6964 | 3 | `YES` |
| 6979 | 3 | `CAM` |
| 7072 | 3 | `GG?` |
| 7146 | 3 | `Dly` |
| 7270 | 3 | `sin` |
| 7556 | 3 | `MDI` |
| 4922 | 4 | `EDIT` |
| 4924 | 4 | `STEP` |
| 4925 | 4 | `AUTO` |
| 4927 | 4 | `HOME` |
| 4956 | 4 | `Save` |
| 4957 | 4 | `Open` |
| 5032 | 4 | `Mode` |
| 5036 | 4 | `Prog` |
| 5044 | 4 | `Edit` |
| 5047 | 4 | `TEST` |
| 5102 | 4 | `Test` |
| 5104 | 4 | `Para` |
| 5105 | 4 | `Edit` |
| 5113 | 4 | `IN06` |
| 5114 | 4 | `IN07` |
| 5115 | 4 | `IN08` |
| 5116 | 4 | `IN09` |
| 5180 | 4 | `D A` |
| 5194 | 4 | `Skip` |
| 5196 | 4 | `Seek` |
| 5198 | 4 | `New` |
| 5199 | 4 | `Edit` |
| 5210 | 4 | `Copy` |
| 5211 | 4 | `New` |
| 5213 | 4 | `File` |
| 5214 | 4 | `news` |
| 5234 | 4 | `Test` |
| 5250 | 4 | `Part` |
| 5252 | 4 | `User` |
| 5507 | 4 | `Port` |
| 5508 | 4 | `Port` |
| 5514 | 4 | `Tool` |
| 5515 | 4 | `Tool` |
| 5519 | 4 | `Axis` |
| 5520 | 4 | `Axis` |
| 5521 | 4 | `Axis` |
| 5522 | 4 | `Genl` |
| 5524 | 4 | `para` |
| 5539 | 4 | `Path` |
| 5784 | 4 | `Load` |
| 5785 | 4 | `Help` |
| 5790 | 4 | `Mode` |
| 5792 | 4 | `mode` |
| 6099 | 4 | `Lock` |
| 6111 | 4 | `Blow` |
| 6163 | 4 | `Demo` |
| 6170 | 4 | `Line` |
| 6178 | 4 | `Tool` |
| 6399 | 4 | `Move` |
| 6461 | 4 | `NULL` |
| 6475 | 4 | `Copy` |
| 6554 | 4 | `Even` |
| 6569 | 4 | `CPU1` |
| 6731 | 4 | `IN24` |
| 6732 | 4 | `IN25` |
| 6733 | 4 | `IN26` |
| 6734 | 4 | `IN27` |
| 6735 | 4 | `IN28` |
| 6736 | 4 | `IN29` |
| 6737 | 4 | `IN30` |
| 6738 | 4 | `IN31` |
| 6739 | 4 | `IN32` |
| 6740 | 4 | `IN33` |
| 6741 | 4 | `IN34` |
| 6742 | 4 | `IN35` |
| 6743 | 4 | `IN36` |
| 6744 | 4 | `IN37` |
| 6745 | 4 | `IN40` |
| 6746 | 4 | `IN43` |
| 6747 | 4 | `IN46` |
| 6748 | 4 | `IN49` |
| 6749 | 4 | `IN52` |
| 6773 | 4 | `Find` |
| 6785 | 4 | `ArcC` |
| 6786 | 4 | `ArcR` |
| 6793 | 4 | `AEnd` |
| 6813 | 4 | `Jump` |
| 6814 | 4 | `Repl` |
| 6815 | 4 | `Find` |
| 6817 | 4 | `Save` |
| 6824 | 4 | `Line` |
| 6826 | 4 | `Repl` |
| 6839 | 4 | `Time` |
| 6879 | 4 | `Dect` |
| 6937 | 4 | `help` |
| 6941 | 4 | `copy` |
| 6944 | 4 | `load` |
| 6946 | 4 | `type` |
| 6978 | 4 | `help` |
| 6982 | 4 | `copy` |
| 6985 | 4 | `load` |
| 6987 | 4 | `type` |
| 7027 | 4 | `Y1N0` |
| 7058 | 4 | `Fast` |
| 7068 | 4 | `Feed` |
| 7070 | 4 | `Knif` |
| 7148 | 4 | `Test` |
| 4918 | 5 | `Stop` |
| 4921 | 5 | `Close` |
| 4936 | 5 | `left` |
| 5026 | 5 | `Count` |
| 5031 | 5 | `Speed` |
| 5045 | 5 | `PARAM` |
| 5046 | 5 | `COORD` |
| 5103 | 5 | `Coord` |
| 5122 | 5 | `IN15` |
| 5152 | 5 | `OUT02` |
| 5153 | 5 | `OUT03` |
| 5154 | 5 | `OUT04` |
| 5155 | 5 | `OUT05` |
| 5156 | 5 | `OUT06` |
| 5157 | 5 | `OUT07` |
| 5158 | 5 | `OUT08` |
| 5159 | 5 | `OUT09` |
| 5160 | 5 | `OUT10` |
| 5161 | 5 | `OUT11` |
| 5162 | 5 | `OUT12` |
| 5163 | 5 | `OUT13` |
| 5164 | 5 | `OUT14` |
| 5165 | 5 | `OUT15` |
| 5166 | 5 | `OUT16` |
| 5167 | 5 | `OUT17` |
| 5168 | 5 | `OUT18` |
| 5169 | 5 | `OUT19` |
| 5170 | 5 | `OUT20` |
| 5171 | 5 | `OUT21` |
| 5172 | 5 | `OUT22` |
| 5173 | 5 | `OUT23` |
| 5184 | 5 | `Input` |
| 5186 | 5 | `Alert` |
| 5188 | 5 | `dgnos` |
| 5189 | 5 | `dgnos` |
| 5206 | 5 | `To pc` |
| 5209 | 5 | `Paste` |
| 5229 | 5 | `Coord` |
| 5230 | 5 | `Exp` |
| 5231 | 5 | `Set` |
| 5232 | 5 | `Halve` |
| 5233 | 5 | `T Cut` |
| 5237 | 5 | `HALVE` |
| 5240 | 5 | `Coord` |
| 5241 | 5 | `Coord` |
| 5251 | 5 | `Macro` |
| 5513 | 5 | `Tools` |
| 5532 | 5 | `Coord` |
| 5533 | 5 | `Plane` |
| 5558 | 5 | `Reset` |
| 5659 | 5 | `SCRAM` |
| 5694 | 5 | `Diame` |
| 5706 | 5 | `T cut` |
| 5781 | 5 | `Del` |
| 5783 | 5 | `Teach` |
| 5802 | 5 | `Angle` |
| 5804 | 5 | `Check` |
| 5846 | 5 | `(F)F0` |
| 5847 | 5 | `(Z)F1` |
| 5848 | 5 | `(1)F2` |
| 5849 | 5 | `(2)F3` |
| 5850 | 5 | `(3)F4` |
| 5902 | 5 | `Exp` |
| 5905 | 5 | `Adi 2` |
| 5908 | 5 | `Angle` |
| 5909 | 5 | `Speed` |
| 6156 | 5 | `Demo7` |
| 6157 | 5 | `Demo6` |
| 6158 | 5 | `Demo5` |
| 6159 | 5 | `Demo4` |
| 6160 | 5 | `Demo3` |
| 6161 | 5 | `Demo2` |
| 6162 | 5 | `Demo1` |
| 6166 | 5 | `Input` |
| 6173 | 5 | `GCode` |
| 6436 | 5 | `0.5ms` |
| 6463 | 5 | `Edit2` |
| 6565 | 5 | `DO13i` |
| 6692 | 5 | `GRUN7` |
| 6693 | 5 | `GRUN6` |
| 6694 | 5 | `GRUN5` |
| 6695 | 5 | `GRUN4` |
| 6753 | 5 | `OUT24` |
| 6754 | 5 | `OUT25` |
| 6755 | 5 | `OUT26` |
| 6756 | 5 | `OUT27` |
| 6757 | 5 | `OUT28` |
| 6771 | 5 | `FindS` |
| 6788 | 5 | `Speed` |
| 6794 | 5 | `Speed` |
| 6818 | 5 | `Teach` |
| 6819 | 5 | `Modif` |
| 6820 | 5 | `XZArc` |
| 6821 | 5 | `YZArc` |
| 6822 | 5 | `XYArc` |
| 6825 | 5 | `Teach` |
| 6882 | 5 | `Servo` |
| 6922 | 5 | `POLIH` |
| 6927 | 5 | `RESET` |
| 6939 | 5 | `Empty` |
| 6940 | 5 | `paste` |
| 6945 | 5 | `serch` |
| 6968 | 5 | `RESET` |
| 6980 | 5 | `Empty` |
| 6981 | 5 | `paste` |
| 6986 | 5 | `serch` |
| 7141 | 5 | `unit:` |
| 7228 | 5 | `DEBUG` |
| 7232 | 5 | `PARAM` |
| 7250 | 5 | `hole1` |
| 7251 | 5 | `hole2` |
| 7252 | 5 | `MR XY` |
| 7253 | 5 | `MR XZ` |
| 7254 | 5 | `MR YZ` |
| 7256 | 5 | `P_arc` |
| 7258 | 5 | `Wear` |
| 7269 | 5 | `index` |
| 7508 | 5 | `OUT02` |
| 7509 | 5 | `OUT03` |
| 7510 | 5 | `OUT04` |
| 7511 | 5 | `OUT05` |
| 7512 | 5 | `OUT06` |
| 7513 | 5 | `OUT07` |
| 7514 | 5 | `OUT08` |
| 7515 | 5 | `OUT09` |
| 7516 | 5 | `OUT10` |
| 7517 | 5 | `OUT11` |
| 7518 | 5 | `OUT12` |
| 7519 | 5 | `OUT13` |
| 7520 | 5 | `OUT14` |
| 7521 | 5 | `OUT15` |
| 7522 | 5 | `OUT16` |
| 7523 | 5 | `OUT17` |
| 7524 | 5 | `OUT18` |
| 7525 | 5 | `OUT19` |
| 7526 | 5 | `OUT20` |
| 7527 | 5 | `OUT21` |
| 7528 | 5 | `OUT22` |
| 7529 | 5 | `OUT23` |
| 8200 | 5 | `(F)F0` |
| 8201 | 5 | `(Z)F1` |
| 8202 | 5 | `(1)F2` |
| 8203 | 5 | `(2)F3` |
| 8204 | 5 | `(3)F4` |

### 6-10 bytes (472 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 4920 | 6 | `Pause` |
| 5049 | 6 | `cancel` |
| 5062 | 6 | `cancle` |
| 5111 | 6 | `IN04` |
| 5112 | 6 | `IN05` |
| 5117 | 6 | `IN10` |
| 5118 | 6 | `IN11` |
| 5119 | 6 | `IN12` |
| 5120 | 6 | `IN13` |
| 5121 | 6 | `IN14` |
| 5174 | 6 | `XOUT24` |
| 5175 | 6 | `YOUT25` |
| 5176 | 6 | `ZOUT26` |
| 5177 | 6 | `AOUT27` |
| 5182 | 6 | `Output` |
| 5183 | 6 | `O Test` |
| 5185 | 6 | `I Test` |
| 5216 | 6 | `cancel` |
| 5236 | 6 | `TCheck` |
| 5334 | 6 | `Manage` |
| 5516 | 6 | `Manage` |
| 5517 | 6 | `Manage` |
| 5518 | 6 | `Manage` |
| 5556 | 6 | `Seek N` |
| 5758 | 6 | `X lock` |
| 5759 | 6 | `Y lock` |
| 5761 | 6 | `Z lock` |
| 5765 | 6 | `A lock` |
| 5782 | 6 | `Save` |
| 5789 | 6 | `G code` |
| 5793 | 6 | `Module` |
| 5794 | 6 | `DA (G)` |
| 5809 | 6 | `Offset` |
| 5834 | 6 | `A Comp` |
| 5835 | 6 | `Z Comp` |
| 5836 | 6 | `Y Comp` |
| 5837 | 6 | `X Comp` |
| 5840 | 6 | `(9)M01` |
| 5853 | 6 | `(-)T++` |
| 5854 | 6 | `(0)T--` |
| 5925 | 6 | `Refer1` |
| 5926 | 6 | `Refer2` |
| 5927 | 6 | `Refer3` |
| 5928 | 6 | `Refer4` |
| 6095 | 6 | `Z Comp` |
| 6112 | 6 | `Tool +` |
| 6113 | 6 | `Tool -` |
| 6164 | 6 | `Output` |
| 6172 | 6 | `Spline` |
| 6180 | 6 | `EXT IO` |
| 6444 | 6 | `DiskIn` |
| 6457 | 6 | `path 1` |
| 6458 | 6 | `Path 2` |
| 6459 | 6 | `Path 3` |
| 6460 | 6 | `Path 4` |
| 6474 | 6 | `Decode` |
| 6555 | 6 | `No ext` |
| 6557 | 6 | `ET1616` |
| 6558 | 6 | `EM8200` |
| 6564 | 6 | `QX,QS8` |
| 6689 | 6 | `T_FUNC` |
| 6691 | 6 | `M_FUNC` |
| 6696 | 6 | `path 1` |
| 6697 | 6 | `path 2` |
| 6698 | 6 | `path 3` |
| 6699 | 6 | `path 4` |
| 6711 | 6 | `Auxil3` |
| 6787 | 6 | `CW/CCW` |
| 6791 | 6 | `AStart` |
| 6823 | 6 | `SpaceA` |
| 6883 | 6 | `ServoP` |
| 6887 | 6 | `HC_ABS` |
| 6915 | 6 | `F rate` |
| 6942 | 6 | `delete` |
| 6943 | 6 | `SaveAS` |
| 6983 | 6 | `delete` |
| 6984 | 6 | `SaveAS` |
| 7010 | 6 | `degree` |
| 7071 | 6 | `40.GG?` |
| 7078 | 6 | `Unload` |
| 7081 | 6 | `second` |
| 7142 | 6 | `range:` |
| 7179 | 6 | `X axis` |
| 7180 | 6 | `Export` |
| 7181 | 6 | `Y-axis` |
| 7182 | 6 | `Z-axis` |
| 7183 | 6 | `A-axis` |
| 7184 | 6 | `B-axis` |
| 7185 | 6 | `C-axis` |
| 7186 | 6 | `7-axis` |
| 7187 | 6 | `8-axis` |
| 7188 | 6 | `9-axis` |
| 7248 | 6 | `Chute1` |
| 7249 | 6 | `Chute2` |
| 7255 | 6 | `In_arc` |
| 7468 | 6 | `IN05` |
| 7469 | 6 | `IN06` |
| 7470 | 6 | `IN07` |
| 7471 | 6 | `IN08` |
| 7472 | 6 | `IN09` |
| 7473 | 6 | `IN10` |
| 7474 | 6 | `IN11` |
| 7475 | 6 | `IN12` |
| 7476 | 6 | `IN13` |
| 7477 | 6 | `IN14` |
| 7478 | 6 | `IN15` |
| 7530 | 6 | `XOUT24` |
| 7531 | 6 | `YOUT25` |
| 7532 | 6 | `ZOUT26` |
| 7533 | 6 | `AOUT27` |
| 7536 | 6 | `D A` |
| 8194 | 6 | `(9)M01` |
| 4969 | 7 | `reboot?` |
| 4985 | 7 | `Abs pos` |
| 5017 | 7 | `tool No` |
| 5033 | 7 | `Program` |
| 5034 | 7 | `Machine` |
| 5181 | 7 | `DA Test` |
| 5203 | 7 | `abs pos` |
| 5212 | 7 | `Devices` |
| 5215 | 7 | `confirm` |
| 5235 | 7 | `Measure` |
| 5239 | 7 | `Expiate` |
| 5242 | 7 | `General` |
| 5243 | 7 | `All Pos` |
| 5245 | 7 | `rel pos` |
| 5247 | 7 | `Abs Pos` |
| 5267 | 7 | `General` |
| 5364 | 7 | `Spindle` |
| 5509 | 7 | `IO para` |
| 5510 | 7 | `Spindle` |
| 5511 | 7 | `Spindle` |
| 5512 | 7 | `Spindle` |
| 5523 | 7 | `general` |
| 5536 | 7 | `Preview` |
| 5668 | 7 | `GCodeRe` |
| 5679 | 7 | `Reserve` |
| 5698 | 7 | `Cut Len` |
| 5788 | 7 | `Cur Pos` |
| 5795 | 7 | `SPI (X)` |
| 5852 | 7 | `(A)Blow` |
| 5887 | 7 | `Non  RZ` |
| 5889 | 7 | `Auto RZ` |
| 5899 | 7 | `Pos mem` |
| 5900 | 7 | `Sta mem` |
| 5931 | 7 | `Inp Add` |
| 6065 | 7 | `Save As` |
| 6066 | 7 | `Encrypt` |
| 6067 | 7 | `SD Disk` |
| 6096 | 7 | `(O)Skip` |
| 6098 | 7 | `MPG Run` |
| 6168 | 7 | `IO Test` |
| 6169 | 7 | `Invalid` |
| 6182 | 7 | `S Curve` |
| 6184 | 7 | `Deviate` |
| 6202 | 7 | `HomeDir` |
| 6317 | 7 | `Blk Del` |
| 6320 | 7 | `Row Del` |
| 6328 | 7 | `AxisMax` |
| 6329 | 7 | `AxisMin` |
| 6396 | 7 | `CircleZ` |
| 6397 | 7 | `CircleY` |
| 6398 | 7 | `CircleX` |
| 6403 | 7 | `Track 1` |
| 6404 | 7 | `Track 2` |
| 6406 | 7 | `tenon2` |
| 6434 | 7 | `AMT In1` |
| 6435 | 7 | `AMT In2` |
| 6443 | 7 | `AutoArc` |
| 6556 | 7 | `485 ext` |
| 6566 | 7 | `STEP eM` |
| 6679 | 7 | `SCRAM64` |
| 6751 | 7 | `SP1_I93` |
| 6752 | 7 | `SP2_I94` |
| 6758 | 7 | `X OUT48` |
| 6759 | 7 | `Y OUT49` |
| 6760 | 7 | `Z OUT50` |
| 6761 | 7 | `A OUT51` |
| 6762 | 7 | `B OUT52` |
| 6763 | 7 | `C OUT53` |
| 6764 | 7 | `SP2 O54` |
| 6765 | 7 | `SP4 O55` |
| 6766 | 7 | `SP6 O56` |
| 6767 | 7 | `SP1 O57` |
| 6768 | 7 | `SP3 O58` |
| 6769 | 7 | `SP5 O59` |
| 6774 | 7 | `Replace` |
| 6776 | 7 | `FindErr` |
| 6779 | 7 | `XY Plan` |
| 6780 | 7 | `XZ Plan` |
| 6781 | 7 | `XY Plan` |
| 6782 | 7 | `XC Plan` |
| 6783 | 7 | `XZ Plan` |
| 6784 | 7 | `CZ Plan` |
| 6792 | 7 | `AMiddle` |
| 6834 | 7 | `IsBusy` |
| 6888 | 7 | `EM_ECAT` |
| 6889 | 7 | `HC_ECAT` |
| 6901 | 7 | `SCRAM33` |
| 6916 | 7 | `F pitch` |
| 7005 | 7 | `G speed` |
| 7069 | 7 | `39.Knif` |
| 7140 | 7 | `descrip` |
| 7147 | 7 | `Act Dly` |
| 7189 | 7 | `10-axis` |
| 7190 | 7 | `11-axis` |
| 7191 | 7 | `12-axis` |
| 7204 | 7 | `X Param` |
| 7224 | 7 | `EMS I65` |
| 8033 | 7 | `Reserve` |
| 4917 | 8 | `StepOver` |
| 4919 | 8 | `Running` |
| 4955 | 8 | `Del all?` |
| 4987 | 8 | `Rela pos` |
| 5019 | 8 | `R offset` |
| 5021 | 8 | `cut time` |
| 5022 | 8 | `sys time` |
| 5028 | 8 | `SPI rate` |
| 5029 | 8 | `JOG rate` |
| 5030 | 8 | `JOG rate` |
| 5131 | 8 | `MPG1 I24` |
| 5132 | 8 | `MPGX I25` |
| 5133 | 8 | `MPG2 I26` |
| 5134 | 8 | `MPGY I27` |
| 5135 | 8 | `MPG3 I28` |
| 5136 | 8 | `MPGZ I29` |
| 5138 | 8 | `MPGA I31` |
| 5140 | 8 | `stop I33` |
| 5179 | 8 | `Sys info` |
| 5197 | 8 | `Prog sec` |
| 5486 | 8 | `end mark` |
| 5537 | 8 | `Tracking` |
| 5760 | 8 | `X Y lock` |
| 5762 | 8 | `X Z lock` |
| 5763 | 8 | `Y Z lock` |
| 5766 | 8 | `X A lock` |
| 5767 | 8 | `Y A lock` |
| 5786 | 8 | `Del line` |
| 5787 | 8 | `Ins line` |
| 5796 | 8 | `SPI Info` |
| 5810 | 8 | `X Offset` |
| 5811 | 8 | `Y Offset` |
| 5812 | 8 | `Z Offset` |
| 5813 | 8 | `A Offset` |
| 5814 | 8 | `B Offset` |
| 5815 | 8 | `C Offset` |
| 5851 | 8 | `(R)Tlock` |
| 5903 | 8 | `SPI 2 Cw` |
| 5930 | 8 | `Sys Time` |
| 5936 | 8 | `mac home` |
| 6155 | 8 | `Middle` |
| 6183 | 8 | `S Curve2` |
| 6234 | 8 | `JogSpeed` |
| 6251 | 8 | `074,STOP` |
| 6299 | 8 | `Axis MAX` |
| 6319 | 8 | `Blk Copy` |
| 6322 | 8 | `Row Copy` |
| 6390 | 8 | `ViewInfo` |
| 6391 | 8 | `circle 1` |
| 6392 | 8 | `circle 2` |
| 6405 | 8 | `tenon 1` |
| 6424 | 8 | `TNotStop` |
| 6430 | 8 | `InpCycle` |
| 6473 | 8 | `Disk(D:)` |
| 6561 | 8 | `Rel type` |
| 6562 | 8 | `Abs type` |
| 6567 | 8 | `QXE-ECAT` |
| 6671 | 8 | `MPG1 I56` |
| 6672 | 8 | `MPGX I57` |
| 6673 | 8 | `MPG2 I58` |
| 6674 | 8 | `MPGY I59` |
| 6675 | 8 | `MPG3 I60` |
| 6676 | 8 | `MPGZ I61` |
| 6677 | 8 | `MPGC I62` |
| 6678 | 8 | `MPGA I63` |
| 6750 | 8 | `SP Z I77` |
| 6772 | 8 | `ReplaceS` |
| 6790 | 8 | `SpaceArc` |
| 6876 | 8 | `TCP_POLL` |
| 6877 | 8 | `UDP_POLL` |
| 6884 | 8 | `ECATZero` |
| 6886 | 8 | `YIFE-ABS` |
| 6897 | 8 | `MacAddr2` |
| 6899 | 8 | `TapDelay` |
| 6905 | 8 | `SpindleS` |
| 6997 | 8 | `Spr lead` |
| 7024 | 8 | `GW depth` |
| 7067 | 8 | `38.Feed?` |
| 7077 | 8 | `43.Unlod` |
| 7113 | 8 | `IN04 EMS` |
| 7135 | 8 | `OUT07 FC` |
| 7223 | 8 | `STOP I64` |
| 7233 | 8 | `Cur Page` |
| 4931 | 9 | `FPGA VER:` |
| 4932 | 9 | `DLIB VER:` |
| 4933 | 9 | `GLIB VER:` |
| 4951 | 9 | `Prog size` |
| 4967 | 9 | `Del file?` |
| 4975 | 9 | `file size` |
| 5016 | 9 | `offset No` |
| 5023 | 9 | `Prog rate` |
| 5025 | 9 | `feed rate` |
| 5027 | 9 | `Fast rate` |
| 5035 | 9 | `file name` |
| 5137 | 9 | `start I30` |
| 5139 | 9 | `pause I32` |
| 5145 | 9 | `X ECZ I40` |
| 5146 | 9 | `Y ECZ I43` |
| 5147 | 9 | `Z ECZ I46` |
| 5148 | 9 | `A ECZ I49` |
| 5149 | 9 | `S ECZ I52` |
| 5150 | 9 | `SPI Cw 00` |
| 5195 | 9 | `Prog edit` |
| 5555 | 9 | `Seek line` |
| 5617 | 9 | `goto fail` |
| 5697 | 9 | `Cut Diame` |
| 5769 | 9 | `Z A  lock` |
| 5797 | 9 | `SPI Speed` |
| 5800 | 9 | `SPI Angle` |
| 5817 | 9 | `A Forward` |
| 5818 | 9 | `A Reverse` |
| 5819 | 9 | `X Forward` |
| 5820 | 9 | `X Reverse` |
| 5821 | 9 | `Y Forward` |
| 5822 | 9 | `Y Reverse` |
| 5823 | 9 | `Z Forward` |
| 5824 | 9 | `Z Reverse` |
| 5841 | 9 | `(M)Fast0%` |
| 5888 | 9 | `Prompt RZ` |
| 5891 | 9 | `Copy File` |
| 5892 | 9 | `Load Code` |
| 5904 | 9 | `SPI 2 Ccw` |
| 5907 | 9 | `Pos Split` |
| 5910 | 9 | `Real Time` |
| 5912 | 9 | `Abs Coord` |
| 5913 | 9 | `Mac Coord` |
| 5929 | 9 | `Work Time` |
| 5935 | 9 | `prog home` |
| 5999 | 9 | `Scram I61` |
| 6010 | 9 | `X ECZ I72` |
| 6011 | 9 | `Y ECZ I73` |
| 6012 | 9 | `Z ECZ I74` |
| 6013 | 9 | `A ECZ I75` |
| 6014 | 9 | `B ECZ I76` |
| 6015 | 9 | `C ECZ I77` |
| 6016 | 9 | `X ECA I78` |
| 6017 | 9 | `X ECB I79` |
| 6018 | 9 | `Y ECA I80` |
| 6019 | 9 | `Y ECB I81` |
| 6020 | 9 | `Z ECA I82` |
| 6021 | 9 | `Z ECB I83` |
| 6022 | 9 | `A ECA I84` |
| 6023 | 9 | `A ECB I85` |
| 6024 | 9 | `B ECA I86` |
| 6025 | 9 | `B ECB I87` |
| 6026 | 9 | `C ECA I88` |
| 6027 | 9 | `C ECB I89` |
| 6101 | 9 | `(X)Fast0%` |
| 6185 | 9 | `Devia Pos` |
| 6250 | 9 | `075,SCRAM` |
| 6298 | 9 | `Axis Mini` |
| 6318 | 9 | `Blk Paste` |
| 6321 | 9 | `Row Paste` |
| 6326 | 9 | `OutputSet` |
| 6393 | 9 | `circle 3` |
| 6442 | 9 | `AutoAngle` |
| 6560 | 9 | `Channel 1` |
| 6568 | 9 | `Panasonic` |
| 6789 | 9 | `Mac Coord` |
| 6800 | 9 | `RelaceErr` |
| 6840 | 9 | `Undefined` |
| 6885 | 9 | `DELTA_ABS` |
| 6903 | 9 | `TapMaxErr` |
| 6904 | 9 | `TapDynErr` |
| 6925 | 9 | `OPEN[EOB]` |
| 6926 | 9 | `SAVE[EOB]` |
| 6966 | 9 | `OPEN[EOB]` |
| 6967 | 9 | `SAVE[EOB]` |
| 7007 | 9 | `G Ang_Vel` |
| 7031 | 9 | `2GG Y POS` |
| 7033 | 9 | `2GG depth` |
| 7080 | 9 | `CM Rel Dt` |
| 7089 | 9 | `TMC TM Dt` |
| 7139 | 9 | `PARAM SET` |
| 7145 | 9 | `Act PARAM` |
| 7170 | 9 | `SAVE FAIL` |
| 7205 | 9 | `open lock` |
| 7222 | 9 | `start I62` |
| 7231 | 9 | `Panasonic` |
| 7262 | 9 | `syn error` |
| 4928 | 10 | `CNC READY!` |
| 4930 | 10 | `BuildData:` |
| 5020 | 10 | `actual pos` |
| 5107 | 10 | `X zero I00` |
| 5108 | 10 | `Y zero I01` |
| 5109 | 10 | `Z zero I02` |
| 5110 | 10 | `A zero I03` |
| 5123 | 10 | `X-limitI16` |
| 5124 | 10 | `X+limitI17` |
| 5125 | 10 | `Y-limitI18` |
| 5126 | 10 | `Y+limitI19` |
| 5127 | 10 | `Z-limitI20` |
| 5128 | 10 | `Z+limitI21` |
| 5129 | 10 | `A-limitI22` |
| 5130 | 10 | `A+limitI23` |
| 5141 | 10 | `Xalarm I34` |
| 5142 | 10 | `Yalarm I35` |
| 5143 | 10 | `Zalarm I36` |
| 5144 | 10 | `Aalarm I37` |
| 5151 | 10 | `SPI Ccw 01` |
| 5187 | 10 | `Alert info` |
| 5217 | 10 | `My Devices` |
| 5221 | 10 | `My Devices` |
| 5542 | 10 | `input Nxxx` |
| 5562 | 10 | `M6Tx Abort` |
| 5688 | 10 | `USB Com...` |
| 5710 | 10 | `Find Over!` |
| 5764 | 10 | `X Y Z lock` |
| 5768 | 10 | `X Y A lock` |
| 5770 | 10 | `X Z A lock` |
| 5771 | 10 | `Y Z A lock` |
| 5838 | 10 | `(7)MPG RUN` |
| 5842 | 10 | `(Y)Fast25%` |
| 5843 | 10 | `(4)Fast50%` |
| 5906 | 10 | `Time Split` |
| 5932 | 10 | `Totalcount` |
| 5946 | 10 | `X Home I08` |
| 5947 | 10 | `Y Home I09` |
| 5948 | 10 | `Z Home I10` |
| 5949 | 10 | `A Home I11` |
| 5950 | 10 | `B Home I12` |
| 5951 | 10 | `C Home I13` |
| 6001 | 10 | `Wheel1 I63` |
| 6002 | 10 | `Wheel2 I64` |
| 6003 | 10 | `Wheel3 I65` |
| 6102 | 10 | `(Z)Fast50%` |
| 6167 | 10 | `Input Test` |
| 6227 | 10 | `HomeSpeed2` |
| 6228 | 10 | `HomeSpeed3` |
| 6291 | 10 | `ProductSet` |
| 6297 | 10 | `Work range` |
| 6386 | 10 | `Chamfer _C` |
| 6394 | 10 | `Slotting 1` |
| 6395 | 10 | `Slotting 2` |
| 6400 | 10 | `Arc slot 1` |
| 6401 | 10 | `Arc slot 2` |
| 6402 | 10 | `Arc slot 3` |
| 6407 | 10 | `BorderScan` |
| 6421 | 10 | `AContOTime` |
| 6422 | 10 | `BContOTime` |
| 6425 | 10 | `ToolCOTime` |
| 6426 | 10 | `CustomErr1` |
| 6427 | 10 | `CustomErr2` |
| 6428 | 10 | `CustomErr3` |
| 6728 | 10 | `B zero I04` |
| 6729 | 10 | `B-limitI14` |
| 6730 | 10 | `B+limitI15` |
| 6777 | 10 | `FindS Wait` |
| 6799 | 10 | `ReplaceErr` |
| 6832 | 10 | `ActionFail` |
| 6833 | 10 | `ActionExec` |
| 6868 | 10 | `CantNotRun` |
| 6873 | 10 | `UART0_POLL` |
| 6874 | 10 | `UART1_POLL` |
| 6875 | 10 | `UART3_POLL` |
| 7004 | 10 | `08.G speed` |
| 7083 | 10 | `Flap up Dt` |
| 7091 | 10 | `CM C CM Dt` |
| 7095 | 10 | `FR fall Dt` |
| 7097 | 10 | `FR back Dt` |
| 7108 | 10 | `UL C UL Dt` |
| 7265 | 10 | `All errors` |

### 11-15 bytes (400 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 4929 | 11 | `System VER:` |
| 4938 | 11 | `used space` |
| 4965 | 11 | `Del folder?` |
| 4986 | 11 | `machine pos` |
| 5024 | 11 | `actual rate` |
| 5201 | 11 | `MDI running` |
| 5202 | 11 | `machine pos` |
| 5253 | 11 | `(G)Skip Fun` |
| 5546 | 11 | `Refer coord` |
| 5559 | 11 | `Prog No End` |
| 5616 | 11 | `Value error` |
| 5686 | 11 | `config file` |
| 5702 | 11 | `Input T Dir` |
| 5709 | 11 | `Find Error!` |
| 5839 | 11 | `(8)Mac Lock` |
| 5844 | 11 | `(5)Fast100%` |
| 5877 | 11 | `Hole Number` |
| 5911 | 11 | `preproccess` |
| 5938 | 11 | `X+Limit I00` |
| 5939 | 11 | `X-Limit I01` |
| 5940 | 11 | `Y+Limit I02` |
| 5941 | 11 | `Y-Limit I03` |
| 5942 | 11 | `Z+Limit I04` |
| 5943 | 11 | `Z-Limit I05` |
| 5944 | 11 | `A+Limit I06` |
| 5945 | 11 | `A-Limit I07` |
| 5954 | 11 | `B+Limit I16` |
| 5955 | 11 | `B-Limit I17` |
| 5956 | 11 | `C+Limit I18` |
| 5957 | 11 | `C-Limit I19` |
| 5994 | 11 | `Wheel X I56` |
| 5995 | 11 | `Wheel Y I56` |
| 5996 | 11 | `Wheel Z I56` |
| 5997 | 11 | `Wheel A I56` |
| 5998 | 11 | `Wheel C I56` |
| 6000 | 11 | `Wheel B I56` |
| 6004 | 11 | `X Alarm I66` |
| 6005 | 11 | `Y Alarm I67` |
| 6006 | 11 | `Z Alarm I68` |
| 6007 | 11 | `A Alarm I69` |
| 6008 | 11 | `B Alarm I70` |
| 6009 | 11 | `C Alarm I71` |
| 6103 | 11 | `(4)Fast100%` |
| 6116 | 11 | `Tool Seting` |
| 6165 | 11 | `Output Test` |
| 6174 | 11 | `Demo Screen` |
| 6244 | 11 | `065,X Wheel` |
| 6245 | 11 | `066,Y Wheel` |
| 6246 | 11 | `067,Z Wheel` |
| 6247 | 11 | `068,A Wheel` |
| 6248 | 11 | `069,B Wheel` |
| 6249 | 11 | `070,C Wheel` |
| 6252 | 11 | `073,STARTUP` |
| 6273 | 11 | `071,7 Wheel` |
| 6274 | 11 | `072,8 Wheel` |
| 6389 | 11 | `Full screen` |
| 6417 | 11 | `ToolNoError` |
| 6420 | 11 | `LoosenOTime` |
| 6433 | 11 | `ScramTheNot` |
| 6452 | 11 | `USB IDLE...` |
| 6549 | 11 | `machine pos` |
| 6550 | 11 | `Encoder pos` |
| 6712 | 11 | `022,TapMode` |
| 6796 | 11 | `NewFileFail` |
| 6797 | 11 | `NewFileSucc` |
| 6801 | 11 | `FindReplEnd` |
| 6802 | 11 | `CanNotTeach` |
| 6827 | 11 | `MotionErrNo` |
| 6830 | 11 | `InvalidAddr` |
| 6831 | 11 | `InvalidData` |
| 6835 | 11 | `FileDataErr` |
| 6842 | 11 | `BaseAddrErr` |
| 6843 | 11 | `DecimalPErr` |
| 6892 | 11 | `036,LocalIP` |
| 6956 | 11 | `Spiral lead` |
| 6990 | 11 | `01.RB1 MK 0` |
| 6996 | 11 | `04.Spr lead` |
| 7013 | 11 | `12.X GG POS` |
| 7015 | 11 | `13.Y GG POS` |
| 7017 | 11 | `14.Z GG POS` |
| 7019 | 11 | `15.A GG POS` |
| 7023 | 11 | `17.GW depth` |
| 7055 | 11 | `UseThimble?` |
| 7057 | 11 | `Ret G X Len` |
| 7074 | 11 | `G B_corner?` |
| 7079 | 11 | `1.CM Rel Dt` |
| 7088 | 11 | `5.TMC TM Dt` |
| 7099 | 11 | `Pos C go Dt` |
| 7106 | 11 | `CM C Rel Dt` |
| 7109 | 11 | `IN00 X zero` |
| 7110 | 11 | `IN00 Y zero` |
| 7111 | 11 | `IN00 Z zero` |
| 7112 | 11 | `IN00 A zero` |
| 7128 | 11 | `OUT00 Spi +` |
| 7129 | 11 | `OUT02 Spi -` |
| 7137 | 11 | `OUT09 Pos C` |
| 7138 | 11 | `OUT10 UL CV` |
| 7156 | 11 | `A6 COM fail` |
| 7206 | 11 | `open w lock` |
| 7207 | 11 | `high 32 bit` |
| 4942 | 12 | `save success` |
| 4964 | 12 | `load success` |
| 4984 | 12 | `variable add` |
| 5038 | 12 | `Save failure` |
| 5041 | 12 | `load failure` |
| 5050 | 12 | `[cancel]quit` |
| 5051 | 12 | `password set` |
| 5052 | 12 | `[EOB]confirm` |
| 5207 | 12 | `File manager` |
| 5254 | 12 | `(X)Close Sys` |
| 5263 | 12 | `5 back HOME!` |
| 5406 | 12 | `port config` |
| 5540 | 12 | `Path picture` |
| 5541 | 12 | `input line #` |
| 5547 | 12 | `Refer coord2` |
| 5548 | 12 | `Refer coord3` |
| 5549 | 12 | `Refer coord4` |
| 5563 | 12 | `Tool Invalid` |
| 5576 | 12 | `Motion Abort` |
| 5577 | 12 | `Illegal char` |
| 5609 | 12 | `System Abort` |
| 5687 | 12 | `Wait USB Com` |
| 5693 | 12 | `current tool` |
| 5704 | 12 | `current tool` |
| 5799 | 12 | `SPI Position` |
| 5845 | 12 | `(6)Tailstock` |
| 5893 | 12 | `Cooler alarm` |
| 5894 | 12 | `Positive Dir` |
| 5895 | 12 | `Negative Dir` |
| 5915 | 12 | `File Encrypt` |
| 6081 | 12 | `Vacuum Error` |
| 6097 | 12 | `Close System` |
| 6104 | 12 | `(5)Tailstock` |
| 6110 | 12 | `(A)T Locking` |
| 6218 | 12 | `Reset to 360` |
| 6241 | 12 | `062,Wheel0.1` |
| 6327 | 12 | `MachineRange` |
| 6408 | 12 | `MacroFuncSel` |
| 6412 | 12 | `FirstInError` |
| 6418 | 12 | `SpindleOtime` |
| 6419 | 12 | `ToolOutOtime` |
| 6462 | 12 | `ProgramEdit2` |
| 6531 | 12 | `memory over!` |
| 6539 | 12 | `Spindle axis` |
| 6559 | 12 | `Main channel` |
| 6685 | 12 | `HandwheelRPM` |
| 6687 | 12 | `HandwheelPos` |
| 6688 | 12 | `(7)Handwheel` |
| 6710 | 12 | `Dual channel` |
| 6841 | 12 | `OpenFileFail` |
| 6896 | 12 | `082,LocalIP2` |
| 6900 | 12 | `TabCycleTyep` |
| 6911 | 12 | `TapFollowErr` |
| 6947 | 12 | `days Remain:` |
| 6949 | 12 | `01.Rr 1 MC 0` |
| 6951 | 12 | `MC Pro teeth` |
| 6952 | 12 | `MC Pro teeth` |
| 6988 | 12 | `days Remain:` |
| 6993 | 12 | `MC PRO teeth` |
| 7006 | 12 | `09.G Ang_Vel` |
| 7025 | 12 | `18.2GG(Y1N0)` |
| 7026 | 12 | `MC need 2GG?` |
| 7030 | 12 | `20.2GG Y POS` |
| 7032 | 12 | `21.2GG depth` |
| 7049 | 12 | `2G Agl Z POS` |
| 7090 | 12 | `6.CM C CM Dt` |
| 7093 | 12 | `TM C back Dt` |
| 7094 | 12 | `8.FR fall Dt` |
| 7096 | 12 | `9.FR back Dt` |
| 7114 | 12 | `IN05 Ext sta` |
| 7115 | 12 | `IN06 Ext sto` |
| 7117 | 12 | `IN08 FR Back` |
| 7119 | 12 | `IN10 X Pso S` |
| 7120 | 12 | `IN16 X-limit` |
| 7121 | 12 | `IN17 X+limit` |
| 7122 | 12 | `IN18 Y-limit` |
| 7123 | 12 | `IN19 Y+limit` |
| 7124 | 12 | `IN20 Z-limit` |
| 7125 | 12 | `IN21 Z+limit` |
| 7126 | 12 | `IN22 A-limit` |
| 7127 | 12 | `IN23 A+limit` |
| 7132 | 12 | `OUT04 TMC F2` |
| 7133 | 12 | `OUT05 CMC F3` |
| 7134 | 12 | `OUT06 ULC F4` |
| 7149 | 12 | `RET GG X Len` |
| 7167 | 12 | `Init success` |
| 7169 | 12 | `SAVE SUCCESS` |
| 7178 | 12 | `update servo` |
| 7195 | 12 | `9-axis PARAM` |
| 7196 | 12 | `8-axis PARAM` |
| 7197 | 12 | `7-axis PARAM` |
| 7198 | 12 | `C-axis PARAM` |
| 7199 | 12 | `B-axis PARAM` |
| 7200 | 12 | `A-axis PARAM` |
| 7201 | 12 | `Z-axis PARAM` |
| 7202 | 12 | `Y-axis PARAM` |
| 7203 | 12 | `X-axis PARAM` |
| 7208 | 12 | `Clbt H 32bit` |
| 7211 | 12 | `FAIL ,reload` |
| 7214 | 12 | `save success` |
| 7221 | 12 | `Config PARAM` |
| 4935 | 13 | `Current Prog:` |
| 4976 | 13 | `build success` |
| 5018 | 13 | `length offset` |
| 5037 | 13 | `close system?` |
| 5218 | 13 | `local disk(c)` |
| 5219 | 13 | `local disk(d)` |
| 5222 | 13 | `local disk(c)` |
| 5223 | 13 | `local disk(d)` |
| 5568 | 13 | `Program Abend` |
| 5669 | 13 | `air no enough` |
| 5674 | 13 | `PutTools Fail` |
| 5675 | 13 | `GetTools Fail` |
| 5730 | 13 | `G76 DOC error` |
| 6079 | 13 | `Housing Error` |
| 6082 | 13 | `Custom Alarm4` |
| 6083 | 13 | `Custom Alarm5` |
| 6084 | 13 | `Custom Alarm6` |
| 6085 | 13 | `Custom Alarm7` |
| 6086 | 13 | `Custom Alarm8` |
| 6087 | 13 | `Custom Alarm9` |
| 6144 | 13 | `28,Tool Speed` |
| 6211 | 13 | `Limit  ELevel` |
| 6242 | 13 | `063,Wheel0.01` |
| 6313 | 13 | `can not copy!` |
| 6314 | 13 | `can not copy!` |
| 6410 | 13 | `MacroFuncUser` |
| 6413 | 13 | `SecondInError` |
| 6423 | 13 | `ToolBackOTime` |
| 6515 | 13 | `Axis alarm119` |
| 6516 | 13 | `SystemAlarm17` |
| 6517 | 13 | `SystemAlarm18` |
| 6518 | 13 | `SystemAlarm19` |
| 6519 | 13 | `SystemAlarm20` |
| 6520 | 13 | `SystemAlarm21` |
| 6521 | 13 | `SystemAlarm22` |
| 6522 | 13 | `SystemAlarm23` |
| 6523 | 13 | `SystemAlarm24` |
| 6524 | 13 | `SystemAlarm25` |
| 6525 | 13 | `SystemAlarm26` |
| 6526 | 13 | `SystemAlarm27` |
| 6527 | 13 | `SystemAlarm28` |
| 6528 | 13 | `SystemAlarm29` |
| 6529 | 13 | `SystemAlarm30` |
| 6530 | 13 | `SystemAlarm31` |
| 6536 | 13 | `Third of jump` |
| 6537 | 13 | `[Axis group1]` |
| 6538 | 13 | `[Axis group2]` |
| 6542 | 13 | `third channel` |
| 6547 | 13 | `[Axis group7]` |
| 6548 | 13 | `[Axis group8]` |
| 6837 | 13 | `DeviceNotResp` |
| 6838 | 13 | `ModbusDataErr` |
| 6845 | 13 | `MotionErrData` |
| 6858 | 13 | `MotionErrRate` |
| 6860 | 13 | `MotionErrAxis` |
| 6862 | 13 | `MotionErrAxis` |
| 6950 | 13 | `Type(Rr1,MC0)` |
| 7012 | 13 | `X CB distance` |
| 7060 | 13 | `Ret GG Z high` |
| 7062 | 13 | `Ret  GG Speed` |
| 7076 | 13 | `G 2 B_corner?` |
| 7101 | 13 | `Pos C back Dt` |
| 7107 | 13 | `15.UL C UL Dt` |
| 7136 | 13 | `OUT08 coolant` |
| 7151 | 13 | `RET GG Z high` |
| 7171 | 13 | `read CSV fail` |
| 7177 | 13 | `5axis G PARAM` |
| 7192 | 13 | `12-axis PARAM` |
| 7193 | 13 | `11-axis PARAM` |
| 7194 | 13 | `10-axis PARAM` |
| 5338 | 14 | `004,Initialize` |
| 5450 | 14 | `044,Oil Output` |
| 5579 | 14 | `Illegal G Code` |
| 5665 | 14 | `spi no to home` |
| 5678 | 14 | `knife-song err` |
| 5701 | 14 | `Input T Radius` |
| 5862 | 14 | `T Diameter(mm)` |
| 5876 | 14 | `Starting angle` |
| 6088 | 14 | `Custom Alarm10` |
| 6089 | 14 | `Custom Alarm11` |
| 6090 | 14 | `Custom Alarm12` |
| 6091 | 14 | `Custom Alarm13` |
| 6092 | 14 | `Custom Alarm14` |
| 6093 | 14 | `Custom Alarm15` |
| 6094 | 14 | `Custom Alarm16` |
| 6114 | 14 | `(0)Chip Remove` |
| 6193 | 14 | `Gear Numerator` |
| 6217 | 14 | `Encoder bit(p)` |
| 6224 | 14 | `Servo Home Dir` |
| 6243 | 14 | `064,Wheel0.001` |
| 6265 | 14 | `7 Limit- Input` |
| 6266 | 14 | `7 Limit+ Input` |
| 6267 | 14 | `8 Limit- Input` |
| 6268 | 14 | `8 Limit+ Input` |
| 6312 | 14 | `Out of memory!` |
| 6409 | 14 | `[EOB]    [CAN]` |
| 6469 | 14 | `Load Main Code` |
| 6535 | 14 | `Second of jump` |
| 6541 | 14 | `second channel` |
| 6563 | 14 | `Standard Pulse` |
| 6683 | 14 | `Run rate(&lt;100)` |
| 6684 | 14 | `HandwheelParam` |
| 6690 | 14 | `Auxiliary info` |
| 6713 | 14 | `023,TapAdcMode` |
| 6717 | 14 | `027,TapParamKp` |
| 6718 | 14 | `028,TapParamKi` |
| 6719 | 14 | `029,TapParamKd` |
| 6723 | 14 | `033,TapParamK2` |
| 6798 | 14 | `NewFileLoaded?` |
| 6829 | 14 | `InvalidFunCode` |
| 6836 | 14 | `InvalidNetPath` |
| 6844 | 14 | `MotionErrParam` |
| 6852 | 14 | `MotionErrScram` |
| 6891 | 14 | `012,UART0 Baud` |
| 6895 | 14 | `081,UART3 Baud` |
| 6898 | 14 | `029,UART1 Baud` |
| 6909 | 14 | `TapEncoderVal0` |
| 6910 | 14 | `TapEncoderVal1` |
| 6955 | 14 | `04.Spiral lead` |
| 6962 | 14 | `GW start speed` |
| 6991 | 14 | `Type(RB1 MK 0)` |
| 7003 | 14 | `GW start speed` |
| 7014 | 14 | `X GG Start POS` |
| 7016 | 14 | `Y GG Start POS` |
| 7018 | 14 | `Z GG Start POS` |
| 7020 | 14 | `A GG Start POS` |
| 7022 | 14 | `SL F_angle Pro` |
| 7036 | 14 | `23.Y G agl pos` |
| 7047 | 14 | `2G Agl A O_Agl` |
| 7053 | 14 | `CM return dis` |
| 7054 | 14 | `32 UseThimble?` |
| 7056 | 14 | `33.Ret G X Len` |
| 7064 | 14 | `GG taper depth` |
| 7073 | 14 | `41.G B_corner?` |
| 7082 | 14 | `2.Flap lift Dt` |
| 7085 | 14 | `FeedRack go Dt` |
| 7087 | 14 | `FeedBack up Dt` |
| 7092 | 14 | `7.TM C back Dt` |
| 7098 | 14 | `10.Pos C go Dt` |
| 7103 | 14 | `fender drop Dt` |
| 7105 | 14 | `14.CM C Rel Dt` |
| 7116 | 14 | `IN07 M detct S` |
| 7155 | 14 | `GG Taper depth` |
| 7162 | 14 | `Data recovery?` |
| 7176 | 14 | `Init, wait....` |
| 4952 | 15 | `start MDI prog?` |
| 4959 | 15 | `can't find file` |
| 5278 | 15 | `011,Line number` |
| 5287 | 15 | `020,'O'Pro Scan` |
| 5302 | 15 | `035,T code form` |
| 5341 | 15 | `007,para backup` |
| 5451 | 15 | `045,Cool Output` |
| 5496 | 15 | `Tool Pos2(#408)` |
| 5497 | 15 | `Tool pos3(#409)` |
| 5798 | 15 | `SPI Encode bits` |
| 5855 | 15 | `(.)chip removal` |
| 6123 | 15 | `07,Tool X Coord` |
| 6124 | 15 | `08,Tool Y Coord` |
| 6125 | 15 | `09,Tool Z Coord` |
| 6126 | 15 | `10,Tool A Coord` |
| 6127 | 15 | `11,Tool B Coord` |
| 6128 | 15 | `12,Tool C Coord` |
| 6201 | 15 | `HOME Offset(mm)` |
| 6209 | 15 | `ECZ Home Enable` |
| 6210 | 15 | `ECZ Home ELevel` |
| 6214 | 15 | `Ext Home ELevel` |
| 6225 | 15 | `Ext Home Eanble` |
| 6315 | 15 | `can not delete!` |
| 6316 | 15 | `can not delete!` |
| 6387 | 15 | `Inverted arc _R` |
| 6414 | 15 | `ToolDebugCancel` |
| 6429 | 15 | `GLoadBordScanEn` |
| 6464 | 15 | `AbsPosReadFail!` |
| 6472 | 15 | `Must Superuser!` |
| 6540 | 15 | `Spindle channel` |
| 6579 | 15 | `Servo en output` |
| 6682 | 15 | `HandwheelS(rmp)` |
| 6708 | 15 | `Tool Parameters` |
| 6724 | 15 | `034,TapPreDelay` |
| 6803 | 15 | `OutputSignalErr` |
| 6828 | 15 | `EtherCATErrAxis` |
| 6851 | 15 | `MotionErrSCurve` |
| 6855 | 15 | `MotionErrFPGARW` |
| 6906 | 15 | `TapEncoderTotal` |
| 6992 | 15 | `02.MC PRO teeth` |
| 7035 | 15 | `X G agl Sta_pos` |
| 7037 | 15 | `Y G agl sta_pos` |
| 7043 | 15 | `B_Corner pro SL` |
| 7045 | 15 | `Agl depth of GW` |
| 7048 | 15 | `29.2G Agl Z POS` |
| 7104 | 15 | `13.fender up Dt` |
| 7118 | 15 | `IN09 TM Place S` |
| 7130 | 15 | `OUT02 FR A/R F0` |
| 7131 | 15 | `OUT03 FR U/D F1` |
| 7152 | 15 | `35.RET GG Speed` |
| 7153 | 15 | `35.RET GG Speed` |
| 7175 | 15 | `save ,wait.....` |
| 7210 | 15 | `servo type erro` |
| 7218 | 15 | `004,data backup` |

### 16-20 bytes (338 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 4934 | 16 | `Current NC File:` |
| 4943 | 16 | `new Prog failure` |
| 4944 | 16 | `new prog success` |
| 4970 | 16 | `input file name` |
| 4998 | 16 | `centre reckoning` |
| 5220 | 16 | `data traveler(U)` |
| 5224 | 16 | `data traveler(U)` |
| 5284 | 16 | `017,Arc Inp Mode` |
| 5333 | 16 | `axis config para` |
| 5342 | 16 | `008,para recover` |
| 5499 | 16 | `X safe Pos(#411)` |
| 5500 | 16 | `Y safe Pos(#412)` |
| 5567 | 16 | `PortNumber Error` |
| 5571 | 16 | `M98 Format Error` |
| 5572 | 16 | `Motion Run Error` |
| 5622 | 16 | `userdefine alarm` |
| 5623 | 16 | `userdefine alarm` |
| 5634 | 16 | `NURBS para error` |
| 5637 | 16 | `no U order error` |
| 5638 | 16 | `no W order error` |
| 5677 | 16 | `bayonet lock err` |
| 5805 | 16 | `Param Backup OK!` |
| 5878 | 16 | `initial position` |
| 5901 | 16 | `Chuck unlock err` |
| 6176 | 16 | `all tool setting` |
| 6194 | 16 | `Gear Denominator` |
| 6203 | 16 | `ZeroReturn Speed` |
| 6235 | 16 | `-axis first zero` |
| 6237 | 16 | `-axis third zero` |
| 6269 | 16 | `7 Ext Home Input` |
| 6270 | 16 | `8 Ext Home Input` |
| 6383 | 16 | `SystemOffInputNO` |
| 6456 | 16 | `CNC System Start` |
| 6465 | 16 | `DeleteDirFile...` |
| 6543 | 16 | `[Channel GRUNC4]` |
| 6544 | 16 | `[Channel GRUNC5]` |
| 6545 | 16 | `[Channel GRUNC6]` |
| 6546 | 16 | `[Channel GRUNC7]` |
| 6714 | 16 | `024,TapIfEncode?` |
| 6727 | 16 | `037,TapMaxErrVal` |
| 6770 | 16 | `AbsServoInitFail` |
| 6795 | 16 | `CopyUpTO5120Char` |
| 6863 | 16 | `MotionErrMailBox` |
| 6866 | 16 | `MotionErrFPGABus` |
| 6894 | 16 | `080,ModbusResend` |
| 6907 | 16 | `TapSpEncoderVal0` |
| 6908 | 16 | `TapSpEncoderVal1` |
| 6933 | 16 | `File open failed` |
| 6934 | 16 | `File save sucess` |
| 6936 | 16 | `clear cur param?` |
| 6974 | 16 | `File open failed` |
| 6975 | 16 | `File save sucess` |
| 6977 | 16 | `clear cur param?` |
| 6999 | 16 | `X find POS speed` |
| 7011 | 16 | `11.X CB distance` |
| 7034 | 16 | `22.X G angle pos` |
| 7038 | 16 | `24.Z G angle pos` |
| 7040 | 16 | `25.A G angle pos` |
| 7059 | 16 | `34.Ret GG Z high` |
| 7061 | 16 | `35.Ret  GG Speed` |
| 7066 | 16 | `G Agl TaperDepth` |
| 7075 | 16 | `42.G 2 B_corner?` |
| 7084 | 16 | `3.FeedRack go Dt` |
| 7086 | 16 | `5.FeedBack up Dt` |
| 7100 | 16 | `11.Pos C back Dt` |
| 7150 | 16 | `34.RET GG Z high` |
| 7161 | 16 | `Data backup fail` |
| 7219 | 16 | `005,data recovey` |
| 7225 | 16 | `Saxis Zphase I76` |
| 7263 | 16 | `Spi follow error` |
| 4916 | 17 | `FileLoad Success!` |
| 4963 | 17 | `load G code file?` |
| 4974 | 17 | `copy file failure` |
| 4992 | 17 | `current coord sys` |
| 5039 | 17 | `data save success` |
| 5042 | 17 | `data load success` |
| 5316 | 17 | `049,Z safe height` |
| 5317 | 17 | `050,A safe height` |
| 5554 | 17 | `sys unknown alarm` |
| 5587 | 17 | `Spi Appointed Err` |
| 5610 | 17 | `Factitious return` |
| 5666 | 17 | `workpiece no lock` |
| 5866 | 17 | `Feed rate(mm/min)` |
| 5875 | 17 | `Cutting Mode(1-4)` |
| 5937 | 17 | `CHUCK ABIERTO!!!!` |
| 6117 | 17 | `01,X Coord Offset` |
| 6118 | 17 | `02,Y Coord Offset` |
| 6119 | 17 | `03,Z Coord Offset` |
| 6120 | 17 | `04,A Coord Offset` |
| 6121 | 17 | `05,B Coord Offset` |
| 6122 | 17 | `06,C Coord Offset` |
| 6195 | 17 | `FastSpeed(mm/min)` |
| 6204 | 17 | `JOG Speed(mm/min)` |
| 6206 | 17 | `max restrain rate` |
| 6236 | 17 | `-axis second zero` |
| 6271 | 17 | `7 Servo En Output` |
| 6272 | 17 | `8 Servo En Output` |
| 6384 | 17 | `SystemOffOutputNO` |
| 6415 | 17 | `ToolFailPleaCheck` |
| 6416 | 17 | `SetToolNumTooMany` |
| 6431 | 17 | `ZSafePosDropSpeed` |
| 6432 | 17 | `ASafePosDropSpeed` |
| 6467 | 17 | `Please Superuser!` |
| 6534 | 17 | `First of the jump` |
| 6578 | 17 | `Extend zero input` |
| 6580 | 17 | `Servo alarm input` |
| 6585 | 17 | `Servo device addr` |
| 6590 | 17 | `Servo stop output` |
| 6778 | 17 | `Find End Not Find` |
| 6846 | 17 | `MotionErrAxisStop` |
| 6847 | 17 | `MotionErrConflict` |
| 6856 | 17 | `MotionErrFifoFull` |
| 6857 | 17 | `MotionErrFifoFull` |
| 6859 | 17 | `MotionErrFirmware` |
| 6861 | 17 | `MotionErrEtherCAT` |
| 6864 | 17 | `MotionErrRigidTap` |
| 6867 | 17 | `MotionErrRigidTap` |
| 6930 | 17 | `file load success` |
| 6953 | 17 | `03.B angle Pro TS` |
| 6961 | 17 | `07.GW start speed` |
| 6963 | 17 | `08.Grinding speed` |
| 6971 | 17 | `file load success` |
| 7002 | 17 | `07.GW start speed` |
| 7021 | 17 | `16.SL F_angle Pro` |
| 7029 | 17 | `2GG A OffsetAngle` |
| 7039 | 17 | `Z G angle Sta_pos` |
| 7041 | 17 | `A G angle Sta_pos` |
| 7046 | 17 | `28.2G Agl A O_Agl` |
| 7051 | 17 | `2GG Agl Pro depth` |
| 7052 | 17 | `31. CM return dis` |
| 7063 | 17 | `36.GG taper depth` |
| 7102 | 17 | `12.fender drop Dt` |
| 7154 | 17 | `36.GG Taper depth` |
| 7168 | 17 | `Save PARAM to CSV` |
| 7220 | 17 | `38, the knife way` |
| 7266 | 17 | `Num turns encoder` |
| 7267 | 17 | `origin calibrat` |
| 4937 | 18 | `NOs of saved prog` |
| 4947 | 18 | `jump in auto mode?` |
| 4953 | 18 | `return to default?` |
| 4960 | 18 | `can't open catalog` |
| 4966 | 18 | `Del folder failure` |
| 5053 | 18 | `Administrator code` |
| 5070 | 18 | `initialize success` |
| 5335 | 18 | `001,Select SupMode` |
| 5344 | 18 | `010,menu click way` |
| 5369 | 18 | `005,Spi.ECZ Elevel` |
| 5373 | 18 | `009,Spi.Pulse Mode` |
| 5453 | 18 | `047,X Limit- Input` |
| 5483 | 18 | `056,Led Reset 0~31` |
| 5503 | 18 | `max time(ms)(#401)` |
| 5611 | 18 | `no parameter input` |
| 5640 | 18 | `multi M code error` |
| 5642 | 18 | `no  \"return zero\` |
| 5700 | 18 | `Input Z Len offset` |
| 5856 | 18 | `Each cutting width` |
| 5865 | 18 | `Spindle Speed(rpm)` |
| 6146 | 18 | `30,Tool X Safe Pos` |
| 6147 | 18 | `31,Tool Y Safe Pos` |
| 6148 | 18 | `32,Tool Z Safe Pos` |
| 6149 | 18 | `33,Tool A Safe Pos` |
| 6150 | 18 | `34,Tool B Safe Pos` |
| 6151 | 18 | `35,Tool C Safe Pos` |
| 6177 | 18 | `three cylinder SPI` |
| 6197 | 18 | `Acceleration(Kpps)` |
| 6198 | 18 | `Soft PosLimit+(mm)` |
| 6199 | 18 | `Soft PosLimit-(mm)` |
| 6223 | 18 | `Max Acc of X(Kpps)` |
| 6229 | 18 | `ScrewPitch Comp EN` |
| 6276 | 18 | `Y axis Alarm Input` |
| 6277 | 18 | `Z axis Alarm Input` |
| 6278 | 18 | `4 axis Alarm Input` |
| 6279 | 18 | `B axis Alarm Input` |
| 6280 | 18 | `C axis Alarm Input` |
| 6281 | 18 | `7 axis Alarm Input` |
| 6282 | 18 | `8 axis Alarm Input` |
| 6284 | 18 | `Y axis Reset Input` |
| 6285 | 18 | `Z axis Reset Input` |
| 6286 | 18 | `4 axis Reset Input` |
| 6287 | 18 | `B axis Reset Input` |
| 6288 | 18 | `C axis Reset Input` |
| 6289 | 18 | `7 axis Reset Input` |
| 6290 | 18 | `8 axis Reset Input` |
| 6449 | 18 | `Load the main code` |
| 6468 | 18 | `File Exists Cover?` |
| 6551 | 18 | `Origin pos confirm` |
| 6581 | 18 | `Servo reset output` |
| 6613 | 18 | `005, Spindle speed` |
| 6656 | 18 | `075, Handwheel 0.1` |
| 6709 | 18 | `Z-phase offset pos` |
| 6716 | 18 | `026,TapAccFilterEn` |
| 6725 | 18 | `035,TapReturnDelay` |
| 6726 | 18 | `036,TapCollectData` |
| 6804 | 18 | `SpaceArcModifySucc` |
| 6805 | 18 | `SpaceArcModifySucc` |
| 6806 | 18 | `SpaceArcModifySucc` |
| 6807 | 18 | `SpaceArcModifySucc` |
| 6808 | 18 | `SpaceArcModifySucc` |
| 6809 | 18 | `SpaceArcModifySucc` |
| 6810 | 18 | `SpaceArcModifySucc` |
| 6811 | 18 | `SpaceArcModifySucc` |
| 6849 | 18 | `MotionErrInputData` |
| 6853 | 18 | `MotionErrTargetPos` |
| 6865 | 18 | `MotionErrFifoEvent` |
| 6871 | 18 | `JumpExecuteWait...` |
| 6890 | 18 | `AbsoluteEncoderErr` |
| 6935 | 18 | `paste data cur loc` |
| 6958 | 18 | `X Search pos speed` |
| 6976 | 18 | `paste data cur loc` |
| 6995 | 18 | `MC Angle Pro times` |
| 7042 | 18 | `26.B_Corner pro SL` |
| 4958 | 19 | `cover current file?` |
| 4968 | 19 | `cat't del this file` |
| 5271 | 19 | `004,ZeroReturn Mode` |
| 5383 | 19 | `019,Spi.Ext HomeDir` |
| 5444 | 19 | `038,Ext Reset Input` |
| 5447 | 19 | `041,RunLight Output` |
| 5452 | 19 | `046,Oil Pump Output` |
| 5484 | 19 | `057,Led Reset 32~63` |
| 5485 | 19 | `058,Led Reset 64~95` |
| 5501 | 19 | `Tool Interval(#413)` |
| 5582 | 19 | `Arc Appointed Error` |
| 5613 | 19 | `Call false in Macro` |
| 5624 | 19 | `Constant Call Error` |
| 5633 | 19 | `NURBS Node too many` |
| 5712 | 19 | `Pro number is full?` |
| 5729 | 19 | `G76 FT margin error` |
| 5882 | 19 | `Hole Bottom Pos(mm)` |
| 6129 | 19 | `13,Tool Axis Select` |
| 6207 | 19 | `ServoAlarmIn ELevel` |
| 6208 | 19 | `ServoResetOut ELeve` |
| 6238 | 19 | `PULSE RESET!!!!!!!!` |
| 6388 | 19 | `Error inverted arc` |
| 6571 | 19 | `005,IO Filter(0~15)` |
| 6577 | 19 | `positive limit inpu` |
| 6593 | 19 | `spindle ready input` |
| 6596 | 19 | `spindle speed input` |
| 6635 | 19 | `054, Reset IO 00~31` |
| 6636 | 19 | `055, Reset IO 32~63` |
| 6637 | 19 | `056, Reset IO 64~95` |
| 6642 | 19 | `061, Reset LED 0~31` |
| 6657 | 19 | `076, Handwheel 0.01` |
| 6686 | 19 | `HandwheelEncoderVal` |
| 6715 | 19 | `025,TapFPGASetSPeed` |
| 6721 | 19 | `031,TapParamKilimit` |
| 6722 | 19 | `032,TapParamKdLimit` |
| 6850 | 19 | `MotionErrAccDecMode` |
| 6928 | 19 | `P select teach file` |
| 6929 | 19 | `teach file not exis` |
| 6969 | 19 | `P select teach file` |
| 6970 | 19 | `teach file not exis` |
| 6998 | 19 | `05.X find pos speed` |
| 7044 | 19 | `27. Agl depth of GW` |
| 7065 | 19 | `37.G Agl TaperDepth` |
| 7160 | 19 | `Data backup success` |
| 7164 | 19 | `Data recovery fail!` |
| 7264 | 19 | `Slave Followe error` |
| 4946 | 20 | `Del current Prog No?` |
| 4972 | 20 | `replace file folder?` |
| 4973 | 20 | `copy catalog failure` |
| 4983 | 20 | `input variable value` |
| 4993 | 20 | `work boundary point1` |
| 4994 | 20 | `work boundary point2` |
| 4995 | 20 | `work boundary point3` |
| 4996 | 20 | `work boundary point4` |
| 4997 | 20 | `R of round workpiece` |
| 5323 | 20 | `056,M98 Jump Line EN` |
| 5347 | 20 | `013,maximum work num` |
| 5350 | 20 | `016,sys language bag` |
| 5366 | 20 | `002,Spi.Alarm ELevel` |
| 5367 | 20 | `003,Spi.Reset ELevel` |
| 5372 | 20 | `008,Spi.Limit Elevel` |
| 5399 | 20 | `034,Second Spi Speed` |
| 5409 | 20 | `003,Tool Changer Out` |
| 5412 | 20 | `006,Tool Limit Input` |
| 5413 | 20 | `007,Tool Blow Output` |
| 5448 | 20 | `042,StopLight Output` |
| 5465 | 20 | `048,X Ext Home Input` |
| 5488 | 20 | `Tool Max Count(#400)` |
| 5489 | 20 | `X Standard Pos(#401)` |
| 5490 | 20 | `Y Standard Pos(#402)` |
| 5491 | 20 | `Z Standard Pos(#403)` |
| 5543 | 20 | `can't find the N add` |
| 5590 | 20 | `Missing X Code Error` |
| 5591 | 20 | `Missing Y Code Error` |
| 5592 | 20 | `Missing Z Code Error` |
| 5593 | 20 | `Missing A Code Error` |
| 5594 | 20 | `Missing B Code Error` |
| 5595 | 20 | `Missing C Code Error` |
| 5596 | 20 | `Missing D Code Error` |
| 5597 | 20 | `Missing R Code Error` |
| 5598 | 20 | `Missing F Code Error` |
| 5599 | 20 | `Missing T Code Error` |
| 5600 | 20 | `Missing S Code Error` |
| 5601 | 20 | `Missing P Code Error` |
| 5602 | 20 | `Missing M Code Error` |
| 5603 | 20 | `Missing G Code Error` |
| 5604 | 20 | `Missing I Code Error` |
| 5605 | 20 | `Missing J Code Error` |
| 5606 | 20 | `Missing K Code Error` |
| 5607 | 20 | `Missing Q Code Error` |
| 5628 | 20 | `G41G42 EndLine Error` |
| 5660 | 20 | `X Sevor driver alarm` |
| 5661 | 20 | `Y Sevor driver alarm` |
| 5662 | 20 | `Z Sevor driver alarm` |
| 5663 | 20 | `A Sevor driver alarm` |
| 5672 | 20 | `Spindle alarm occurs` |
| 5690 | 20 | `Abnormal memory code` |
| 5699 | 20 | `Input X Diame offset` |
| 5857 | 20 | `X Axis Start Pos(mm)` |
| 5858 | 20 | `Y Axis Start Pos(mm)` |
| 5873 | 20 | `The center X pos(mm)` |
| 5874 | 20 | `The center Y pos(mm)` |
| 6076 | 20 | `B Sevor driver alarm` |
| 6077 | 20 | `C Sevor driver alarm` |
| 6175 | 20 | `current tool setting` |
| 6179 | 20 | `home deviation alarm` |
| 6196 | 20 | `StartupSpeed(mm/min)` |
| 6262 | 20 | `7 Sevor driver alarm` |
| 6263 | 20 | `8 Sevor driver alarm` |
| 6451 | 20 | `USBConnectionFail...` |
| 6454 | 20 | `USB Begin Connect...` |
| 6576 | 20 | `Negative limit input` |
| 6604 | 20 | `026,Open screensaver` |
| 6617 | 20 | `009, 2 spindle speed` |
| 6638 | 20 | `057, Reset IO 96~127` |
| 6643 | 20 | `062, Reset LED 32~63` |
| 6644 | 20 | `063, Reset LED 64~95` |
| 6658 | 20 | `077, Handwheel 0.001` |
| 6670 | 20 | `088, Handwheel scram` |
| 6720 | 20 | `030,TapParamKdFilter` |
| 6848 | 20 | `MotionErrModifyParam` |
| 6869 | 20 | `JumpMemoryPosExecute` |
| 6994 | 20 | `03.B_angle Pro times` |
| 7001 | 20 | `Feed dis after X POS` |
| 7009 | 20 | `A Dfl_Ang when Xzero` |
| 7028 | 20 | `19.2GG A OffsetAngle` |
| 7050 | 20 | `30.2GG Agl Pro depth` |

### 21-25 bytes (314 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 4939 | 21 | `system history alarm` |
| 4982 | 21 | `macro para global var` |
| 5015 | 21 | `ensure measure coord?` |
| 5054 | 21 | `operator Pre-Password` |
| 5055 | 21 | `operator New Password` |
| 5060 | 21 | `re-enter New Password` |
| 5268 | 21 | `001,Inp Speed(mm/min)` |
| 5293 | 21 | `026,Arc Acc.for Radii` |
| 5294 | 21 | `027,Arc Acc.for Speed` |
| 5296 | 21 | `029,Inp AccSpeed Mode` |
| 5299 | 21 | `032,HOME Check Enable` |
| 5377 | 21 | `013,Spi.Round Setting` |
| 5379 | 21 | `015,Spi.ZeroOffset(p)` |
| 5382 | 21 | `018,Spi.Max Acc(Kpps)` |
| 5384 | 21 | `020,Spi.Servo HomeDir` |
| 5395 | 21 | `031,Spi Current Speed` |
| 5397 | 21 | `033,Spi Minimum Speed` |
| 5424 | 21 | `018,Spindle CW Output` |
| 5437 | 21 | `031,Chuck Alarm Input` |
| 5446 | 21 | `040,AlarmLight Output` |
| 5471 | 21 | `049,X Servo En Output` |
| 5494 | 21 | `Tool Slow Speed(#406)` |
| 5506 | 21 | `Tool Bit Elevel(#404)` |
| 5575 | 21 | `M99 Instruction Abort` |
| 5584 | 21 | `M98 Instruction Abort` |
| 5588 | 21 | `Motion Repeat Request` |
| 5615 | 21 | `MacroValue addr error` |
| 5671 | 21 | `OilPressure no enough` |
| 5689 | 21 | `preprocessing Lib Ver` |
| 5711 | 21 | `File exception error?` |
| 5731 | 21 | `G76 screw pitch error` |
| 5831 | 21 | `XY plane Circular Box` |
| 5868 | 21 | `The circle radius(mm)` |
| 5871 | 21 | `The circle radius(mm)` |
| 5872 | 21 | `The circle radius(mm)` |
| 6143 | 21 | `27,Auto Add Offset En` |
| 6152 | 21 | `36,Tool Safe Check En` |
| 6181 | 21 | `028,British system En` |
| 6187 | 21 | `043,Spindle Auto Open` |
| 6205 | 21 | `restrain acc (mm/s^2)` |
| 6221 | 21 | `Rolling Display Usage` |
| 6253 | 21 | `Alarm Quit Line GCode` |
| 6300 | 21 | `More than 8000 reset!` |
| 6304 | 21 | `Macro function error!` |
| 6466 | 21 | `Load GFile To GCMain` |
| 6488 | 21 | `X1 Sevor driver alarm` |
| 6489 | 21 | `Y1 Sevor driver alarm` |
| 6506 | 21 | `Z1 Sevor driver alarm` |
| 6507 | 21 | `A1 Sevor driver alarm` |
| 6508 | 21 | `B1 Sevor driver alarm` |
| 6509 | 21 | `C1 Sevor driver alarm` |
| 6575 | 21 | `078,Remote IP address` |
| 6584 | 21 | `Axis third zero speed` |
| 6586 | 21 | `Axis lap offset(mm/r)` |
| 6639 | 21 | `058, Reset IO 128~159` |
| 6640 | 21 | `059, Reset IO 160~191` |
| 6641 | 21 | `060, Reset IO 192~223` |
| 6645 | 21 | `064, Reset LED 96~127` |
| 6893 | 21 | `079,ModbusPollTimeOut` |
| 6931 | 21 | `file name less 8 char` |
| 6957 | 21 | `05.X Search pos speed` |
| 6959 | 21 | `06.X pos and feed dis` |
| 6972 | 21 | `file name less 8 char` |
| 7215 | 21 | `022,oilpump timing on` |
| 7237 | 21 | `059,G91 to G90 enable` |
| 7261 | 21 | `Modbus Commu abnormal` |
| 5056 | 22 | `superuser Pre-Password` |
| 5057 | 22 | `superuser New Password` |
| 5058 | 22 | `pls enter Pre-Password` |
| 5059 | 22 | `pls enter New Password` |
| 5064 | 22 | `Password reset success` |
| 5276 | 22 | `009, Wheel Coefficient` |
| 5281 | 22 | `014,Circle InpUnit(mm)` |
| 5288 | 22 | `021,SpindleControlMode` |
| 5310 | 22 | `043,abnormal memory En` |
| 5370 | 22 | `006,Spi. Limit+ Enable` |
| 5371 | 22 | `007,Spi. Limit- Enable` |
| 5378 | 22 | `014,Spi.Encode bits(p)` |
| 5385 | 22 | `021,Spi.Max Speed(rpm)` |
| 5387 | 22 | `023,Spi.Gear Numerator` |
| 5414 | 22 | `008,Spi Alarm Check In` |
| 5420 | 22 | `014,VFD 0 Level Output` |
| 5421 | 22 | `015,VFD 1 Level Output` |
| 5422 | 22 | `016,VFD 2 Level Output` |
| 5423 | 22 | `017,VFD 3 Level Output` |
| 5425 | 22 | `019,Spindle CCW Output` |
| 5426 | 22 | `020,Spindle2 CW Output` |
| 5442 | 22 | `036,Cooler Alarm Input` |
| 5443 | 22 | `037,Oiling Alarm Input` |
| 5445 | 22 | `039,Tool Locking Input` |
| 5454 | 22 | `X Limit+ Input` |
| 5455 | 22 | `Y Limit- Input` |
| 5456 | 22 | `Y Limit+ Input` |
| 5457 | 22 | `Z Limit- Input` |
| 5458 | 22 | `Z Limit+ Input` |
| 5459 | 22 | `4 Limit- Input` |
| 5460 | 22 | `4 Limit+ Input` |
| 5461 | 22 | `B Limit- Input` |
| 5462 | 22 | `B Limit+ Input` |
| 5463 | 22 | `C Limit- Input` |
| 5464 | 22 | `C Limit+ Input` |
| 5487 | 22 | `Current Tool No(#4120)` |
| 5492 | 22 | `Tool Safe Height(#404)` |
| 5493 | 22 | `Tool Rapid Speed(#405)` |
| 5502 | 22 | `Stuck Pos Offset(#414)` |
| 5564 | 22 | `G Program Repeat Error` |
| 5565 | 22 | `G Program Number Error` |
| 5574 | 22 | `G Program Format Error` |
| 5614 | 22 | `Macro expression error` |
| 5627 | 22 | `G41G42 StartLine Error` |
| 5676 | 22 | `ToolsDoor Can't detect` |
| 5680 | 22 | `TCheck Error for Limit` |
| 5808 | 22 | `Is not enabled TCheck?` |
| 5869 | 22 | `cutting Dir:2-CW 3-CCW` |
| 6145 | 22 | `29,Tool Start Using En` |
| 6188 | 22 | `044,Spindle Auto Close` |
| 6200 | 22 | `BacklashExpiate(pulse)` |
| 6230 | 22 | `ScrewPitch Spacing(mm)` |
| 6232 | 22 | `ScrewPitch End Pos(mm)` |
| 6233 | 22 | `010,System Main Chanel` |
| 6275 | 22 | `076,X axis Alarm Input` |
| 6283 | 22 | `077,X axis Reset Input` |
| 6302 | 22 | `Save D Disk SPI_AB.CSV` |
| 6303 | 22 | `T Key Spindle sampling` |
| 6411 | 22 | `MultipleThreadStartErr` |
| 6471 | 22 | `LoadSecondChannelGCode` |
| 6583 | 22 | `Axis second zero speed` |
| 6625 | 22 | `017, Spindle auto open` |
| 6626 | 22 | `018, Spindle auto stop` |
| 6630 | 22 | `047, Input level 00~31` |
| 6631 | 22 | `048, Input level 32~63` |
| 6632 | 22 | `049, Input level 64~95` |
| 6646 | 22 | `065, Reset LED 128~159` |
| 6647 | 22 | `066, Reset LED 160~191` |
| 6648 | 22 | `067, Reset LED 192~223` |
| 6872 | 22 | `LoadPositioningWait...` |
| 7213 | 22 | `delet file and save it` |
| 7226 | 22 | `ECAT_WKC R error count` |
| 7227 | 22 | `ECAT_WKC W error count` |
| 7238 | 22 | `085,B-feed speed Limit` |
| 5272 | 23 | `005, IO FilterWave(1~8)` |
| 5275 | 23 | `008,MaxMPGSpeed(mm/min)` |
| 5286 | 23 | `019,GCode pre-treatment` |
| 5315 | 23 | `048,HOME Mode Cls coord` |
| 5325 | 23 | `058,SPI Brake Delay(ms)` |
| 5330 | 23 | `063,Hand Wheel Max Rate` |
| 5331 | 23 | `064,Hand Wheel ACC(Kps)` |
| 5337 | 23 | `003,Alter User Password` |
| 5343 | 23 | `009,generate cryptogram` |
| 5360 | 23 | `026,Screen Safeguard En` |
| 5375 | 23 | `011,Spi.HomeDect ELevel` |
| 5386 | 23 | `022,Spi.Home Speed(rpm)` |
| 5408 | 23 | `002,Tool Safe Signal In` |
| 5427 | 23 | `021,Spindle2 CCW Output` |
| 5429 | 23 | `023,Spindle Blow Output` |
| 5431 | 23 | `025,Servo Spi En Output` |
| 5480 | 23 | `053,IO Conf Reset 00~31` |
| 5481 | 23 | `054,IO Conf Reset 32~63` |
| 5482 | 23 | `055,IO Conf Reset 64~95` |
| 5495 | 23 | `Rapid Descend Pos(#407)` |
| 5498 | 23 | `Spindle Blow Hold(#410)` |
| 5586 | 23 | `MCode Instruction Abort` |
| 5589 | 23 | `Appointed Arc Nonentity` |
| 5619 | 23 | `\"WHILE\"  Nested error` |
| 5673 | 23 | `Transducer alarm occurs` |
| 5713 | 23 | `Pro number del success?` |
| 5825 | 23 | `X two-way plane milling` |
| 5826 | 23 | `Y two-way plane milling` |
| 5827 | 23 | `X one-way plane milling` |
| 5828 | 23 | `Y one-way plane milling` |
| 6131 | 23 | `15,ToolChecking Limit X` |
| 6132 | 23 | `16,ToolChecking Limit Y` |
| 6133 | 23 | `17,ToolChecking Limit Z` |
| 6134 | 23 | `18,ToolChecking Limit A` |
| 6135 | 23 | `19,ToolChecking Limit B` |
| 6136 | 23 | `20,ToolChecking Limit C` |
| 6189 | 23 | `059,Start Out Open 0~31` |
| 6295 | 23 | `Spindle  record time(s)` |
| 6378 | 23 | `MacroFuncParameterError` |
| 6510 | 23 | `second channel not zero` |
| 6582 | 23 | `Axis corner speed level` |
| 6592 | 23 | `rigidity tapping output` |
| 6594 | 23 | `spindle must stop input` |
| 6633 | 23 | `050, Input level 96~127` |
| 6668 | 23 | `086, Handwheel to start` |
| 6854 | 23 | `MotionErrInvalidCommand` |
| 6932 | 23 | `No occupy sys file name` |
| 6954 | 23 | `TS the MC need machined` |
| 6973 | 23 | `No occupy sys file name` |
| 7000 | 23 | `06.Feed dis after X POS` |
| 7008 | 23 | `10 A Dfl_Ang when Xzero` |
| 7143 | 23 | `SW(infeed set)set PARAM` |
| 7163 | 23 | `sucessful! restart SYS?` |
| 7212 | 23 | `delet file and save it` |
| 7229 | 23 | `C workpiece tool offset` |
| 5063 | 24 | `pre-password input error` |
| 5069 | 24 | `operater password wrong?` |
| 5082 | 24 | `G32 thread process error` |
| 5083 | 24 | `G92 thread process error` |
| 5274 | 24 | `007,MaxFeedSpeed(mm/min)` |
| 5295 | 24 | `028,PretreatmentCode Set` |
| 5298 | 24 | `031,HOME Check for alarm` |
| 5324 | 24 | `057,System boot zero way` |
| 5339 | 24 | `005,Initialize IO Config` |
| 5368 | 24 | `004,,Spi.ECZ Home Enable` |
| 5374 | 24 | `010,Spi.Pulse Logic Mode` |
| 5376 | 24 | `012,Spi.ExtHome Check En` |
| 5380 | 24 | `016,Spi.PulseLogic Level` |
| 5388 | 24 | `024,Spi.Gear Denominator` |
| 5417 | 24 | `011,Servo Spi stop input` |
| 5430 | 24 | `024,Spindle Brake Output` |
| 5439 | 24 | `033,ExStart2 Check Input` |
| 5440 | 24 | `034,ExPause2 Check Input` |
| 5441 | 24 | `035,ExScram2 Check Input` |
| 5466 | 24 | `Y Ext Home Input` |
| 5467 | 24 | `Z Ext Home Input` |
| 5468 | 24 | `4 Ext Home Input` |
| 5469 | 24 | `B Ext Home Input` |
| 5470 | 24 | `C Ext Home Input` |
| 5504 | 24 | `rest lock time(ms)(#402)` |
| 5608 | 24 | `Screw Value Repeat Error` |
| 5667 | 24 | `safe signal can't detect` |
| 5719 | 24 | `G code reserved succeed` |
| 5721 | 24 | `confirm delete this line` |
| 5727 | 24 | `G76 starting point error` |
| 5830 | 24 | `XY plane Rectangular Box` |
| 5860 | 24 | `X-axis workpiece len(mm)` |
| 5861 | 24 | `Y-axis workpiece len(mm)` |
| 5863 | 24 | `Each machining depth(mm)` |
| 5879 | 24 | `Each machining depth(mm)` |
| 5883 | 24 | `129,System boot zero way` |
| 5897 | 24 | `Press[EOB] 3 Sec to exit` |
| 5914 | 24 | `No Enough Of Disk Space` |
| 5916 | 24 | `No Enough Of Disk Space` |
| 6068 | 24 | `B - direction soft limit` |
| 6069 | 24 | `B + direction soft limit` |
| 6070 | 24 | `C - direction soft limit` |
| 6071 | 24 | `C + direction soft limit` |
| 6190 | 24 | `060,Start Out Open 32~63` |
| 6191 | 24 | `061,Start Out Open 64~95` |
| 6231 | 24 | `ScrewPitch Start Pos(mm)` |
| 6294 | 24 | `Spindle sampl period(ms)` |
| 6379 | 24 | `UndefinedMacroFuncError` |
| 6380 | 24 | `067,ChamferOrAutomaticEn` |
| 6382 | 24 | `069,CoorToolSettingsMode` |
| 6450 | 24 | `TheSecondChannelCodeLoad` |
| 6595 | 24 | `spindle zero speed input` |
| 6614 | 24 | `006, Pause close spindle` |
| 6634 | 24 | `051, Input level 128~159` |
| 6948 | 24 | `switch user mode do this` |
| 6960 | 24 | `X pos and feed point dis` |
| 6989 | 24 | `switch user mode do this` |
| 7166 | 24 | `Init PARAM from CSV file` |
| 7217 | 24 | `024,oilpump ctr freq(Hz)` |
| 4962 | 25 | `can't spot file like this` |
| 5065 | 25 | `2 passwords Inconsistent` |
| 5068 | 25 | `superuser password wrong?` |
| 5269 | 25 | `002,InpStartSpeed(mm/min)` |
| 5277 | 25 | `010, M Code Delaytime(ms)` |
| 5289 | 25 | `022,OilPressure Open(min)` |
| 5290 | 25 | `023,OilPressure Keep(sec)` |
| 5297 | 25 | `030,'S'Speed Acceleration` |
| 5307 | 25 | `040,Pretreatment segments` |
| 5308 | 25 | `041,feed speed setting En` |
| 5311 | 25 | `044,Z rise to safe pos En` |
| 5312 | 25 | `045,A rise to safe pos En` |
| 5320 | 25 | `053,screw Acc pitch P(mm)` |
| 5336 | 25 | `002,AlterSuperuserPasswor` |
| 5345 | 25 | `011,clear add up work num` |
| 5361 | 25 | `027,Modbus Poll/Slave Set` |
| 5389 | 25 | `025,Spi.Encoder Logic Dir` |
| 5390 | 25 | `026,Spi.OpenDelayTime(ms)` |
| 5401 | 25 | `037,Machine Spi One Speed` |
| 5402 | 25 | `038,Machine Spi Two Speed` |
| 5416 | 25 | `010,Servo Spi ready input` |
| 5432 | 25 | `026,Servo Spi Stop Output` |
| 5449 | 25 | `043,SYS ReadyLight Output` |
| 5472 | 25 | `Y Servo En Output` |
| 5473 | 25 | `Z Servo En Output` |
| 5474 | 25 | `4 Servo En Output` |
| 5475 | 25 | `B Servo En Output` |
| 5476 | 25 | `C Servo En Output` |
| 5561 | 25 | `No GCode GetLine Function` |
| 5573 | 25 | `Current Program No Repair` |
| 5670 | 25 | `chuck signal alarm detect` |
| 5807 | 25 | `M98 began processing line` |
| 5829 | 25 | `XY plane circular milling` |
| 5864 | 25 | `Total machining depth(mm)` |
| 5880 | 25 | `Processing of repetitions` |
| 6080 | 25 | `Pressure Transducer Error` |
| 6222 | 25 | `G00 Rolling Path Optimize` |
| 6305 | 25 | `Undefined macro function!` |
| 6480 | 25 | `X1 - direction soft limit` |
| 6481 | 25 | `X1 + direction soft limit` |
| 6482 | 25 | `Y1 - direction soft limit` |
| 6483 | 25 | `Y1 + direction soft limit` |
| 6490 | 25 | `Z1 - direction soft limit` |
| 6491 | 25 | `A1 - direction soft limit` |
| 6492 | 25 | `B1 - direction soft limit` |
| 6493 | 25 | `C1 - direction soft limit` |
| 6494 | 25 | `Z1 + direction soft limit` |
| 6495 | 25 | `A1 + direction soft limit` |
| 6496 | 25 | `B1 + direction soft limit` |
| 6497 | 25 | `C1 + direction soft limit` |
| 6618 | 25 | `010, Spindle S invalid En` |
| 6619 | 25 | `011, spindle 2 speed(rpm)` |
| 6620 | 25 | `012, spindle 2 speed(rpm)` |
| 6621 | 25 | `013, spindle 3 speed(rpm)` |
| 6622 | 25 | `014, spindle 4 speed(rpm)` |
| 6627 | 25 | `019, Spindle pulse number` |
| 6669 | 25 | `087, Handwheel to suspend` |
| 6912 | 25 | `HandwheelModelCan'tDoThis` |
| 6913 | 25 | `G01 Rolling Path Optimize` |
| 7239 | 25 | `030,Air alarm input port` |

### 26-30 bytes (204 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 4988 | 26 | `search tool set coordinate` |
| 5078 | 26 | `G7X outline describe wrong` |
| 5101 | 26 | `compound code format wrong` |
| 5282 | 26 | `015,G73(M)LoopObligate(mm)` |
| 5283 | 26 | `016,G83(M)LoopObligate(mm)` |
| 5292 | 26 | `025,BackHome ModeConf(bit)` |
| 5300 | 26 | `033,X diameter prog enable` |
| 5301 | 26 | `034,default process plane` |
| 5309 | 26 | `042,enable of G00 Inp mode` |
| 5321 | 26 | `054,screw slow pitch D(mm)` |
| 5322 | 26 | `055,screw back value V(mm)` |
| 5328 | 26 | `061,Hand Wheel Encoder Dir` |
| 5346 | 26 | `012,clear current work num` |
| 5349 | 26 | `015,startup display module` |
| 5396 | 26 | `032,Auto Stop Close Spi En` |
| 5404 | 26 | `040,Machine Spi Four Speed` |
| 5405 | 26 | `041,Spindle Stop Delay(ms)` |
| 5433 | 26 | `027,Servo Spi Pulse Output` |
| 5505 | 26 | `delay of re-lock(ms)(#403)` |
| 5570 | 26 | `No Appointed ProgramNumber` |
| 5580 | 26 | `GCode RadialOffset Num Err` |
| 5620 | 26 | `SubProgram Nested too much` |
| 5832 | 26 | `Hole loop of circular mode` |
| 5859 | 26 | `Z Axis Plane Start Pos(mm)` |
| 6137 | 26 | `21,Tool Search X Direction` |
| 6138 | 26 | `22,Tool Search Y Direction` |
| 6139 | 26 | `23,Tool Search Z Direction` |
| 6140 | 26 | `24,Tool Search A Direction` |
| 6141 | 26 | `25,Tool Search B Direction` |
| 6142 | 26 | `26,Tool Search C Direction` |
| 6192 | 26 | `042,Alarm Close Spindle En` |
| 6292 | 26 | `014, System Shutdown Input` |
| 6306 | 26 | `067, automatic arc enabled` |
| 6381 | 26 | `068,ChamferOrAutomatic(mm)` |
| 6453 | 26 | `USB  WaitFor Connection...` |
| 6512 | 26 | `External emergency stop109` |
| 6591 | 26 | `Servo control pulse output` |
| 6659 | 26 | `078, Handwheel to choose X` |
| 6660 | 26 | `079, Handwheel to choose Y` |
| 6662 | 26 | `080, Handwheel to choose Z` |
| 6663 | 26 | `081, Handwheel to choose A` |
| 6664 | 26 | `082, Handwheel to choose B` |
| 6665 | 26 | `083, Handwheel to choose C` |
| 6666 | 26 | `084, Handwheel to choose 7` |
| 6667 | 26 | `085, Handwheel to choose 8` |
| 7158 | 26 | `UART1/UART2/UART3 only one` |
| 7159 | 26 | `Data Backup,Auto overwrite` |
| 7165 | 26 | `Data Backup,Auto overwrite` |
| 7173 | 26 | `Sure CSV index are correct` |
| 7216 | 26 | `023,oilpump hold time(sec)` |
| 7243 | 26 | `092,Ext pause 2 input port` |
| 7245 | 26 | `094,Ext reset 1 input port` |
| 5066 | 27 | `pls input operater password` |
| 5100 | 27 | `G90 G92 Z increment is zero` |
| 5270 | 27 | `003,InpAcceleration(mm/sec)` |
| 5291 | 27 | `024,OilPressureOut Freq(Hz)` |
| 5313 | 27 | `046,Pro RZ to reference pos` |
| 5314 | 27 | `047,Mac RZ to reference pos` |
| 5318 | 27 | `051,Z axis feed speed limit` |
| 5319 | 27 | `052,A axis feed speed limit` |
| 5326 | 27 | `059,ProCoordOversizeConvert` |
| 5329 | 27 | `062,Hand Wheel Control Mode` |
| 5351 | 27 | `017,macro key word valid En` |
| 5352 | 27 | `018,startup picture display` |
| 5356 | 27 | `022,additional panel enable` |
| 5403 | 27 | `039,Machine Spi Three Speed` |
| 5407 | 27 | `001,Tool Checking signal In` |
| 5435 | 27 | `029,Safe Signal Check Input` |
| 5477 | 27 | `050,Input Check Level 00~31` |
| 5478 | 27 | `051,Input Check Level 32~63` |
| 5479 | 27 | `052,Input Check Level 64~95` |
| 5530 | 27 | `sys finish recover, reboot?` |
| 5545 | 27 | `This parameter is read-only` |
| 5566 | 27 | `G7X8X Instruction Run Error` |
| 5643 | 27 | `4 - direction program limit` |
| 5644 | 27 | `4 + direction program limit` |
| 5645 | 27 | `Z - direction program limit` |
| 5646 | 27 | `Z + direction program limit` |
| 5647 | 27 | `Y - direction program limit` |
| 5648 | 27 | `Y + direction program limit` |
| 5649 | 27 | `X - direction program limit` |
| 5650 | 27 | `X + direction program limit` |
| 5651 | 27 | `4 - direction machine limit` |
| 5652 | 27 | `4 + direction machine limit` |
| 5653 | 27 | `Z - direction machine limit` |
| 5654 | 27 | `Z + direction machine limit` |
| 5655 | 27 | `Y - direction machine limit` |
| 5656 | 27 | `Y + direction machine limit` |
| 5657 | 27 | `X - direction machine limit` |
| 5658 | 27 | `X + direction machine limit` |
| 5726 | 27 | `G76 Z increment value error` |
| 5750 | 27 | `more than 4 data for spline` |
| 5870 | 27 | `Box Mode:0-inside 1-outside` |
| 6072 | 27 | `B - direction machine limit` |
| 6073 | 27 | `B + direction machine limit` |
| 6074 | 27 | `C - direction machine limit` |
| 6075 | 27 | `C + direction machine limit` |
| 6254 | 27 | `7 - direction program limit` |
| 6255 | 27 | `7 + direction program limit` |
| 6256 | 27 | `8 - direction program limit` |
| 6257 | 27 | `8 + direction program limit` |
| 6258 | 27 | `7 - direction machine limit` |
| 6259 | 27 | `7 + direction machine limit` |
| 6260 | 27 | `8 - direction machine limit` |
| 6261 | 27 | `8 + direction machine limit` |
| 6293 | 27 | `015, System Shutdown Output` |
| 6440 | 27 | `051,Z+axis feed speed limit` |
| 6441 | 27 | `052,A+axis feed speed limit` |
| 6611 | 27 | `003, Spindle max speed(rpm)` |
| 6612 | 27 | `004, Spindle time delay(ms)` |
| 6628 | 27 | `020, Spindle Gear Numerator` |
| 6649 | 27 | `068, Start output open 0~31` |
| 7230 | 27 | `CurTool C WP Len compensate` |
| 7240 | 27 | `089,Ext start 1 input port` |
| 7241 | 27 | `090,Ext start 2 input port` |
| 7242 | 27 | `091,Ext pause 1 input port` |
| 7244 | 27 | `093,Ext reset 1 input port` |
| 7246 | 27 | `095,Run light output 1port` |
| 7247 | 27 | `096,stop light output 2port` |
| 7257 | 27 | `Real time error of tapping:` |
| 4940 | 28 | `axis No redefine error,check` |
| 5067 | 28 | `pls input superuser password` |
| 5098 | 28 | `G94 X axis increment is zero` |
| 5225 | 28 | `Sys RAM lack, can't continue` |
| 5285 | 28 | `018,interpolation speed mode` |
| 5327 | 28 | `060,4 axis max rotate speed` |
| 5353 | 28 | `019,sys display axis setting` |
| 5354 | 28 | `020,sys debug information En` |
| 5394 | 28 | `030,sv spi speed reach level` |
| 5398 | 28 | `034,Second Spi Maximum Speed` |
| 5436 | 28 | `030,Air Pressure Alarm Input` |
| 5438 | 28 | `032,Oil Pressure Alarm Input` |
| 5560 | 28 | `No Appointed Motion Function` |
| 5583 | 28 | `Appointed Noneffective Plane` |
| 5618 | 28 | `WHILE key \"[ ]\" pair error` |
| 5681 | 28 | `addition panel abnormal work` |
| 5728 | 28 | `G76 screw tooth high is zero` |
| 5751 | 28 | `not allow  insert in the arc` |
| 6311 | 28 | `Last not contain procedures!` |
| 6484 | 28 | `X1 - direction machine limit` |
| 6485 | 28 | `X1 + direction machine limit` |
| 6486 | 28 | `Y1 - direction machine limit` |
| 6487 | 28 | `Y1 + direction machine limit` |
| 6498 | 28 | `Z1 - direction machine limit` |
| 6499 | 28 | `A1 - direction machine limit` |
| 6500 | 28 | `B1 - direction machine limit` |
| 6501 | 28 | `C1 - direction machine limit` |
| 6502 | 28 | `Z1 + direction machine limit` |
| 6503 | 28 | `A1 + direction machine limit` |
| 6504 | 28 | `B1 + direction machine limit` |
| 6505 | 28 | `C1 + direction machine limit` |
| 6573 | 28 | `009,USB flash disk online en` |
| 6598 | 28 | `010,System axis group config` |
| 6600 | 28 | `019,System axis group config` |
| 6615 | 28 | `007, Spindle min speed(rpm)` |
| 6623 | 28 | `015, Spindle stop delay(ms)` |
| 6624 | 28 | `016, Alarm closed spindle En` |
| 6650 | 28 | `069, Start output open 32~63` |
| 6918 | 28 | `AbsoluteEncoderTurnsPosition` |
| 6919 | 28 | `AbsoluteEncoderTurnsPositio2` |
| 7259 | 28 | `Modbus ext_output comu alarm` |
| 7260 | 28 | `Modbus ext_intput comu alarm` |
| 4945 | 29 | `input wanted character string` |
| 5381 | 29 | `017,Spi.Rolling Display Usage` |
| 5391 | 29 | `027,servo spindle ready level` |
| 5411 | 29 | `005,Tool Changer Dustproof In` |
| 5415 | 29 | `009,Transduser Alarm Check In` |
| 5428 | 29 | `022,Transduser Alarm Rest Out` |
| 5664 | 29 | `Axis's physical line redefine` |
| 5684 | 29 | `G33 tap order execution error` |
| 5714 | 29 | `Parameters failed to restore!` |
| 5717 | 29 | `preprocessing exception error` |
| 5924 | 29 | `1,move A axis to machine home` |
| 6307 | 29 | `068, automatic arc value (mm)` |
| 6310 | 29 | `Not contain a program number!` |
| 6574 | 29 | `077,Abnormal jump config(bit)` |
| 6616 | 29 | `008, 2 spindle max speed(rpm)` |
| 6629 | 29 | `021, Spindle Gear Denominator` |
| 6651 | 29 | `070, Start output open 64~95` |
| 6652 | 29 | `071, Start output open 96~127` |
| 7157 | 29 | `SYS use time end !need unlock` |
| 4941 | 30 | `template over 128K,can't load` |
| 4954 | 30 | `template over 128K,can't load` |
| 5074 | 30 | `fail,cut the power and reboot.` |
| 5332 | 30 | `065,machining end to reference` |
| 5355 | 30 | `021,axis control composite key` |
| 5365 | 30 | `001,spindle assign port axis #` |
| 5393 | 30 | `029,servo spi zero speed level` |
| 5400 | 30 | `036,Spi CodeCommand Invalid En` |
| 5410 | 30 | `004,Tool Changer Dustproof Out` |
| 5418 | 30 | `012,Servo Spi zero speed input` |
| 5531 | 30 | `above operator can modify para` |
| 5569 | 30 | `Appointed M01 Instruction Stop` |
| 5585 | 30 | `Spindle Appointed Number Error` |
| 6130 | 30 | `14,ToolChecking RunAfter TCode` |
| 6186 | 30 | `066,Feed Rate Change Increment` |
| 6239 | 30 | `Spinlde Current overload alarm` |
| 6240 | 30 | `029,additional panel baud rate` |
| 6587 | 30 | `Abs encoder calibration origin` |
| 6653 | 30 | `072, Start output open 128~159` |
| 6654 | 30 | `073, Start output open 160~191` |
| 6655 | 30 | `074, Start output open 192~223` |
| 6920 | 30 | `052, Input Check Level 160~191` |
| 6921 | 30 | `053, Input Check Level 192~223` |

### 31-40 bytes (86 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 5086 | 31 | `screw process not spindle Z ECZ` |
| 5089 | 31 | `taper thread R-value prog error` |
| 5090 | 31 | `G74 radial offset exceeds range` |
| 5096 | 31 | `G75-Z axis offset exceeds range` |
| 5392 | 31 | `028,servo spi stop to pos level` |
| 5419 | 31 | `013,Servo Spi speed reach input` |
| 5434 | 31 | `028,sv Spi Rigid tapping output` |
| 5578 | 31 | `Noneffective Exegesis Character` |
| 5581 | 31 | `Noneffective GCode RadialOffset` |
| 5625 | 31 | `The i_gcode Error in Last track` |
| 5626 | 31 | `The i_gcode Error in Next track` |
| 5722 | 31 | `move it to the form coordinate?` |
| 6445 | 31 | `Spindle non-servo spindle error` |
| 6455 | 31 | `USB Success Connection Began...` |
| 6513 | 31 | `Motion target pos data error110` |
| 6514 | 31 | `EtherCAT communication fail 118` |
| 7172 | 31 | `items number for csv incorrect!` |
| 4948 | 32 | `jump to current line to process?` |
| 4971 | 32 | `can't cover current process file` |
| 4999 | 32 | `current workpiece coord sys-&gt;G54` |
| 5000 | 32 | `current workpiece coord sys-&gt;G55` |
| 5001 | 32 | `current workpiece coord sys-&gt;G56` |
| 5002 | 32 | `current workpiece coord sys-&gt;G57` |
| 5003 | 32 | `current workpiece coord sys-&gt;G58` |
| 5004 | 32 | `current workpiece coord sys-&gt;G59` |
| 5079 | 32 | `G72 Rough cycle depth of cut Err` |
| 5256 | 32 | `2 Y HOME move over,To Z,X pos...` |
| 5257 | 32 | `2 X HOME move over,To Y,Z pos...` |
| 5258 | 32 | `2 Z HOME move over,To X,Y pos...` |
| 5639 | 32 | `multiple G code expression error` |
| 5720 | 32 | `insert one line before this line` |
| 5896 | 32 | `whether do you need return Zero?` |
| 6308 | 32 | `069, coordinate automatic  knife` |
| 6448 | 32 | `015, spindle zero offset (Angle)` |
| 6572 | 32 | `008,Zero soft limit alarm not en` |
| 6599 | 32 | `014,Import CSV sys config tables` |
| 4961 | 33 | `DXF over 2M,no resource to handle` |
| 5005 | 33 | `current workpiece coord sys-&gt;G591` |
| 5006 | 33 | `current workpiece coord sys-&gt;G592` |
| 5007 | 33 | `current workpiece coord sys-&gt;G593` |
| 5008 | 33 | `current workpiece coord sys-&gt;G594` |
| 5009 | 33 | `current workpiece coord sys-&gt;G595` |
| 5010 | 33 | `current workpiece coord sys-&gt;G596` |
| 5011 | 33 | `current workpiece coord sys-&gt;G597` |
| 5012 | 33 | `current workpiece coord sys-&gt;G598` |
| 5013 | 33 | `current workpiece coord sys-&gt;G599` |
| 5084 | 33 | `thread process lead can't be zero` |
| 5715 | 33 | `Format error,whether to re-enter?` |
| 5867 | 33 | `Each cutting radius increment(mm)` |
| 6153 | 33 | `37,Dustproof Appliance Drop Delay` |
| 7236 | 33 | `056Double G Start close meanwhile` |
| 4989 | 34 | `1,move Y axis to machine zeropoint` |
| 4990 | 34 | `1,move Z axis to machine zeropoint` |
| 4991 | 34 | `1,move X axis to machine zeropoint` |
| 5014 | 34 | `start auto search tool set device?` |
| 5077 | 34 | `G71 G72 G73 initial position wrong` |
| 5621 | 34 | `no def macro value getaddrfunction` |
| 5881 | 34 | `Hole Bottom, pause time(M=4 valid)` |
| 5072 | 35 | `wipe current system processing Nos?` |
| 5075 | 35 | `only superuser can amend parameter.` |
| 5081 | 35 | `pls alter prog since G7X cycle is 0` |
| 5716 | 35 | `Pro Num repeat,whether to re-enter?` |
| 5723 | 35 | `delete all of the instruction data?` |
| 6477 | 35 | `Macro Definition Information Output` |
| 5097 | 36 | `G75 axial tool retract exceeds range` |
| 5529 | 36 | `sys start auto recover para,comfirm?` |
| 5778 | 36 | `the first input point must be linear` |
| 6447 | 36 | `G7XG8X  Z and R point Location error` |
| 6476 | 36 | `con Greater 9M,No Resource Handling!` |
| 7174 | 36 | `Init fail!drive selection correct!!!` |
| 4977 | 37 | `macroparameter local variable 1 floor` |
| 4978 | 37 | `macroparameter local variable 2 floor` |
| 4979 | 37 | `macroparameter local variable 3 floor` |
| 4980 | 37 | `macroparameter local variable 4 floor` |
| 4981 | 37 | `macroparameter local variable 5 floor` |
| 5092 | 37 | `G74 radial tool retract exceeds range` |
| 5632 | 37 | `Radii Expiate Can't Support This Code` |
| 6479 | 37 | `line or arc transition Angle of error` |
| 5636 | 38 | `Composite program has expression error` |
| 5773 | 38 | `spline input number exceed upper limit` |
| 6470 | 38 | `TheSystemLoadSecondChannel GcodeFiles?` |
| 5040 | 39 | `macro-variable add: mismatch,can't load` |
| 5526 | 39 | `IO confi para recover to factory value?` |
| 5527 | 39 | `this operate will wipe all para,comfrm?` |
| 5612 | 39 | `no store address for Gcode pro num form` |
| 5071 | 40 | `wipe system accumulative processing Nos?` |

### 41-50 bytes (41 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 5525 | 41 | `synthesize para recover to factory value?` |
| 5631 | 41 | `Radii Expiate Value BigThan Program for R` |
| 5635 | 41 | `Composite prog segments too many overflow` |
| 8039 | 41 | `038,- - - - - - - - - - - - - - - - - - -` |
| 5755 | 42 | `spline mode: pls insert spline coord value` |
| 6446 | 42 | `not configured servo position signal input` |
| 6511 | 42 | `Motion library error please restart system` |
| 6902 | 42 | `SimulationDataGeneratedWhetherToSimulation` |
| 5703 | 43 | `T after cutting the value of the measured D` |
| 5753 | 43 | `arc mode: pls insert arc ending coord value` |
| 5898 | 43 | `resume the running state of the breakpoint?` |
| 6309 | 43 | `070, dual-drive zero maximum deviation (mm)` |
| 6700 | 43 | `&gt; Move the knife shaft to the safe place...` |
| 5073 | 44 | `lead in system configuration table CSV file?` |
| 5076 | 44 | `G71 G72 or G73 outline descrip not monotony.` |
| 5193 | 44 | `process file has mismatch bracket, load fail` |
| 5641 | 44 | `custom macro prog repeat call times overflow` |
| 6154 | 44 | `38,Tool Seting(0-1Reference 1-Not Reference)` |
| 5095 | 45 | `G75 radial cut depth is zero or exceeds range` |
| 5544 | 45 | `must call in state file in stop and auto mode` |
| 5707 | 45 | `T after cutting the value of the measured Len` |
| 5774 | 45 | `no valid instruct data, can't generate G code` |
| 5775 | 45 | `input spline data can't generate spline curve` |
| 5080 | 46 | `pls alter prog since G7X cycles more than 2000` |
| 5091 | 46 | `G74-Z axis depth of cut zero or exceeds range` |
| 5746 | 47 | `15&gt;[EDIT/JOG/MPG] mode:[CAN] delete select line` |
| 5806 | 47 | `System load NC_RES.NCP resource package failed.` |
| 5262 | 48 | `4 comfirm tool setting device in place,resetting` |
| 5757 | 48 | `no input arc ending value, not allow switch mode` |
| 5738 | 49 | `7&gt; F7: Load: upload DAT file into form(EDIT mode)` |
| 5742 | 49 | `11&gt; the number of spline curve's point at least 4` |
| 5749 | 49 | `pls choose mode! 1-linear 2-arc 3-Spline  4G code` |
| 5752 | 49 | `linear mode: pls insert linear ending coord value` |
| 6478 | 49 | `Arc to Angle transition function is not supported` |
| 5085 | 50 | `thread process not detect spindle encoder AB phase` |
| 5745 | 50 | `14&gt; [EDIT] mode: insert a line before select [EOB]` |
| 5748 | 50 | `data can not formation arc whit the previous value` |
| 5779 | 50 | `the coord valve invalid , can't execute this order` |
| 6701 | 50 | `&gt; Z axis safe pos, move to the X, Y coordinates...` |
| 6702 | 50 | `&gt; Y axis safe pos, move to the Z, X cyordinates...` |
| 6703 | 50 | `&gt; X axis safe pos, move to the Y, Z cyordinates...` |

### 51-70 bytes (46 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 5259 | 51 | `3 X,Y coord in place, searching tool setting device` |
| 5260 | 51 | `3 Z,X coord in place, searching tool setting device` |
| 5261 | 51 | `3 Y,Z coord in place, searching tool setting device` |
| 5754 | 51 | `arc mode: pls insert arc random point's coord value` |
| 6704 | 51 | `&gt;  Move Z axis to start scanning mobile location...` |
| 5190 | 52 | `TSysParam verify error, sys auto recovery to Default` |
| 5629 | 52 | `G41G42 StartPoint and EndPoint Equation in LastTrack` |
| 5630 | 52 | `G41G42 StartPoint and EndPoint Equation in NextTrack` |
| 5737 | 52 | `6&gt; F6: Help: quit aid interface press[F1]-[F6]/[CAN]` |
| 6707 | 52 | `&gt; Pos is completed,The tool auto back to a safe pos!` |
| 5087 | 53 | `thread process spindle encoder line number can't be 0` |
| 5718 | 53 | `Program coordinates the value of super-soft limit set` |
| 5724 | 53 | `G32 long axis greater than lead of screw thread error` |
| 5725 | 53 | `G92 long axis greater than lead of screw thread error` |
| 5736 | 53 | `5&gt; F5:Save: save the form file to DAT file(EDIT mode)` |
| 5741 | 53 | `10&gt; press XYZA key lock coord under JOG hand MPG mode` |
| 5191 | 54 | `TKnifeParam verify error, sys auto recovery to Default` |
| 5266 | 54 | `use all machine coord value set to current coord sys?` |
| 5744 | 54 | `13&gt;Press[EOB] enter EDIT interface before write G code` |
| 5777 | 54 | `input arc information incomplete,can't generate G code` |
| 6078 | 54 | `The number of Workpiece  exceeds the maximum set limit` |
| 5735 | 55 | `4&gt; F4:Del: delete the whole instruct data(EDIT/JOG/MPG)` |
| 5255 | 56 | `can't change frame when tool setting,press reset to exit` |
| 5088 | 57 | `motion or reset alarm abnormal exit during thread process` |
| 5226 | 57 | `File name too long, pls enter file name less than 8 chars` |
| 5776 | 57 | `the number of input SPL less than 4,can't generate G code` |
| 6323 | 58 | `Move the cursor to the end of the block,Then press [EDIT].` |
| 6324 | 58 | `Move the cursor to the end of the block,Then press [EDIT].` |
| 5528 | 59 | `if find old version backup file, recover automatic,comfirm?` |
| 5682 | 59 | `G71 G72 FT margin can't be bigger than rough turn cut depth` |
| 5093 | 60 | `final position of G74-Z axis Unspecified or movement is zero` |
| 5094 | 60 | `final position of G75-X axis Unspecified or movement is zero` |
| 5683 | 60 | `thread or tap process spindle encoder line number can't be 0` |
| 5747 | 60 | `16&gt;[S] save instruct data:[O] load instruct file;(EDIT mode)` |
| 5204 | 62 | `pls enter prog #,consist by 4 digits, no repeated prog number` |
| 5227 | 62 | `file name format error, file name consist by number and letter` |
| 5740 | 62 | `9&gt; F9: Del line:  delete the current chosen line(EDIT/JOG/MPG)` |
| 6705 | 63 | `&gt; Knife shaft scanning in place,In search of knife apparatus...` |
| 5734 | 64 | `3&gt; F3: Cur Pos: tool will move to the current form's coord value` |
| 5756 | 64 | `G code mode: pls type-in EDIT mode, and press end key to confirm` |
| 6533 | 64 | `pfopen global file buffer space is not enough,load file fail\r\n` |
| 5228 | 65 | `replace file or not, enter to cover original file, cancel to exit` |
| 5780 | 65 | `The first point must be line mode, enter the end point of a line!` |
| 5691 | 66 | `Processing abnormalities, whether the line to jump to an exception` |
| 5205 | 67 | `no change prog section in sys work condition,pls reset system first` |
| 5733 | 68 | `2&gt; F2: G code: the form data to G code mode is 0 invalid (EDIT mode)` |

### 71-100 bytes (6 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 5890 | 71 | `Note that this parameter is set after a system restart after auto-zero?` |
| 5732 | 73 | `1&gt; F1 Mode: change type 0: invalid 1:straight line 2:arc 3:spline 4:Gcode` |
| 5739 | 73 | `8&gt; F8: Ins line: insert at currtent chosen line's previous row(EDIT mode)` |
| 5192 | 76 | `repeat prog found in process file,only can load the code before the repeated` |
| 6706 | 80 | `&gt; In place of knife instrument signal is detected,In the repeated positioning...` |
| 5803 | 99 | `Stop and EDIT,Press the 'S',enter the num zero by Z-phase,manually test the spindle before turning.` |

### 101-250 bytes (3 entradas)

| # Linea | Bytes | Texto |
|---------|-------|-------|
| 6532 | 102 | `The U disk online processing, U disk is drawn, please insert the U drive again to continue processing!` |
| 6681 | 153 | `Handwheel mode, When handwheel rotation speed is less than the corresponding list of speed, The current processing ratio for run rate value of the group.` |
| 5833 | 238 | `Which time input M98 start circulation processing?(If it input 0, it will skip to the given of b112eginning prcess113,Y ScrewPitch Compensate EN line no.direct114,Z ScrewPitch Compensate ENly in main prog115,A ScrewPitch Compensate ENram)` |

---

## Tabla resumen completa

Todas las **2212** entradas de texto ASCII del firmware, ordenadas por numero de linea.

| # Linea | Bytes | Texto original |
|---------|-------|----------------|
| 4916 | 17 | `FileLoad Success!` |
| 4917 | 8 | `StepOver` |
| 4918 | 5 | `Stop` |
| 4919 | 8 | `Running` |
| 4920 | 6 | `Pause` |
| 4921 | 5 | `Close` |
| 4922 | 4 | `EDIT` |
| 4923 | 3 | `MPG` |
| 4924 | 4 | `STEP` |
| 4925 | 4 | `AUTO` |
| 4926 | 3 | `JOG` |
| 4927 | 4 | `HOME` |
| 4928 | 10 | `CNC READY!` |
| 4929 | 11 | `System VER:` |
| 4930 | 10 | `BuildData:` |
| 4931 | 9 | `FPGA VER:` |
| 4932 | 9 | `DLIB VER:` |
| 4933 | 9 | `GLIB VER:` |
| 4934 | 16 | `Current NC File:` |
| 4935 | 13 | `Current Prog:` |
| 4936 | 5 | `left` |
| 4937 | 18 | `NOs of saved prog` |
| 4938 | 11 | `used space` |
| 4939 | 21 | `system history alarm` |
| 4940 | 28 | `axis No redefine error,check` |
| 4941 | 30 | `template over 128K,can't load` |
| 4942 | 12 | `save success` |
| 4943 | 16 | `new Prog failure` |
| 4944 | 16 | `new prog success` |
| 4945 | 29 | `input wanted character string` |
| 4946 | 20 | `Del current Prog No?` |
| 4947 | 18 | `jump in auto mode?` |
| 4948 | 32 | `jump to current line to process?` |
| 4949 | 1 | `P` |
| 4951 | 9 | `Prog size` |
| 4952 | 15 | `start MDI prog?` |
| 4953 | 18 | `return to default?` |
| 4954 | 30 | `template over 128K,can't load` |
| 4955 | 8 | `Del all?` |
| 4956 | 4 | `Save` |
| 4957 | 4 | `Open` |
| 4958 | 19 | `cover current file?` |
| 4959 | 15 | `can't find file` |
| 4960 | 18 | `can't open catalog` |
| 4961 | 33 | `DXF over 2M,no resource to handle` |
| 4962 | 25 | `can't spot file like this` |
| 4963 | 17 | `load G code file?` |
| 4964 | 12 | `load success` |
| 4965 | 11 | `Del folder?` |
| 4966 | 18 | `Del folder failure` |
| 4967 | 9 | `Del file?` |
| 4968 | 19 | `cat't del this file` |
| 4969 | 7 | `reboot?` |
| 4970 | 16 | `input file name` |
| 4971 | 32 | `can't cover current process file` |
| 4972 | 20 | `replace file folder?` |
| 4973 | 20 | `copy catalog failure` |
| 4974 | 17 | `copy file failure` |
| 4975 | 9 | `file size` |
| 4976 | 13 | `build success` |
| 4977 | 37 | `macroparameter local variable 1 floor` |
| 4978 | 37 | `macroparameter local variable 2 floor` |
| 4979 | 37 | `macroparameter local variable 3 floor` |
| 4980 | 37 | `macroparameter local variable 4 floor` |
| 4981 | 37 | `macroparameter local variable 5 floor` |
| 4982 | 21 | `macro para global var` |
| 4983 | 20 | `input variable value` |
| 4984 | 12 | `variable add` |
| 4985 | 7 | `Abs pos` |
| 4986 | 11 | `machine pos` |
| 4987 | 8 | `Rela pos` |
| 4988 | 26 | `search tool set coordinate` |
| 4989 | 34 | `1,move Y axis to machine zeropoint` |
| 4990 | 34 | `1,move Z axis to machine zeropoint` |
| 4991 | 34 | `1,move X axis to machine zeropoint` |
| 4992 | 17 | `current coord sys` |
| 4993 | 20 | `work boundary point1` |
| 4994 | 20 | `work boundary point2` |
| 4995 | 20 | `work boundary point3` |
| 4996 | 20 | `work boundary point4` |
| 4997 | 20 | `R of round workpiece` |
| 4998 | 16 | `centre reckoning` |
| 4999 | 32 | `current workpiece coord sys-&gt;G54` |
| 5000 | 32 | `current workpiece coord sys-&gt;G55` |
| 5001 | 32 | `current workpiece coord sys-&gt;G56` |
| 5002 | 32 | `current workpiece coord sys-&gt;G57` |
| 5003 | 32 | `current workpiece coord sys-&gt;G58` |
| 5004 | 32 | `current workpiece coord sys-&gt;G59` |
| 5005 | 33 | `current workpiece coord sys-&gt;G591` |
| 5006 | 33 | `current workpiece coord sys-&gt;G592` |
| 5007 | 33 | `current workpiece coord sys-&gt;G593` |
| 5008 | 33 | `current workpiece coord sys-&gt;G594` |
| 5009 | 33 | `current workpiece coord sys-&gt;G595` |
| 5010 | 33 | `current workpiece coord sys-&gt;G596` |
| 5011 | 33 | `current workpiece coord sys-&gt;G597` |
| 5012 | 33 | `current workpiece coord sys-&gt;G598` |
| 5013 | 33 | `current workpiece coord sys-&gt;G599` |
| 5014 | 34 | `start auto search tool set device?` |
| 5015 | 21 | `ensure measure coord?` |
| 5016 | 9 | `offset No` |
| 5017 | 7 | `tool No` |
| 5018 | 13 | `length offset` |
| 5019 | 8 | `R offset` |
| 5020 | 10 | `actual pos` |
| 5021 | 8 | `cut time` |
| 5022 | 8 | `sys time` |
| 5023 | 9 | `Prog rate` |
| 5024 | 11 | `actual rate` |
| 5025 | 9 | `feed rate` |
| 5026 | 5 | `Count` |
| 5027 | 9 | `Fast rate` |
| 5028 | 8 | `SPI rate` |
| 5029 | 8 | `JOG rate` |
| 5030 | 8 | `JOG rate` |
| 5031 | 5 | `Speed` |
| 5032 | 4 | `Mode` |
| 5033 | 7 | `Program` |
| 5034 | 7 | `Machine` |
| 5035 | 9 | `file name` |
| 5036 | 4 | `Prog` |
| 5037 | 13 | `close system?` |
| 5038 | 12 | `Save failure` |
| 5039 | 17 | `data save success` |
| 5040 | 39 | `macro-variable add: mismatch,can't load` |
| 5041 | 12 | `load failure` |
| 5042 | 17 | `data load success` |
| 5043 | 3 | `RUN` |
| 5044 | 4 | `Edit` |
| 5045 | 5 | `PARAM` |
| 5046 | 5 | `COORD` |
| 5047 | 4 | `TEST` |
| 5048 | 3 | `EOB` |
| 5049 | 6 | `cancel` |
| 5050 | 12 | `[cancel]quit` |
| 5051 | 12 | `password set` |
| 5052 | 12 | `[EOB]confirm` |
| 5053 | 18 | `Administrator code` |
| 5054 | 21 | `operator Pre-Password` |
| 5055 | 21 | `operator New Password` |
| 5056 | 22 | `superuser Pre-Password` |
| 5057 | 22 | `superuser New Password` |
| 5058 | 22 | `pls enter Pre-Password` |
| 5059 | 22 | `pls enter New Password` |
| 5060 | 21 | `re-enter New Password` |
| 5061 | 3 | `EOB` |
| 5062 | 6 | `cancle` |
| 5063 | 24 | `pre-password input error` |
| 5064 | 22 | `Password reset success` |
| 5065 | 25 | `2 passwords Inconsistent` |
| 5066 | 27 | `pls input operater password` |
| 5067 | 28 | `pls input superuser password` |
| 5068 | 25 | `superuser password wrong?` |
| 5069 | 24 | `operater password wrong?` |
| 5070 | 18 | `initialize success` |
| 5071 | 40 | `wipe system accumulative processing Nos?` |
| 5072 | 35 | `wipe current system processing Nos?` |
| 5073 | 44 | `lead in system configuration table CSV file?` |
| 5074 | 30 | `fail,cut the power and reboot.` |
| 5075 | 35 | `only superuser can amend parameter.` |
| 5076 | 44 | `G71 G72 or G73 outline descrip not monotony.` |
| 5077 | 34 | `G71 G72 G73 initial position wrong` |
| 5078 | 26 | `G7X outline describe wrong` |
| 5079 | 32 | `G72 Rough cycle depth of cut Err` |
| 5080 | 46 | `pls alter prog since G7X cycles more than 2000` |
| 5081 | 35 | `pls alter prog since G7X cycle is 0` |
| 5082 | 24 | `G32 thread process error` |
| 5083 | 24 | `G92 thread process error` |
| 5084 | 33 | `thread process lead can't be zero` |
| 5085 | 50 | `thread process not detect spindle encoder AB phase` |
| 5086 | 31 | `screw process not spindle Z ECZ` |
| 5087 | 53 | `thread process spindle encoder line number can't be 0` |
| 5088 | 57 | `motion or reset alarm abnormal exit during thread process` |
| 5089 | 31 | `taper thread R-value prog error` |
| 5090 | 31 | `G74 radial offset exceeds range` |
| 5091 | 46 | `G74-Z axis depth of cut zero or exceeds range` |
| 5092 | 37 | `G74 radial tool retract exceeds range` |
| 5093 | 60 | `final position of G74-Z axis Unspecified or movement is zero` |
| 5094 | 60 | `final position of G75-X axis Unspecified or movement is zero` |
| 5095 | 45 | `G75 radial cut depth is zero or exceeds range` |
| 5096 | 31 | `G75-Z axis offset exceeds range` |
| 5097 | 36 | `G75 axial tool retract exceeds range` |
| 5098 | 28 | `G94 X axis increment is zero` |
| 5100 | 27 | `G90 G92 Z increment is zero` |
| 5101 | 26 | `compound code format wrong` |
| 5102 | 4 | `Test` |
| 5103 | 5 | `Coord` |
| 5104 | 4 | `Para` |
| 5105 | 4 | `Edit` |
| 5106 | 3 | `Run` |
| 5107 | 10 | `X zero I00` |
| 5108 | 10 | `Y zero I01` |
| 5109 | 10 | `Z zero I02` |
| 5110 | 10 | `A zero I03` |
| 5111 | 6 | `IN04` |
| 5112 | 6 | `IN05` |
| 5113 | 4 | `IN06` |
| 5114 | 4 | `IN07` |
| 5115 | 4 | `IN08` |
| 5116 | 4 | `IN09` |
| 5117 | 6 | `IN10` |
| 5118 | 6 | `IN11` |
| 5119 | 6 | `IN12` |
| 5120 | 6 | `IN13` |
| 5121 | 6 | `IN14` |
| 5122 | 5 | `IN15` |
| 5123 | 10 | `X-limitI16` |
| 5124 | 10 | `X+limitI17` |
| 5125 | 10 | `Y-limitI18` |
| 5126 | 10 | `Y+limitI19` |
| 5127 | 10 | `Z-limitI20` |
| 5128 | 10 | `Z+limitI21` |
| 5129 | 10 | `A-limitI22` |
| 5130 | 10 | `A+limitI23` |
| 5131 | 8 | `MPG1 I24` |
| 5132 | 8 | `MPGX I25` |
| 5133 | 8 | `MPG2 I26` |
| 5134 | 8 | `MPGY I27` |
| 5135 | 8 | `MPG3 I28` |
| 5136 | 8 | `MPGZ I29` |
| 5137 | 9 | `start I30` |
| 5138 | 8 | `MPGA I31` |
| 5139 | 9 | `pause I32` |
| 5140 | 8 | `stop I33` |
| 5141 | 10 | `Xalarm I34` |
| 5142 | 10 | `Yalarm I35` |
| 5143 | 10 | `Zalarm I36` |
| 5144 | 10 | `Aalarm I37` |
| 5145 | 9 | `X ECZ I40` |
| 5146 | 9 | `Y ECZ I43` |
| 5147 | 9 | `Z ECZ I46` |
| 5148 | 9 | `A ECZ I49` |
| 5149 | 9 | `S ECZ I52` |
| 5150 | 9 | `SPI Cw 00` |
| 5151 | 10 | `SPI Ccw 01` |
| 5152 | 5 | `OUT02` |
| 5153 | 5 | `OUT03` |
| 5154 | 5 | `OUT04` |
| 5155 | 5 | `OUT05` |
| 5156 | 5 | `OUT06` |
| 5157 | 5 | `OUT07` |
| 5158 | 5 | `OUT08` |
| 5159 | 5 | `OUT09` |
| 5160 | 5 | `OUT10` |
| 5161 | 5 | `OUT11` |
| 5162 | 5 | `OUT12` |
| 5163 | 5 | `OUT13` |
| 5164 | 5 | `OUT14` |
| 5165 | 5 | `OUT15` |
| 5166 | 5 | `OUT16` |
| 5167 | 5 | `OUT17` |
| 5168 | 5 | `OUT18` |
| 5169 | 5 | `OUT19` |
| 5170 | 5 | `OUT20` |
| 5171 | 5 | `OUT21` |
| 5172 | 5 | `OUT22` |
| 5173 | 5 | `OUT23` |
| 5174 | 6 | `XOUT24` |
| 5175 | 6 | `YOUT25` |
| 5176 | 6 | `ZOUT26` |
| 5177 | 6 | `AOUT27` |
| 5179 | 8 | `Sys info` |
| 5180 | 4 | `D A` |
| 5181 | 7 | `DA Test` |
| 5182 | 6 | `Output` |
| 5183 | 6 | `O Test` |
| 5184 | 5 | `Input` |
| 5185 | 6 | `I Test` |
| 5186 | 5 | `Alert` |
| 5187 | 10 | `Alert info` |
| 5188 | 5 | `dgnos` |
| 5189 | 5 | `dgnos` |
| 5190 | 52 | `TSysParam verify error, sys auto recovery to Default` |
| 5191 | 54 | `TKnifeParam verify error, sys auto recovery to Default` |
| 5192 | 76 | `repeat prog found in process file,only can load the code before the repeated` |
| 5193 | 44 | `process file has mismatch bracket, load fail` |
| 5194 | 4 | `Skip` |
| 5195 | 9 | `Prog edit` |
| 5196 | 4 | `Seek` |
| 5197 | 8 | `Prog sec` |
| 5198 | 4 | `New` |
| 5199 | 4 | `Edit` |
| 5200 | 3 | `MDI` |
| 5201 | 11 | `MDI running` |
| 5202 | 11 | `machine pos` |
| 5203 | 7 | `abs pos` |
| 5204 | 62 | `pls enter prog #,consist by 4 digits, no repeated prog number` |
| 5205 | 67 | `no change prog section in sys work condition,pls reset system first` |
| 5206 | 5 | `To pc` |
| 5207 | 12 | `File manager` |
| 5208 | 3 | `Cut` |
| 5209 | 5 | `Paste` |
| 5210 | 4 | `Copy` |
| 5211 | 4 | `New` |
| 5212 | 7 | `Devices` |
| 5213 | 4 | `File` |
| 5214 | 4 | `news` |
| 5215 | 7 | `confirm` |
| 5216 | 6 | `cancel` |
| 5217 | 10 | `My Devices` |
| 5218 | 13 | `local disk(c)` |
| 5219 | 13 | `local disk(d)` |
| 5220 | 16 | `data traveler(U)` |
| 5221 | 10 | `My Devices` |
| 5222 | 13 | `local disk(c)` |
| 5223 | 13 | `local disk(d)` |
| 5224 | 16 | `data traveler(U)` |
| 5225 | 28 | `Sys RAM lack, can't continue` |
| 5226 | 57 | `File name too long, pls enter file name less than 8 chars` |
| 5227 | 62 | `file name format error, file name consist by number and letter` |
| 5228 | 65 | `replace file or not, enter to cover original file, cancel to exit` |
| 5229 | 5 | `Coord` |
| 5230 | 5 | `Exp` |
| 5231 | 5 | `Set` |
| 5232 | 5 | `Halve` |
| 5233 | 5 | `T Cut` |
| 5234 | 4 | `Test` |
| 5235 | 7 | `Measure` |
| 5236 | 6 | `TCheck` |
| 5237 | 5 | `HALVE` |
| 5238 | 3 | `Set` |
| 5239 | 7 | `Expiate` |
| 5240 | 5 | `Coord` |
| 5241 | 5 | `Coord` |
| 5242 | 7 | `General` |
| 5243 | 7 | `All Pos` |
| 5244 | 3 | `Rel` |
| 5245 | 7 | `rel pos` |
| 5246 | 3 | `Abs` |
| 5247 | 7 | `Abs Pos` |
| 5248 | 3 | `Pos` |
| 5249 | 3 | `Aid` |
| 5250 | 4 | `Part` |
| 5251 | 5 | `Macro` |
| 5252 | 4 | `User` |
| 5253 | 11 | `(G)Skip Fun` |
| 5254 | 12 | `(X)Close Sys` |
| 5255 | 56 | `can't change frame when tool setting,press reset to exit` |
| 5256 | 32 | `2 Y HOME move over,To Z,X pos...` |
| 5257 | 32 | `2 X HOME move over,To Y,Z pos...` |
| 5258 | 32 | `2 Z HOME move over,To X,Y pos...` |
| 5259 | 51 | `3 X,Y coord in place, searching tool setting device` |
| 5260 | 51 | `3 Z,X coord in place, searching tool setting device` |
| 5261 | 51 | `3 Y,Z coord in place, searching tool setting device` |
| 5262 | 48 | `4 comfirm tool setting device in place,resetting` |
| 5263 | 12 | `5 back HOME!` |
| 5266 | 54 | `use all machine coord value set to current coord sys?` |
| 5267 | 7 | `General` |
| 5268 | 21 | `001,Inp Speed(mm/min)` |
| 5269 | 25 | `002,InpStartSpeed(mm/min)` |
| 5270 | 27 | `003,InpAcceleration(mm/sec)` |
| 5271 | 19 | `004,ZeroReturn Mode` |
| 5272 | 23 | `005, IO FilterWave(1~8)` |
| 5274 | 24 | `007,MaxFeedSpeed(mm/min)` |
| 5275 | 23 | `008,MaxMPGSpeed(mm/min)` |
| 5276 | 22 | `009, Wheel Coefficient` |
| 5277 | 25 | `010, M Code Delaytime(ms)` |
| 5278 | 15 | `011,Line number` |
| 5281 | 22 | `014,Circle InpUnit(mm)` |
| 5282 | 26 | `015,G73(M)LoopObligate(mm)` |
| 5283 | 26 | `016,G83(M)LoopObligate(mm)` |
| 5284 | 16 | `017,Arc Inp Mode` |
| 5285 | 28 | `018,interpolation speed mode` |
| 5286 | 23 | `019,GCode pre-treatment` |
| 5287 | 15 | `020,'O'Pro Scan` |
| 5288 | 22 | `021,SpindleControlMode` |
| 5289 | 25 | `022,OilPressure Open(min)` |
| 5290 | 25 | `023,OilPressure Keep(sec)` |
| 5291 | 27 | `024,OilPressureOut Freq(Hz)` |
| 5292 | 26 | `025,BackHome ModeConf(bit)` |
| 5293 | 21 | `026,Arc Acc.for Radii` |
| 5294 | 21 | `027,Arc Acc.for Speed` |
| 5295 | 24 | `028,PretreatmentCode Set` |
| 5296 | 21 | `029,Inp AccSpeed Mode` |
| 5297 | 25 | `030,'S'Speed Acceleration` |
| 5298 | 24 | `031,HOME Check for alarm` |
| 5299 | 21 | `032,HOME Check Enable` |
| 5300 | 26 | `033,X diameter prog enable` |
| 5301 | 26 | `034,default process plane` |
| 5302 | 15 | `035,T code form` |
| 5307 | 25 | `040,Pretreatment segments` |
| 5308 | 25 | `041,feed speed setting En` |
| 5309 | 26 | `042,enable of G00 Inp mode` |
| 5310 | 22 | `043,abnormal memory En` |
| 5311 | 25 | `044,Z rise to safe pos En` |
| 5312 | 25 | `045,A rise to safe pos En` |
| 5313 | 27 | `046,Pro RZ to reference pos` |
| 5314 | 27 | `047,Mac RZ to reference pos` |
| 5315 | 23 | `048,HOME Mode Cls coord` |
| 5316 | 17 | `049,Z safe height` |
| 5317 | 17 | `050,A safe height` |
| 5318 | 27 | `051,Z axis feed speed limit` |
| 5319 | 27 | `052,A axis feed speed limit` |
| 5320 | 25 | `053,screw Acc pitch P(mm)` |
| 5321 | 26 | `054,screw slow pitch D(mm)` |
| 5322 | 26 | `055,screw back value V(mm)` |
| 5323 | 20 | `056,M98 Jump Line EN` |
| 5324 | 24 | `057,System boot zero way` |
| 5325 | 23 | `058,SPI Brake Delay(ms)` |
| 5326 | 27 | `059,ProCoordOversizeConvert` |
| 5327 | 28 | `060,4 axis max rotate speed` |
| 5328 | 26 | `061,Hand Wheel Encoder Dir` |
| 5329 | 27 | `062,Hand Wheel Control Mode` |
| 5330 | 23 | `063,Hand Wheel Max Rate` |
| 5331 | 23 | `064,Hand Wheel ACC(Kps)` |
| 5332 | 30 | `065,machining end to reference` |
| 5333 | 16 | `axis config para` |
| 5334 | 6 | `Manage` |
| 5335 | 18 | `001,Select SupMode` |
| 5336 | 25 | `002,AlterSuperuserPasswor` |
| 5337 | 23 | `003,Alter User Password` |
| 5338 | 14 | `004,Initialize` |
| 5339 | 24 | `005,Initialize IO Config` |
| 5341 | 15 | `007,para backup` |
| 5342 | 16 | `008,para recover` |
| 5343 | 23 | `009,generate cryptogram` |
| 5344 | 18 | `010,menu click way` |
| 5345 | 25 | `011,clear add up work num` |
| 5346 | 26 | `012,clear current work num` |
| 5347 | 20 | `013,maximum work num` |
| 5349 | 26 | `015,startup display module` |
| 5350 | 20 | `016,sys language bag` |
| 5351 | 27 | `017,macro key word valid En` |
| 5352 | 27 | `018,startup picture display` |
| 5353 | 28 | `019,sys display axis setting` |
| 5354 | 28 | `020,sys debug information En` |
| 5355 | 30 | `021,axis control composite key` |
| 5356 | 27 | `022,additional panel enable` |
| 5360 | 23 | `026,Screen Safeguard En` |
| 5361 | 25 | `027,Modbus Poll/Slave Set` |
| 5364 | 7 | `Spindle` |
| 5365 | 30 | `001,spindle assign port axis #` |
| 5366 | 20 | `002,Spi.Alarm ELevel` |
| 5367 | 20 | `003,Spi.Reset ELevel` |
| 5368 | 24 | `004,,Spi.ECZ Home Enable` |
| 5369 | 18 | `005,Spi.ECZ Elevel` |
| 5370 | 22 | `006,Spi. Limit+ Enable` |
| 5371 | 22 | `007,Spi. Limit- Enable` |
| 5372 | 20 | `008,Spi.Limit Elevel` |
| 5373 | 18 | `009,Spi.Pulse Mode` |
| 5374 | 24 | `010,Spi.Pulse Logic Mode` |
| 5375 | 23 | `011,Spi.HomeDect ELevel` |
| 5376 | 24 | `012,Spi.ExtHome Check En` |
| 5377 | 21 | `013,Spi.Round Setting` |
| 5378 | 22 | `014,Spi.Encode bits(p)` |
| 5379 | 21 | `015,Spi.ZeroOffset(p)` |
| 5380 | 24 | `016,Spi.PulseLogic Level` |
| 5381 | 29 | `017,Spi.Rolling Display Usage` |
| 5382 | 21 | `018,Spi.Max Acc(Kpps)` |
| 5383 | 19 | `019,Spi.Ext HomeDir` |
| 5384 | 21 | `020,Spi.Servo HomeDir` |
| 5385 | 22 | `021,Spi.Max Speed(rpm)` |
| 5386 | 23 | `022,Spi.Home Speed(rpm)` |
| 5387 | 22 | `023,Spi.Gear Numerator` |
| 5388 | 24 | `024,Spi.Gear Denominator` |
| 5389 | 25 | `025,Spi.Encoder Logic Dir` |
| 5390 | 25 | `026,Spi.OpenDelayTime(ms)` |
| 5391 | 29 | `027,servo spindle ready level` |
| 5392 | 31 | `028,servo spi stop to pos level` |
| 5393 | 30 | `029,servo spi zero speed level` |
| 5394 | 28 | `030,sv spi speed reach level` |
| 5395 | 21 | `031,Spi Current Speed` |
| 5396 | 26 | `032,Auto Stop Close Spi En` |
| 5397 | 21 | `033,Spi Minimum Speed` |
| 5398 | 28 | `034,Second Spi Maximum Speed` |
| 5399 | 20 | `034,Second Spi Speed` |
| 5400 | 30 | `036,Spi CodeCommand Invalid En` |
| 5401 | 25 | `037,Machine Spi One Speed` |
| 5402 | 25 | `038,Machine Spi Two Speed` |
| 5403 | 27 | `039,Machine Spi Three Speed` |
| 5404 | 26 | `040,Machine Spi Four Speed` |
| 5405 | 26 | `041,Spindle Stop Delay(ms)` |
| 5406 | 12 | `port config` |
| 5407 | 27 | `001,Tool Checking signal In` |
| 5408 | 23 | `002,Tool Safe Signal In` |
| 5409 | 20 | `003,Tool Changer Out` |
| 5410 | 30 | `004,Tool Changer Dustproof Out` |
| 5411 | 29 | `005,Tool Changer Dustproof In` |
| 5412 | 20 | `006,Tool Limit Input` |
| 5413 | 20 | `007,Tool Blow Output` |
| 5414 | 22 | `008,Spi Alarm Check In` |
| 5415 | 29 | `009,Transduser Alarm Check In` |
| 5416 | 25 | `010,Servo Spi ready input` |
| 5417 | 24 | `011,Servo Spi stop input` |
| 5418 | 30 | `012,Servo Spi zero speed input` |
| 5419 | 31 | `013,Servo Spi speed reach input` |
| 5420 | 22 | `014,VFD 0 Level Output` |
| 5421 | 22 | `015,VFD 1 Level Output` |
| 5422 | 22 | `016,VFD 2 Level Output` |
| 5423 | 22 | `017,VFD 3 Level Output` |
| 5424 | 21 | `018,Spindle CW Output` |
| 5425 | 22 | `019,Spindle CCW Output` |
| 5426 | 22 | `020,Spindle2 CW Output` |
| 5427 | 23 | `021,Spindle2 CCW Output` |
| 5428 | 29 | `022,Transduser Alarm Rest Out` |
| 5429 | 23 | `023,Spindle Blow Output` |
| 5430 | 24 | `024,Spindle Brake Output` |
| 5431 | 23 | `025,Servo Spi En Output` |
| 5432 | 25 | `026,Servo Spi Stop Output` |
| 5433 | 26 | `027,Servo Spi Pulse Output` |
| 5434 | 31 | `028,sv Spi Rigid tapping output` |
| 5435 | 27 | `029,Safe Signal Check Input` |
| 5436 | 28 | `030,Air Pressure Alarm Input` |
| 5437 | 21 | `031,Chuck Alarm Input` |
| 5438 | 28 | `032,Oil Pressure Alarm Input` |
| 5439 | 24 | `033,ExStart2 Check Input` |
| 5440 | 24 | `034,ExPause2 Check Input` |
| 5441 | 24 | `035,ExScram2 Check Input` |
| 5442 | 22 | `036,Cooler Alarm Input` |
| 5443 | 22 | `037,Oiling Alarm Input` |
| 5444 | 19 | `038,Ext Reset Input` |
| 5445 | 22 | `039,Tool Locking Input` |
| 5446 | 21 | `040,AlarmLight Output` |
| 5447 | 19 | `041,RunLight Output` |
| 5448 | 20 | `042,StopLight Output` |
| 5449 | 25 | `043,SYS ReadyLight Output` |
| 5450 | 14 | `044,Oil Output` |
| 5451 | 15 | `045,Cool Output` |
| 5452 | 19 | `046,Oil Pump Output` |
| 5453 | 18 | `047,X Limit- Input` |
| 5454 | 22 | `X Limit+ Input` |
| 5455 | 22 | `Y Limit- Input` |
| 5456 | 22 | `Y Limit+ Input` |
| 5457 | 22 | `Z Limit- Input` |
| 5458 | 22 | `Z Limit+ Input` |
| 5459 | 22 | `4 Limit- Input` |
| 5460 | 22 | `4 Limit+ Input` |
| 5461 | 22 | `B Limit- Input` |
| 5462 | 22 | `B Limit+ Input` |
| 5463 | 22 | `C Limit- Input` |
| 5464 | 22 | `C Limit+ Input` |
| 5465 | 20 | `048,X Ext Home Input` |
| 5466 | 24 | `Y Ext Home Input` |
| 5467 | 24 | `Z Ext Home Input` |
| 5468 | 24 | `4 Ext Home Input` |
| 5469 | 24 | `B Ext Home Input` |
| 5470 | 24 | `C Ext Home Input` |
| 5471 | 21 | `049,X Servo En Output` |
| 5472 | 25 | `Y Servo En Output` |
| 5473 | 25 | `Z Servo En Output` |
| 5474 | 25 | `4 Servo En Output` |
| 5475 | 25 | `B Servo En Output` |
| 5476 | 25 | `C Servo En Output` |
| 5477 | 27 | `050,Input Check Level 00~31` |
| 5478 | 27 | `051,Input Check Level 32~63` |
| 5479 | 27 | `052,Input Check Level 64~95` |
| 5480 | 23 | `053,IO Conf Reset 00~31` |
| 5481 | 23 | `054,IO Conf Reset 32~63` |
| 5482 | 23 | `055,IO Conf Reset 64~95` |
| 5483 | 18 | `056,Led Reset 0~31` |
| 5484 | 19 | `057,Led Reset 32~63` |
| 5485 | 19 | `058,Led Reset 64~95` |
| 5486 | 8 | `end mark` |
| 5487 | 22 | `Current Tool No(#4120)` |
| 5488 | 20 | `Tool Max Count(#400)` |
| 5489 | 20 | `X Standard Pos(#401)` |
| 5490 | 20 | `Y Standard Pos(#402)` |
| 5491 | 20 | `Z Standard Pos(#403)` |
| 5492 | 22 | `Tool Safe Height(#404)` |
| 5493 | 22 | `Tool Rapid Speed(#405)` |
| 5494 | 21 | `Tool Slow Speed(#406)` |
| 5495 | 23 | `Rapid Descend Pos(#407)` |
| 5496 | 15 | `Tool Pos2(#408)` |
| 5497 | 15 | `Tool pos3(#409)` |
| 5498 | 23 | `Spindle Blow Hold(#410)` |
| 5499 | 16 | `X safe Pos(#411)` |
| 5500 | 16 | `Y safe Pos(#412)` |
| 5501 | 19 | `Tool Interval(#413)` |
| 5502 | 22 | `Stuck Pos Offset(#414)` |
| 5503 | 18 | `max time(ms)(#401)` |
| 5504 | 24 | `rest lock time(ms)(#402)` |
| 5505 | 26 | `delay of re-lock(ms)(#403)` |
| 5506 | 21 | `Tool Bit Elevel(#404)` |
| 5507 | 4 | `Port` |
| 5508 | 4 | `Port` |
| 5509 | 7 | `IO para` |
| 5510 | 7 | `Spindle` |
| 5511 | 7 | `Spindle` |
| 5512 | 7 | `Spindle` |
| 5513 | 5 | `Tools` |
| 5514 | 4 | `Tool` |
| 5515 | 4 | `Tool` |
| 5516 | 6 | `Manage` |
| 5517 | 6 | `Manage` |
| 5518 | 6 | `Manage` |
| 5519 | 4 | `Axis` |
| 5520 | 4 | `Axis` |
| 5521 | 4 | `Axis` |
| 5522 | 4 | `Genl` |
| 5523 | 7 | `general` |
| 5524 | 4 | `para` |
| 5525 | 41 | `synthesize para recover to factory value?` |
| 5526 | 39 | `IO confi para recover to factory value?` |
| 5527 | 39 | `this operate will wipe all para,comfrm?` |
| 5528 | 59 | `if find old version backup file, recover automatic,comfirm?` |
| 5529 | 36 | `sys start auto recover para,comfirm?` |
| 5530 | 27 | `sys finish recover, reboot?` |
| 5531 | 30 | `above operator can modify para` |
| 5532 | 5 | `Coord` |
| 5533 | 5 | `Plane` |
| 5536 | 7 | `Preview` |
| 5537 | 8 | `Tracking` |
| 5538 | 3 | `Cls` |
| 5539 | 4 | `Path` |
| 5540 | 12 | `Path picture` |
| 5541 | 12 | `input line #` |
| 5542 | 10 | `input Nxxx` |
| 5543 | 20 | `can't find the N add` |
| 5544 | 45 | `must call in state file in stop and auto mode` |
| 5545 | 27 | `This parameter is read-only` |
| 5546 | 11 | `Refer coord` |
| 5547 | 12 | `Refer coord2` |
| 5548 | 12 | `Refer coord3` |
| 5549 | 12 | `Refer coord4` |
| 5554 | 17 | `sys unknown alarm` |
| 5555 | 9 | `Seek line` |
| 5556 | 6 | `Seek N` |
| 5558 | 5 | `Reset` |
| 5559 | 11 | `Prog No End` |
| 5560 | 28 | `No Appointed Motion Function` |
| 5561 | 25 | `No GCode GetLine Function` |
| 5562 | 10 | `M6Tx Abort` |
| 5563 | 12 | `Tool Invalid` |
| 5564 | 22 | `G Program Repeat Error` |
| 5565 | 22 | `G Program Number Error` |
| 5566 | 27 | `G7X8X Instruction Run Error` |
| 5567 | 16 | `PortNumber Error` |
| 5568 | 13 | `Program Abend` |
| 5569 | 30 | `Appointed M01 Instruction Stop` |
| 5570 | 26 | `No Appointed ProgramNumber` |
| 5571 | 16 | `M98 Format Error` |
| 5572 | 16 | `Motion Run Error` |
| 5573 | 25 | `Current Program No Repair` |
| 5574 | 22 | `G Program Format Error` |
| 5575 | 21 | `M99 Instruction Abort` |
| 5576 | 12 | `Motion Abort` |
| 5577 | 12 | `Illegal char` |
| 5578 | 31 | `Noneffective Exegesis Character` |
| 5579 | 14 | `Illegal G Code` |
| 5580 | 26 | `GCode RadialOffset Num Err` |
| 5581 | 31 | `Noneffective GCode RadialOffset` |
| 5582 | 19 | `Arc Appointed Error` |
| 5583 | 28 | `Appointed Noneffective Plane` |
| 5584 | 21 | `M98 Instruction Abort` |
| 5585 | 30 | `Spindle Appointed Number Error` |
| 5586 | 23 | `MCode Instruction Abort` |
| 5587 | 17 | `Spi Appointed Err` |
| 5588 | 21 | `Motion Repeat Request` |
| 5589 | 23 | `Appointed Arc Nonentity` |
| 5590 | 20 | `Missing X Code Error` |
| 5591 | 20 | `Missing Y Code Error` |
| 5592 | 20 | `Missing Z Code Error` |
| 5593 | 20 | `Missing A Code Error` |
| 5594 | 20 | `Missing B Code Error` |
| 5595 | 20 | `Missing C Code Error` |
| 5596 | 20 | `Missing D Code Error` |
| 5597 | 20 | `Missing R Code Error` |
| 5598 | 20 | `Missing F Code Error` |
| 5599 | 20 | `Missing T Code Error` |
| 5600 | 20 | `Missing S Code Error` |
| 5601 | 20 | `Missing P Code Error` |
| 5602 | 20 | `Missing M Code Error` |
| 5603 | 20 | `Missing G Code Error` |
| 5604 | 20 | `Missing I Code Error` |
| 5605 | 20 | `Missing J Code Error` |
| 5606 | 20 | `Missing K Code Error` |
| 5607 | 20 | `Missing Q Code Error` |
| 5608 | 24 | `Screw Value Repeat Error` |
| 5609 | 12 | `System Abort` |
| 5610 | 17 | `Factitious return` |
| 5611 | 18 | `no parameter input` |
| 5612 | 39 | `no store address for Gcode pro num form` |
| 5613 | 19 | `Call false in Macro` |
| 5614 | 22 | `Macro expression error` |
| 5615 | 21 | `MacroValue addr error` |
| 5616 | 11 | `Value error` |
| 5617 | 9 | `goto fail` |
| 5618 | 28 | `WHILE key \"[ ]\" pair error` |
| 5619 | 23 | `\"WHILE\"  Nested error` |
| 5620 | 26 | `SubProgram Nested too much` |
| 5621 | 34 | `no def macro value getaddrfunction` |
| 5622 | 16 | `userdefine alarm` |
| 5623 | 16 | `userdefine alarm` |
| 5624 | 19 | `Constant Call Error` |
| 5625 | 31 | `The i_gcode Error in Last track` |
| 5626 | 31 | `The i_gcode Error in Next track` |
| 5627 | 22 | `G41G42 StartLine Error` |
| 5628 | 20 | `G41G42 EndLine Error` |
| 5629 | 52 | `G41G42 StartPoint and EndPoint Equation in LastTrack` |
| 5630 | 52 | `G41G42 StartPoint and EndPoint Equation in NextTrack` |
| 5631 | 41 | `Radii Expiate Value BigThan Program for R` |
| 5632 | 37 | `Radii Expiate Can't Support This Code` |
| 5633 | 19 | `NURBS Node too many` |
| 5634 | 16 | `NURBS para error` |
| 5635 | 41 | `Composite prog segments too many overflow` |
| 5636 | 38 | `Composite program has expression error` |
| 5637 | 16 | `no U order error` |
| 5638 | 16 | `no W order error` |
| 5639 | 32 | `multiple G code expression error` |
| 5640 | 18 | `multi M code error` |
| 5641 | 44 | `custom macro prog repeat call times overflow` |
| 5642 | 18 | `no  \"return zero\` |
| 5643 | 27 | `4 - direction program limit` |
| 5644 | 27 | `4 + direction program limit` |
| 5645 | 27 | `Z - direction program limit` |
| 5646 | 27 | `Z + direction program limit` |
| 5647 | 27 | `Y - direction program limit` |
| 5648 | 27 | `Y + direction program limit` |
| 5649 | 27 | `X - direction program limit` |
| 5650 | 27 | `X + direction program limit` |
| 5651 | 27 | `4 - direction machine limit` |
| 5652 | 27 | `4 + direction machine limit` |
| 5653 | 27 | `Z - direction machine limit` |
| 5654 | 27 | `Z + direction machine limit` |
| 5655 | 27 | `Y - direction machine limit` |
| 5656 | 27 | `Y + direction machine limit` |
| 5657 | 27 | `X - direction machine limit` |
| 5658 | 27 | `X + direction machine limit` |
| 5659 | 5 | `SCRAM` |
| 5660 | 20 | `X Sevor driver alarm` |
| 5661 | 20 | `Y Sevor driver alarm` |
| 5662 | 20 | `Z Sevor driver alarm` |
| 5663 | 20 | `A Sevor driver alarm` |
| 5664 | 29 | `Axis's physical line redefine` |
| 5665 | 14 | `spi no to home` |
| 5666 | 17 | `workpiece no lock` |
| 5667 | 24 | `safe signal can't detect` |
| 5668 | 7 | `GCodeRe` |
| 5669 | 13 | `air no enough` |
| 5670 | 25 | `chuck signal alarm detect` |
| 5671 | 21 | `OilPressure no enough` |
| 5672 | 20 | `Spindle alarm occurs` |
| 5673 | 23 | `Transducer alarm occurs` |
| 5674 | 13 | `PutTools Fail` |
| 5675 | 13 | `GetTools Fail` |
| 5676 | 22 | `ToolsDoor Can't detect` |
| 5677 | 16 | `bayonet lock err` |
| 5678 | 14 | `knife-song err` |
| 5679 | 7 | `Reserve` |
| 5680 | 22 | `TCheck Error for Limit` |
| 5681 | 28 | `addition panel abnormal work` |
| 5682 | 59 | `G71 G72 FT margin can't be bigger than rough turn cut depth` |
| 5683 | 60 | `thread or tap process spindle encoder line number can't be 0` |
| 5684 | 29 | `G33 tap order execution error` |
| 5686 | 11 | `config file` |
| 5687 | 12 | `Wait USB Com` |
| 5688 | 10 | `USB Com...` |
| 5689 | 21 | `preprocessing Lib Ver` |
| 5690 | 20 | `Abnormal memory code` |
| 5691 | 66 | `Processing abnormalities, whether the line to jump to an exception` |
| 5693 | 12 | `current tool` |
| 5694 | 5 | `Diame` |
| 5697 | 9 | `Cut Diame` |
| 5698 | 7 | `Cut Len` |
| 5699 | 20 | `Input X Diame offset` |
| 5700 | 18 | `Input Z Len offset` |
| 5701 | 14 | `Input T Radius` |
| 5702 | 11 | `Input T Dir` |
| 5703 | 43 | `T after cutting the value of the measured D` |
| 5704 | 12 | `current tool` |
| 5705 | 3 | `Exp` |
| 5706 | 5 | `T cut` |
| 5707 | 45 | `T after cutting the value of the measured Len` |
| 5709 | 11 | `Find Error!` |
| 5710 | 10 | `Find Over!` |
| 5711 | 21 | `File exception error?` |
| 5712 | 19 | `Pro number is full?` |
| 5713 | 23 | `Pro number del success?` |
| 5714 | 29 | `Parameters failed to restore!` |
| 5715 | 33 | `Format error,whether to re-enter?` |
| 5716 | 35 | `Pro Num repeat,whether to re-enter?` |
| 5717 | 29 | `preprocessing exception error` |
| 5718 | 53 | `Program coordinates the value of super-soft limit set` |
| 5719 | 24 | `G code reserved succeed` |
| 5720 | 32 | `insert one line before this line` |
| 5721 | 24 | `confirm delete this line` |
| 5722 | 31 | `move it to the form coordinate?` |
| 5723 | 35 | `delete all of the instruction data?` |
| 5724 | 53 | `G32 long axis greater than lead of screw thread error` |
| 5725 | 53 | `G92 long axis greater than lead of screw thread error` |
| 5726 | 27 | `G76 Z increment value error` |
| 5727 | 24 | `G76 starting point error` |
| 5728 | 28 | `G76 screw tooth high is zero` |
| 5729 | 19 | `G76 FT margin error` |
| 5730 | 13 | `G76 DOC error` |
| 5731 | 21 | `G76 screw pitch error` |
| 5732 | 73 | `1&gt; F1 Mode: change type 0: invalid 1:straight line 2:arc 3:spline 4:Gcode` |
| 5733 | 68 | `2&gt; F2: G code: the form data to G code mode is 0 invalid (EDIT mode)` |
| 5734 | 64 | `3&gt; F3: Cur Pos: tool will move to the current form's coord value` |
| 5735 | 55 | `4&gt; F4:Del: delete the whole instruct data(EDIT/JOG/MPG)` |
| 5736 | 53 | `5&gt; F5:Save: save the form file to DAT file(EDIT mode)` |
| 5737 | 52 | `6&gt; F6: Help: quit aid interface press[F1]-[F6]/[CAN]` |
| 5738 | 49 | `7&gt; F7: Load: upload DAT file into form(EDIT mode)` |
| 5739 | 73 | `8&gt; F8: Ins line: insert at currtent chosen line's previous row(EDIT mode)` |
| 5740 | 62 | `9&gt; F9: Del line:  delete the current chosen line(EDIT/JOG/MPG)` |
| 5741 | 53 | `10&gt; press XYZA key lock coord under JOG hand MPG mode` |
| 5742 | 49 | `11&gt; the number of spline curve's point at least 4` |
| 5744 | 54 | `13&gt;Press[EOB] enter EDIT interface before write G code` |
| 5745 | 50 | `14&gt; [EDIT] mode: insert a line before select [EOB]` |
| 5746 | 47 | `15&gt;[EDIT/JOG/MPG] mode:[CAN] delete select line` |
| 5747 | 60 | `16&gt;[S] save instruct data:[O] load instruct file;(EDIT mode)` |
| 5748 | 50 | `data can not formation arc whit the previous value` |
| 5749 | 49 | `pls choose mode! 1-linear 2-arc 3-Spline  4G code` |
| 5750 | 27 | `more than 4 data for spline` |
| 5751 | 28 | `not allow  insert in the arc` |
| 5752 | 49 | `linear mode: pls insert linear ending coord value` |
| 5753 | 43 | `arc mode: pls insert arc ending coord value` |
| 5754 | 51 | `arc mode: pls insert arc random point's coord value` |
| 5755 | 42 | `spline mode: pls insert spline coord value` |
| 5756 | 64 | `G code mode: pls type-in EDIT mode, and press end key to confirm` |
| 5757 | 48 | `no input arc ending value, not allow switch mode` |
| 5758 | 6 | `X lock` |
| 5759 | 6 | `Y lock` |
| 5760 | 8 | `X Y lock` |
| 5761 | 6 | `Z lock` |
| 5762 | 8 | `X Z lock` |
| 5763 | 8 | `Y Z lock` |
| 5764 | 10 | `X Y Z lock` |
| 5765 | 6 | `A lock` |
| 5766 | 8 | `X A lock` |
| 5767 | 8 | `Y A lock` |
| 5768 | 10 | `X Y A lock` |
| 5769 | 9 | `Z A  lock` |
| 5770 | 10 | `X Z A lock` |
| 5771 | 10 | `Y Z A lock` |
| 5773 | 38 | `spline input number exceed upper limit` |
| 5774 | 45 | `no valid instruct data, can't generate G code` |
| 5775 | 45 | `input spline data can't generate spline curve` |
| 5776 | 57 | `the number of input SPL less than 4,can't generate G code` |
| 5777 | 54 | `input arc information incomplete,can't generate G code` |
| 5778 | 36 | `the first input point must be linear` |
| 5779 | 50 | `the coord valve invalid , can't execute this order` |
| 5780 | 65 | `The first point must be line mode, enter the end point of a line!` |
| 5781 | 5 | `Del` |
| 5782 | 6 | `Save` |
| 5783 | 5 | `Teach` |
| 5784 | 4 | `Load` |
| 5785 | 4 | `Help` |
| 5786 | 8 | `Del line` |
| 5787 | 8 | `Ins line` |
| 5788 | 7 | `Cur Pos` |
| 5789 | 6 | `G code` |
| 5790 | 4 | `Mode` |
| 5791 | 3 | `Num` |
| 5792 | 4 | `mode` |
| 5793 | 6 | `Module` |
| 5794 | 6 | `DA (G)` |
| 5795 | 7 | `SPI (X)` |
| 5796 | 8 | `SPI Info` |
| 5797 | 9 | `SPI Speed` |
| 5798 | 15 | `SPI Encode bits` |
| 5799 | 12 | `SPI Position` |
| 5800 | 9 | `SPI Angle` |
| 5801 | 3 | `Nos` |
| 5802 | 5 | `Angle` |
| 5803 | 99 | `Stop and EDIT,Press the 'S',enter the num zero by Z-phase,manually test the spindle before turning.` |
| 5804 | 5 | `Check` |
| 5805 | 16 | `Param Backup OK!` |
| 5806 | 47 | `System load NC_RES.NCP resource package failed.` |
| 5807 | 25 | `M98 began processing line` |
| 5808 | 22 | `Is not enabled TCheck?` |
| 5809 | 6 | `Offset` |
| 5810 | 8 | `X Offset` |
| 5811 | 8 | `Y Offset` |
| 5812 | 8 | `Z Offset` |
| 5813 | 8 | `A Offset` |
| 5814 | 8 | `B Offset` |
| 5815 | 8 | `C Offset` |
| 5816 | 3 | `Nos` |
| 5817 | 9 | `A Forward` |
| 5818 | 9 | `A Reverse` |
| 5819 | 9 | `X Forward` |
| 5820 | 9 | `X Reverse` |
| 5821 | 9 | `Y Forward` |
| 5822 | 9 | `Y Reverse` |
| 5823 | 9 | `Z Forward` |
| 5824 | 9 | `Z Reverse` |
| 5825 | 23 | `X two-way plane milling` |
| 5826 | 23 | `Y two-way plane milling` |
| 5827 | 23 | `X one-way plane milling` |
| 5828 | 23 | `Y one-way plane milling` |
| 5829 | 25 | `XY plane circular milling` |
| 5830 | 24 | `XY plane Rectangular Box` |
| 5831 | 21 | `XY plane Circular Box` |
| 5832 | 26 | `Hole loop of circular mode` |
| 5833 | 238 | `Which time input M98 start circulation processing?(If it input 0, it will skip to the given of b112eginning prcess113,Y ScrewPitch Compensate EN line no.direct114,Z ScrewPitch Compensate ENly in main prog115,A ScrewPitch Compensate ENram)` |
| 5834 | 6 | `A Comp` |
| 5835 | 6 | `Z Comp` |
| 5836 | 6 | `Y Comp` |
| 5837 | 6 | `X Comp` |
| 5838 | 10 | `(7)MPG RUN` |
| 5839 | 11 | `(8)Mac Lock` |
| 5840 | 6 | `(9)M01` |
| 5841 | 9 | `(M)Fast0%` |
| 5842 | 10 | `(Y)Fast25%` |
| 5843 | 10 | `(4)Fast50%` |
| 5844 | 11 | `(5)Fast100%` |
| 5845 | 12 | `(6)Tailstock` |
| 5846 | 5 | `(F)F0` |
| 5847 | 5 | `(Z)F1` |
| 5848 | 5 | `(1)F2` |
| 5849 | 5 | `(2)F3` |
| 5850 | 5 | `(3)F4` |
| 5851 | 8 | `(R)Tlock` |
| 5852 | 7 | `(A)Blow` |
| 5853 | 6 | `(-)T++` |
| 5854 | 6 | `(0)T--` |
| 5855 | 15 | `(.)chip removal` |
| 5856 | 18 | `Each cutting width` |
| 5857 | 20 | `X Axis Start Pos(mm)` |
| 5858 | 20 | `Y Axis Start Pos(mm)` |
| 5859 | 26 | `Z Axis Plane Start Pos(mm)` |
| 5860 | 24 | `X-axis workpiece len(mm)` |
| 5861 | 24 | `Y-axis workpiece len(mm)` |
| 5862 | 14 | `T Diameter(mm)` |
| 5863 | 24 | `Each machining depth(mm)` |
| 5864 | 25 | `Total machining depth(mm)` |
| 5865 | 18 | `Spindle Speed(rpm)` |
| 5866 | 17 | `Feed rate(mm/min)` |
| 5867 | 33 | `Each cutting radius increment(mm)` |
| 5868 | 21 | `The circle radius(mm)` |
| 5869 | 22 | `cutting Dir:2-CW 3-CCW` |
| 5870 | 27 | `Box Mode:0-inside 1-outside` |
| 5871 | 21 | `The circle radius(mm)` |
| 5872 | 21 | `The circle radius(mm)` |
| 5873 | 20 | `The center X pos(mm)` |
| 5874 | 20 | `The center Y pos(mm)` |
| 5875 | 17 | `Cutting Mode(1-4)` |
| 5876 | 14 | `Starting angle` |
| 5877 | 11 | `Hole Number` |
| 5878 | 16 | `initial position` |
| 5879 | 24 | `Each machining depth(mm)` |
| 5880 | 25 | `Processing of repetitions` |
| 5881 | 34 | `Hole Bottom, pause time(M=4 valid)` |
| 5882 | 19 | `Hole Bottom Pos(mm)` |
| 5883 | 24 | `129,System boot zero way` |
| 5887 | 7 | `Non  RZ` |
| 5888 | 9 | `Prompt RZ` |
| 5889 | 7 | `Auto RZ` |
| 5890 | 71 | `Note that this parameter is set after a system restart after auto-zero?` |
| 5891 | 9 | `Copy File` |
| 5892 | 9 | `Load Code` |
| 5893 | 12 | `Cooler alarm` |
| 5894 | 12 | `Positive Dir` |
| 5895 | 12 | `Negative Dir` |
| 5896 | 32 | `whether do you need return Zero?` |
| 5897 | 24 | `Press[EOB] 3 Sec to exit` |
| 5898 | 43 | `resume the running state of the breakpoint?` |
| 5899 | 7 | `Pos mem` |
| 5900 | 7 | `Sta mem` |
| 5901 | 16 | `Chuck unlock err` |
| 5902 | 5 | `Exp` |
| 5903 | 8 | `SPI 2 Cw` |
| 5904 | 9 | `SPI 2 Ccw` |
| 5905 | 5 | `Adi 2` |
| 5906 | 10 | `Time Split` |
| 5907 | 9 | `Pos Split` |
| 5908 | 5 | `Angle` |
| 5909 | 5 | `Speed` |
| 5910 | 9 | `Real Time` |
| 5911 | 11 | `preproccess` |
| 5912 | 9 | `Abs Coord` |
| 5913 | 9 | `Mac Coord` |
| 5914 | 24 | `No Enough Of Disk Space` |
| 5915 | 12 | `File Encrypt` |
| 5916 | 24 | `No Enough Of Disk Space` |
| 5917 | 1 | `A` |
| 5921 | 1 | `M` |
| 5923 | 1 | `R` |
| 5924 | 29 | `1,move A axis to machine home` |
| 5925 | 6 | `Refer1` |
| 5926 | 6 | `Refer2` |
| 5927 | 6 | `Refer3` |
| 5928 | 6 | `Refer4` |
| 5929 | 9 | `Work Time` |
| 5930 | 8 | `Sys Time` |
| 5931 | 7 | `Inp Add` |
| 5932 | 10 | `Totalcount` |
| 5933 | 1 | `B` |
| 5934 | 1 | `C` |
| 5935 | 9 | `prog home` |
| 5936 | 8 | `mac home` |
| 5937 | 17 | `CHUCK ABIERTO!!!!` ← YA PERSONALIZADO (original: `Safe Single Valid`, Param 029=4) |
| 5938 | 11 | `X+Limit I00` |
| 5939 | 11 | `X-Limit I01` |
| 5940 | 11 | `Y+Limit I02` |
| 5941 | 11 | `Y-Limit I03` |
| 5942 | 11 | `Z+Limit I04` |
| 5943 | 11 | `Z-Limit I05` |
| 5944 | 11 | `A+Limit I06` |
| 5945 | 11 | `A-Limit I07` |
| 5946 | 10 | `X Home I08` |
| 5947 | 10 | `Y Home I09` |
| 5948 | 10 | `Z Home I10` |
| 5949 | 10 | `A Home I11` |
| 5950 | 10 | `B Home I12` |
| 5951 | 10 | `C Home I13` |
| 5954 | 11 | `B+Limit I16` |
| 5955 | 11 | `B-Limit I17` |
| 5956 | 11 | `C+Limit I18` |
| 5957 | 11 | `C-Limit I19` |
| 5994 | 11 | `Wheel X I56` |
| 5995 | 11 | `Wheel Y I56` |
| 5996 | 11 | `Wheel Z I56` |
| 5997 | 11 | `Wheel A I56` |
| 5998 | 11 | `Wheel C I56` |
| 5999 | 9 | `Scram I61` |
| 6000 | 11 | `Wheel B I56` |
| 6001 | 10 | `Wheel1 I63` |
| 6002 | 10 | `Wheel2 I64` |
| 6003 | 10 | `Wheel3 I65` |
| 6004 | 11 | `X Alarm I66` |
| 6005 | 11 | `Y Alarm I67` |
| 6006 | 11 | `Z Alarm I68` |
| 6007 | 11 | `A Alarm I69` |
| 6008 | 11 | `B Alarm I70` |
| 6009 | 11 | `C Alarm I71` |
| 6010 | 9 | `X ECZ I72` |
| 6011 | 9 | `Y ECZ I73` |
| 6012 | 9 | `Z ECZ I74` |
| 6013 | 9 | `A ECZ I75` |
| 6014 | 9 | `B ECZ I76` |
| 6015 | 9 | `C ECZ I77` |
| 6016 | 9 | `X ECA I78` |
| 6017 | 9 | `X ECB I79` |
| 6018 | 9 | `Y ECA I80` |
| 6019 | 9 | `Y ECB I81` |
| 6020 | 9 | `Z ECA I82` |
| 6021 | 9 | `Z ECB I83` |
| 6022 | 9 | `A ECA I84` |
| 6023 | 9 | `A ECB I85` |
| 6024 | 9 | `B ECA I86` |
| 6025 | 9 | `B ECB I87` |
| 6026 | 9 | `C ECA I88` |
| 6027 | 9 | `C ECB I89` |
| 6065 | 7 | `Save As` |
| 6066 | 7 | `Encrypt` |
| 6067 | 7 | `SD Disk` |
| 6068 | 24 | `B - direction soft limit` |
| 6069 | 24 | `B + direction soft limit` |
| 6070 | 24 | `C - direction soft limit` |
| 6071 | 24 | `C + direction soft limit` |
| 6072 | 27 | `B - direction machine limit` |
| 6073 | 27 | `B + direction machine limit` |
| 6074 | 27 | `C - direction machine limit` |
| 6075 | 27 | `C + direction machine limit` |
| 6076 | 20 | `B Sevor driver alarm` |
| 6077 | 20 | `C Sevor driver alarm` |
| 6078 | 54 | `The number of Workpiece  exceeds the maximum set limit` |
| 6079 | 13 | `Housing Error` |
| 6080 | 25 | `Pressure Transducer Error` |
| 6081 | 12 | `Vacuum Error` |
| 6082 | 13 | `Custom Alarm4` |
| 6083 | 13 | `Custom Alarm5` |
| 6084 | 13 | `Custom Alarm6` |
| 6085 | 13 | `Custom Alarm7` |
| 6086 | 13 | `Custom Alarm8` |
| 6087 | 13 | `Custom Alarm9` |
| 6088 | 14 | `Custom Alarm10` |
| 6089 | 14 | `Custom Alarm11` |
| 6090 | 14 | `Custom Alarm12` |
| 6091 | 14 | `Custom Alarm13` |
| 6092 | 14 | `Custom Alarm14` |
| 6093 | 14 | `Custom Alarm15` |
| 6094 | 14 | `Custom Alarm16` |
| 6095 | 6 | `Z Comp` |
| 6096 | 7 | `(O)Skip` |
| 6097 | 12 | `Close System` |
| 6098 | 7 | `MPG Run` |
| 6099 | 4 | `Lock` |
| 6101 | 9 | `(X)Fast0%` |
| 6102 | 10 | `(Z)Fast50%` |
| 6103 | 11 | `(4)Fast100%` |
| 6104 | 12 | `(5)Tailstock` |
| 6110 | 12 | `(A)T Locking` |
| 6111 | 4 | `Blow` |
| 6112 | 6 | `Tool +` |
| 6113 | 6 | `Tool -` |
| 6114 | 14 | `(0)Chip Remove` |
| 6116 | 11 | `Tool Seting` |
| 6117 | 17 | `01,X Coord Offset` |
| 6118 | 17 | `02,Y Coord Offset` |
| 6119 | 17 | `03,Z Coord Offset` |
| 6120 | 17 | `04,A Coord Offset` |
| 6121 | 17 | `05,B Coord Offset` |
| 6122 | 17 | `06,C Coord Offset` |
| 6123 | 15 | `07,Tool X Coord` |
| 6124 | 15 | `08,Tool Y Coord` |
| 6125 | 15 | `09,Tool Z Coord` |
| 6126 | 15 | `10,Tool A Coord` |
| 6127 | 15 | `11,Tool B Coord` |
| 6128 | 15 | `12,Tool C Coord` |
| 6129 | 19 | `13,Tool Axis Select` |
| 6130 | 30 | `14,ToolChecking RunAfter TCode` |
| 6131 | 23 | `15,ToolChecking Limit X` |
| 6132 | 23 | `16,ToolChecking Limit Y` |
| 6133 | 23 | `17,ToolChecking Limit Z` |
| 6134 | 23 | `18,ToolChecking Limit A` |
| 6135 | 23 | `19,ToolChecking Limit B` |
| 6136 | 23 | `20,ToolChecking Limit C` |
| 6137 | 26 | `21,Tool Search X Direction` |
| 6138 | 26 | `22,Tool Search Y Direction` |
| 6139 | 26 | `23,Tool Search Z Direction` |
| 6140 | 26 | `24,Tool Search A Direction` |
| 6141 | 26 | `25,Tool Search B Direction` |
| 6142 | 26 | `26,Tool Search C Direction` |
| 6143 | 21 | `27,Auto Add Offset En` |
| 6144 | 13 | `28,Tool Speed` |
| 6145 | 22 | `29,Tool Start Using En` |
| 6146 | 18 | `30,Tool X Safe Pos` |
| 6147 | 18 | `31,Tool Y Safe Pos` |
| 6148 | 18 | `32,Tool Z Safe Pos` |
| 6149 | 18 | `33,Tool A Safe Pos` |
| 6150 | 18 | `34,Tool B Safe Pos` |
| 6151 | 18 | `35,Tool C Safe Pos` |
| 6152 | 21 | `36,Tool Safe Check En` |
| 6153 | 33 | `37,Dustproof Appliance Drop Delay` |
| 6154 | 44 | `38,Tool Seting(0-1Reference 1-Not Reference)` |
| 6155 | 8 | `Middle` |
| 6156 | 5 | `Demo7` |
| 6157 | 5 | `Demo6` |
| 6158 | 5 | `Demo5` |
| 6159 | 5 | `Demo4` |
| 6160 | 5 | `Demo3` |
| 6161 | 5 | `Demo2` |
| 6162 | 5 | `Demo1` |
| 6163 | 4 | `Demo` |
| 6164 | 6 | `Output` |
| 6165 | 11 | `Output Test` |
| 6166 | 5 | `Input` |
| 6167 | 10 | `Input Test` |
| 6168 | 7 | `IO Test` |
| 6169 | 7 | `Invalid` |
| 6170 | 4 | `Line` |
| 6171 | 3 | `Arc` |
| 6172 | 6 | `Spline` |
| 6173 | 5 | `GCode` |
| 6174 | 11 | `Demo Screen` |
| 6175 | 20 | `current tool setting` |
| 6176 | 16 | `all tool setting` |
| 6177 | 18 | `three cylinder SPI` |
| 6178 | 4 | `Tool` |
| 6179 | 20 | `home deviation alarm` |
| 6180 | 6 | `EXT IO` |
| 6181 | 21 | `028,British system En` |
| 6182 | 7 | `S Curve` |
| 6183 | 8 | `S Curve2` |
| 6184 | 7 | `Deviate` |
| 6185 | 9 | `Devia Pos` |
| 6186 | 30 | `066,Feed Rate Change Increment` |
| 6187 | 21 | `043,Spindle Auto Open` |
| 6188 | 22 | `044,Spindle Auto Close` |
| 6189 | 23 | `059,Start Out Open 0~31` |
| 6190 | 24 | `060,Start Out Open 32~63` |
| 6191 | 24 | `061,Start Out Open 64~95` |
| 6192 | 26 | `042,Alarm Close Spindle En` |
| 6193 | 14 | `Gear Numerator` |
| 6194 | 16 | `Gear Denominator` |
| 6195 | 17 | `FastSpeed(mm/min)` |
| 6196 | 20 | `StartupSpeed(mm/min)` |
| 6197 | 18 | `Acceleration(Kpps)` |
| 6198 | 18 | `Soft PosLimit+(mm)` |
| 6199 | 18 | `Soft PosLimit-(mm)` |
| 6200 | 22 | `BacklashExpiate(pulse)` |
| 6201 | 15 | `HOME Offset(mm)` |
| 6202 | 7 | `HomeDir` |
| 6203 | 16 | `ZeroReturn Speed` |
| 6204 | 17 | `JOG Speed(mm/min)` |
| 6205 | 21 | `restrain acc (mm/s^2)` |
| 6206 | 17 | `max restrain rate` |
| 6207 | 19 | `ServoAlarmIn ELevel` |
| 6208 | 19 | `ServoResetOut ELeve` |
| 6209 | 15 | `ECZ Home Enable` |
| 6210 | 15 | `ECZ Home ELevel` |
| 6211 | 13 | `Limit  ELevel` |
| 6214 | 15 | `Ext Home ELevel` |
| 6217 | 14 | `Encoder bit(p)` |
| 6218 | 12 | `Reset to 360` |
| 6221 | 21 | `Rolling Display Usage` |
| 6222 | 25 | `G00 Rolling Path Optimize` |
| 6223 | 18 | `Max Acc of X(Kpps)` |
| 6224 | 14 | `Servo Home Dir` |
| 6225 | 15 | `Ext Home Eanble` |
| 6227 | 10 | `HomeSpeed2` |
| 6228 | 10 | `HomeSpeed3` |
| 6229 | 18 | `ScrewPitch Comp EN` |
| 6230 | 22 | `ScrewPitch Spacing(mm)` |
| 6231 | 24 | `ScrewPitch Start Pos(mm)` |
| 6232 | 22 | `ScrewPitch End Pos(mm)` |
| 6233 | 22 | `010,System Main Chanel` |
| 6234 | 8 | `JogSpeed` |
| 6235 | 16 | `-axis first zero` |
| 6236 | 17 | `-axis second zero` |
| 6237 | 16 | `-axis third zero` |
| 6238 | 19 | `PULSE RESET!!!!!!!!` ← YA PERSONALIZADO (original: `System [Reset] Exit`, Alarma 0052) |
| 6239 | 30 | `Spinlde Current overload alarm` |
| 6240 | 30 | `029,additional panel baud rate` |
| 6241 | 12 | `062,Wheel0.1` |
| 6242 | 13 | `063,Wheel0.01` |
| 6243 | 14 | `064,Wheel0.001` |
| 6244 | 11 | `065,X Wheel` |
| 6245 | 11 | `066,Y Wheel` |
| 6246 | 11 | `067,Z Wheel` |
| 6247 | 11 | `068,A Wheel` |
| 6248 | 11 | `069,B Wheel` |
| 6249 | 11 | `070,C Wheel` |
| 6250 | 9 | `075,SCRAM` |
| 6251 | 8 | `074,STOP` |
| 6252 | 11 | `073,STARTUP` |
| 6253 | 21 | `Alarm Quit Line GCode` |
| 6254 | 27 | `7 - direction program limit` |
| 6255 | 27 | `7 + direction program limit` |
| 6256 | 27 | `8 - direction program limit` |
| 6257 | 27 | `8 + direction program limit` |
| 6258 | 27 | `7 - direction machine limit` |
| 6259 | 27 | `7 + direction machine limit` |
| 6260 | 27 | `8 - direction machine limit` |
| 6261 | 27 | `8 + direction machine limit` |
| 6262 | 20 | `7 Sevor driver alarm` |
| 6263 | 20 | `8 Sevor driver alarm` |
| 6265 | 14 | `7 Limit- Input` |
| 6266 | 14 | `7 Limit+ Input` |
| 6267 | 14 | `8 Limit- Input` |
| 6268 | 14 | `8 Limit+ Input` |
| 6269 | 16 | `7 Ext Home Input` |
| 6270 | 16 | `8 Ext Home Input` |
| 6271 | 17 | `7 Servo En Output` |
| 6272 | 17 | `8 Servo En Output` |
| 6273 | 11 | `071,7 Wheel` |
| 6274 | 11 | `072,8 Wheel` |
| 6275 | 22 | `076,X axis Alarm Input` |
| 6276 | 18 | `Y axis Alarm Input` |
| 6277 | 18 | `Z axis Alarm Input` |
| 6278 | 18 | `4 axis Alarm Input` |
| 6279 | 18 | `B axis Alarm Input` |
| 6280 | 18 | `C axis Alarm Input` |
| 6281 | 18 | `7 axis Alarm Input` |
| 6282 | 18 | `8 axis Alarm Input` |
| 6283 | 22 | `077,X axis Reset Input` |
| 6284 | 18 | `Y axis Reset Input` |
| 6285 | 18 | `Z axis Reset Input` |
| 6286 | 18 | `4 axis Reset Input` |
| 6287 | 18 | `B axis Reset Input` |
| 6288 | 18 | `C axis Reset Input` |
| 6289 | 18 | `7 axis Reset Input` |
| 6290 | 18 | `8 axis Reset Input` |
| 6291 | 10 | `ProductSet` |
| 6292 | 26 | `014, System Shutdown Input` |
| 6293 | 27 | `015, System Shutdown Output` |
| 6294 | 24 | `Spindle sampl period(ms)` |
| 6295 | 23 | `Spindle  record time(s)` |
| 6297 | 10 | `Work range` |
| 6298 | 9 | `Axis Mini` |
| 6299 | 8 | `Axis MAX` |
| 6300 | 21 | `More than 8000 reset!` |
| 6302 | 22 | `Save D Disk SPI_AB.CSV` |
| 6303 | 22 | `T Key Spindle sampling` |
| 6304 | 21 | `Macro function error!` |
| 6305 | 25 | `Undefined macro function!` |
| 6306 | 26 | `067, automatic arc enabled` |
| 6307 | 29 | `068, automatic arc value (mm)` |
| 6308 | 32 | `069, coordinate automatic  knife` |
| 6309 | 43 | `070, dual-drive zero maximum deviation (mm)` |
| 6310 | 29 | `Not contain a program number!` |
| 6311 | 28 | `Last not contain procedures!` |
| 6312 | 14 | `Out of memory!` |
| 6313 | 13 | `can not copy!` |
| 6314 | 13 | `can not copy!` |
| 6315 | 15 | `can not delete!` |
| 6316 | 15 | `can not delete!` |
| 6317 | 7 | `Blk Del` |
| 6318 | 9 | `Blk Paste` |
| 6319 | 8 | `Blk Copy` |
| 6320 | 7 | `Row Del` |
| 6321 | 9 | `Row Paste` |
| 6322 | 8 | `Row Copy` |
| 6323 | 58 | `Move the cursor to the end of the block,Then press [EDIT].` |
| 6324 | 58 | `Move the cursor to the end of the block,Then press [EDIT].` |
| 6326 | 9 | `OutputSet` |
| 6327 | 12 | `MachineRange` |
| 6328 | 7 | `AxisMax` |
| 6329 | 7 | `AxisMin` |
| 6378 | 23 | `MacroFuncParameterError` |
| 6379 | 24 | `UndefinedMacroFuncError` |
| 6380 | 24 | `067,ChamferOrAutomaticEn` |
| 6381 | 26 | `068,ChamferOrAutomatic(mm)` |
| 6382 | 24 | `069,CoorToolSettingsMode` |
| 6383 | 16 | `SystemOffInputNO` |
| 6384 | 17 | `SystemOffOutputNO` |
| 6386 | 10 | `Chamfer _C` |
| 6387 | 15 | `Inverted arc _R` |
| 6388 | 19 | `Error inverted arc` |
| 6389 | 11 | `Full screen` |
| 6390 | 8 | `ViewInfo` |
| 6391 | 8 | `circle 1` |
| 6392 | 8 | `circle 2` |
| 6393 | 9 | `circle 3` |
| 6394 | 10 | `Slotting 1` |
| 6395 | 10 | `Slotting 2` |
| 6396 | 7 | `CircleZ` |
| 6397 | 7 | `CircleY` |
| 6398 | 7 | `CircleX` |
| 6399 | 4 | `Move` |
| 6400 | 10 | `Arc slot 1` |
| 6401 | 10 | `Arc slot 2` |
| 6402 | 10 | `Arc slot 3` |
| 6403 | 7 | `Track 1` |
| 6404 | 7 | `Track 2` |
| 6405 | 8 | `tenon 1` |
| 6406 | 7 | `tenon2` |
| 6407 | 10 | `BorderScan` |
| 6408 | 12 | `MacroFuncSel` |
| 6409 | 14 | `[EOB]    [CAN]` |
| 6410 | 13 | `MacroFuncUser` |
| 6411 | 22 | `MultipleThreadStartErr` |
| 6412 | 12 | `FirstInError` |
| 6413 | 13 | `SecondInError` |
| 6414 | 15 | `ToolDebugCancel` |
| 6415 | 17 | `ToolFailPleaCheck` |
| 6416 | 17 | `SetToolNumTooMany` |
| 6417 | 11 | `ToolNoError` |
| 6418 | 12 | `SpindleOtime` |
| 6419 | 12 | `ToolOutOtime` |
| 6420 | 11 | `LoosenOTime` |
| 6421 | 10 | `AContOTime` |
| 6422 | 10 | `BContOTime` |
| 6423 | 13 | `ToolBackOTime` |
| 6424 | 8 | `TNotStop` |
| 6425 | 10 | `ToolCOTime` |
| 6426 | 10 | `CustomErr1` |
| 6427 | 10 | `CustomErr2` |
| 6428 | 10 | `CustomErr3` |
| 6429 | 15 | `GLoadBordScanEn` |
| 6430 | 8 | `InpCycle` |
| 6431 | 17 | `ZSafePosDropSpeed` |
| 6432 | 17 | `ASafePosDropSpeed` |
| 6433 | 11 | `ScramTheNot` |
| 6434 | 7 | `AMT In1` |
| 6435 | 7 | `AMT In2` |
| 6436 | 5 | `0.5ms` |
| 6437 | 3 | `1ms` |
| 6438 | 3 | `2ms` |
| 6439 | 3 | `4ms` |
| 6440 | 27 | `051,Z+axis feed speed limit` |
| 6441 | 27 | `052,A+axis feed speed limit` |
| 6442 | 9 | `AutoAngle` |
| 6443 | 7 | `AutoArc` |
| 6444 | 6 | `DiskIn` |
| 6445 | 31 | `Spindle non-servo spindle error` |
| 6446 | 42 | `not configured servo position signal input` |
| 6447 | 36 | `G7XG8X  Z and R point Location error` |
| 6448 | 32 | `015, spindle zero offset (Angle)` |
| 6449 | 18 | `Load the main code` |
| 6450 | 24 | `TheSecondChannelCodeLoad` |
| 6451 | 20 | `USBConnectionFail...` |
| 6452 | 11 | `USB IDLE...` |
| 6453 | 26 | `USB  WaitFor Connection...` |
| 6454 | 20 | `USB Begin Connect...` |
| 6455 | 31 | `USB Success Connection Began...` |
| 6456 | 16 | `CNC System Start` |
| 6457 | 6 | `path 1` |
| 6458 | 6 | `Path 2` |
| 6459 | 6 | `Path 3` |
| 6460 | 6 | `Path 4` |
| 6461 | 4 | `NULL` |
| 6462 | 12 | `ProgramEdit2` |
| 6463 | 5 | `Edit2` |
| 6464 | 15 | `AbsPosReadFail!` |
| 6465 | 16 | `DeleteDirFile...` |
| 6466 | 21 | `Load GFile To GCMain` |
| 6467 | 17 | `Please Superuser!` |
| 6468 | 18 | `File Exists Cover?` |
| 6469 | 14 | `Load Main Code` |
| 6470 | 38 | `TheSystemLoadSecondChannel GcodeFiles?` |
| 6471 | 22 | `LoadSecondChannelGCode` |
| 6472 | 15 | `Must Superuser!` |
| 6473 | 8 | `Disk(D:)` |
| 6474 | 6 | `Decode` |
| 6475 | 4 | `Copy` |
| 6476 | 36 | `con Greater 9M,No Resource Handling!` |
| 6477 | 35 | `Macro Definition Information Output` |
| 6478 | 49 | `Arc to Angle transition function is not supported` |
| 6479 | 37 | `line or arc transition Angle of error` |
| 6480 | 25 | `X1 - direction soft limit` |
| 6481 | 25 | `X1 + direction soft limit` |
| 6482 | 25 | `Y1 - direction soft limit` |
| 6483 | 25 | `Y1 + direction soft limit` |
| 6484 | 28 | `X1 - direction machine limit` |
| 6485 | 28 | `X1 + direction machine limit` |
| 6486 | 28 | `Y1 - direction machine limit` |
| 6487 | 28 | `Y1 + direction machine limit` |
| 6488 | 21 | `X1 Sevor driver alarm` |
| 6489 | 21 | `Y1 Sevor driver alarm` |
| 6490 | 25 | `Z1 - direction soft limit` |
| 6491 | 25 | `A1 - direction soft limit` |
| 6492 | 25 | `B1 - direction soft limit` |
| 6493 | 25 | `C1 - direction soft limit` |
| 6494 | 25 | `Z1 + direction soft limit` |
| 6495 | 25 | `A1 + direction soft limit` |
| 6496 | 25 | `B1 + direction soft limit` |
| 6497 | 25 | `C1 + direction soft limit` |
| 6498 | 28 | `Z1 - direction machine limit` |
| 6499 | 28 | `A1 - direction machine limit` |
| 6500 | 28 | `B1 - direction machine limit` |
| 6501 | 28 | `C1 - direction machine limit` |
| 6502 | 28 | `Z1 + direction machine limit` |
| 6503 | 28 | `A1 + direction machine limit` |
| 6504 | 28 | `B1 + direction machine limit` |
| 6505 | 28 | `C1 + direction machine limit` |
| 6506 | 21 | `Z1 Sevor driver alarm` |
| 6507 | 21 | `A1 Sevor driver alarm` |
| 6508 | 21 | `B1 Sevor driver alarm` |
| 6509 | 21 | `C1 Sevor driver alarm` |
| 6510 | 23 | `second channel not zero` |
| 6511 | 42 | `Motion library error please restart system` |
| 6512 | 26 | `External emergency stop109` |
| 6513 | 31 | `Motion target pos data error110` |
| 6514 | 31 | `EtherCAT communication fail 118` |
| 6515 | 13 | `Axis alarm119` |
| 6516 | 13 | `SystemAlarm17` |
| 6517 | 13 | `SystemAlarm18` |
| 6518 | 13 | `SystemAlarm19` |
| 6519 | 13 | `SystemAlarm20` |
| 6520 | 13 | `SystemAlarm21` |
| 6521 | 13 | `SystemAlarm22` |
| 6522 | 13 | `SystemAlarm23` |
| 6523 | 13 | `SystemAlarm24` |
| 6524 | 13 | `SystemAlarm25` |
| 6525 | 13 | `SystemAlarm26` |
| 6526 | 13 | `SystemAlarm27` |
| 6527 | 13 | `SystemAlarm28` |
| 6528 | 13 | `SystemAlarm29` |
| 6529 | 13 | `SystemAlarm30` |
| 6530 | 13 | `SystemAlarm31` |
| 6531 | 12 | `memory over!` |
| 6532 | 102 | `The U disk online processing, U disk is drawn, please insert the U drive again to continue processing!` |
| 6533 | 64 | `pfopen global file buffer space is not enough,load file fail\r\n` |
| 6534 | 17 | `First of the jump` |
| 6535 | 14 | `Second of jump` |
| 6536 | 13 | `Third of jump` |
| 6537 | 13 | `[Axis group1]` |
| 6538 | 13 | `[Axis group2]` |
| 6539 | 12 | `Spindle axis` |
| 6540 | 15 | `Spindle channel` |
| 6541 | 14 | `second channel` |
| 6542 | 13 | `third channel` |
| 6543 | 16 | `[Channel GRUNC4]` |
| 6544 | 16 | `[Channel GRUNC5]` |
| 6545 | 16 | `[Channel GRUNC6]` |
| 6546 | 16 | `[Channel GRUNC7]` |
| 6547 | 13 | `[Axis group7]` |
| 6548 | 13 | `[Axis group8]` |
| 6549 | 11 | `machine pos` |
| 6550 | 11 | `Encoder pos` |
| 6551 | 18 | `Origin pos confirm` |
| 6552 | 2 | `No` |
| 6553 | 3 | `Odd` |
| 6554 | 4 | `Even` |
| 6555 | 6 | `No ext` |
| 6556 | 7 | `485 ext` |
| 6557 | 6 | `ET1616` |
| 6558 | 6 | `EM8200` |
| 6559 | 12 | `Main channel` |
| 6560 | 9 | `Channel 1` |
| 6561 | 8 | `Rel type` |
| 6562 | 8 | `Abs type` |
| 6563 | 14 | `Standard Pulse` |
| 6564 | 6 | `QX,QS8` |
| 6565 | 5 | `DO13i` |
| 6566 | 7 | `STEP eM` |
| 6567 | 8 | `QXE-ECAT` |
| 6568 | 9 | `Panasonic` |
| 6569 | 4 | `CPU1` |
| 6570 | 2 | `VM` |
| 6571 | 19 | `005,IO Filter(0~15)` |
| 6572 | 32 | `008,Zero soft limit alarm not en` |
| 6573 | 28 | `009,USB flash disk online en` |
| 6574 | 29 | `077,Abnormal jump config(bit)` |
| 6575 | 21 | `078,Remote IP address` |
| 6576 | 20 | `Negative limit input` |
| 6577 | 19 | `positive limit inpu` |
| 6578 | 17 | `Extend zero input` |
| 6579 | 15 | `Servo en output` |
| 6580 | 17 | `Servo alarm input` |
| 6581 | 18 | `Servo reset output` |
| 6582 | 23 | `Axis corner speed level` |
| 6583 | 22 | `Axis second zero speed` |
| 6584 | 21 | `Axis third zero speed` |
| 6585 | 17 | `Servo device addr` |
| 6586 | 21 | `Axis lap offset(mm/r)` |
| 6587 | 30 | `Abs encoder calibration origin` |
| 6590 | 17 | `Servo stop output` |
| 6591 | 26 | `Servo control pulse output` |
| 6592 | 23 | `rigidity tapping output` |
| 6593 | 19 | `spindle ready input` |
| 6594 | 23 | `spindle must stop input` |
| 6595 | 24 | `spindle zero speed input` |
| 6596 | 19 | `spindle speed input` |
| 6598 | 28 | `010,System axis group config` |
| 6599 | 32 | `014,Import CSV sys config tables` |
| 6600 | 28 | `019,System axis group config` |
| 6604 | 20 | `026,Open screensaver` |
| 6611 | 27 | `003, Spindle max speed(rpm)` |
| 6612 | 27 | `004, Spindle time delay(ms)` |
| 6613 | 18 | `005, Spindle speed` |
| 6614 | 24 | `006, Pause close spindle` |
| 6615 | 28 | `007, Spindle min speed(rpm)` |
| 6616 | 29 | `008, 2 spindle max speed(rpm)` |
| 6617 | 20 | `009, 2 spindle speed` |
| 6618 | 25 | `010, Spindle S invalid En` |
| 6619 | 25 | `011, spindle 2 speed(rpm)` |
| 6620 | 25 | `012, spindle 2 speed(rpm)` |
| 6621 | 25 | `013, spindle 3 speed(rpm)` |
| 6622 | 25 | `014, spindle 4 speed(rpm)` |
| 6623 | 28 | `015, Spindle stop delay(ms)` |
| 6624 | 28 | `016, Alarm closed spindle En` |
| 6625 | 22 | `017, Spindle auto open` |
| 6626 | 22 | `018, Spindle auto stop` |
| 6627 | 25 | `019, Spindle pulse number` |
| 6628 | 27 | `020, Spindle Gear Numerator` |
| 6629 | 29 | `021, Spindle Gear Denominator` |
| 6630 | 22 | `047, Input level 00~31` |
| 6631 | 22 | `048, Input level 32~63` |
| 6632 | 22 | `049, Input level 64~95` |
| 6633 | 23 | `050, Input level 96~127` |
| 6634 | 24 | `051, Input level 128~159` |
| 6635 | 19 | `054, Reset IO 00~31` |
| 6636 | 19 | `055, Reset IO 32~63` |
| 6637 | 19 | `056, Reset IO 64~95` |
| 6638 | 20 | `057, Reset IO 96~127` |
| 6639 | 21 | `058, Reset IO 128~159` |
| 6640 | 21 | `059, Reset IO 160~191` |
| 6641 | 21 | `060, Reset IO 192~223` |
| 6642 | 19 | `061, Reset LED 0~31` |
| 6643 | 20 | `062, Reset LED 32~63` |
| 6644 | 20 | `063, Reset LED 64~95` |
| 6645 | 21 | `064, Reset LED 96~127` |
| 6646 | 22 | `065, Reset LED 128~159` |
| 6647 | 22 | `066, Reset LED 160~191` |
| 6648 | 22 | `067, Reset LED 192~223` |
| 6649 | 27 | `068, Start output open 0~31` |
| 6650 | 28 | `069, Start output open 32~63` |
| 6651 | 29 | `070, Start output open 64~95` |
| 6652 | 29 | `071, Start output open 96~127` |
| 6653 | 30 | `072, Start output open 128~159` |
| 6654 | 30 | `073, Start output open 160~191` |
| 6655 | 30 | `074, Start output open 192~223` |
| 6656 | 18 | `075, Handwheel 0.1` |
| 6657 | 19 | `076, Handwheel 0.01` |
| 6658 | 20 | `077, Handwheel 0.001` |
| 6659 | 26 | `078, Handwheel to choose X` |
| 6660 | 26 | `079, Handwheel to choose Y` |
| 6662 | 26 | `080, Handwheel to choose Z` |
| 6663 | 26 | `081, Handwheel to choose A` |
| 6664 | 26 | `082, Handwheel to choose B` |
| 6665 | 26 | `083, Handwheel to choose C` |
| 6666 | 26 | `084, Handwheel to choose 7` |
| 6667 | 26 | `085, Handwheel to choose 8` |
| 6668 | 23 | `086, Handwheel to start` |
| 6669 | 25 | `087, Handwheel to suspend` |
| 6670 | 20 | `088, Handwheel scram` |
| 6671 | 8 | `MPG1 I56` |
| 6672 | 8 | `MPGX I57` |
| 6673 | 8 | `MPG2 I58` |
| 6674 | 8 | `MPGY I59` |
| 6675 | 8 | `MPG3 I60` |
| 6676 | 8 | `MPGZ I61` |
| 6677 | 8 | `MPGC I62` |
| 6678 | 8 | `MPGA I63` |
| 6679 | 7 | `SCRAM64` |
| 6681 | 153 | `Handwheel mode, When handwheel rotation speed is less than the corresponding list of speed, The current processing ratio for run rate value of the group.` |
| 6682 | 15 | `HandwheelS(rmp)` |
| 6683 | 14 | `Run rate(&lt;100)` |
| 6684 | 14 | `HandwheelParam` |
| 6685 | 12 | `HandwheelRPM` |
| 6686 | 19 | `HandwheelEncoderVal` |
| 6687 | 12 | `HandwheelPos` |
| 6688 | 12 | `(7)Handwheel` |
| 6689 | 6 | `T_FUNC` |
| 6690 | 14 | `Auxiliary info` |
| 6691 | 6 | `M_FUNC` |
| 6692 | 5 | `GRUN7` |
| 6693 | 5 | `GRUN6` |
| 6694 | 5 | `GRUN5` |
| 6695 | 5 | `GRUN4` |
| 6696 | 6 | `path 1` |
| 6697 | 6 | `path 2` |
| 6698 | 6 | `path 3` |
| 6699 | 6 | `path 4` |
| 6700 | 43 | `&gt; Move the knife shaft to the safe place...` |
| 6701 | 50 | `&gt; Z axis safe pos, move to the X, Y coordinates...` |
| 6702 | 50 | `&gt; Y axis safe pos, move to the Z, X cyordinates...` |
| 6703 | 50 | `&gt; X axis safe pos, move to the Y, Z cyordinates...` |
| 6704 | 51 | `&gt;  Move Z axis to start scanning mobile location...` |
| 6705 | 63 | `&gt; Knife shaft scanning in place,In search of knife apparatus...` |
| 6706 | 80 | `&gt; In place of knife instrument signal is detected,In the repeated positioning...` |
| 6707 | 52 | `&gt; Pos is completed,The tool auto back to a safe pos!` |
| 6708 | 15 | `Tool Parameters` |
| 6709 | 18 | `Z-phase offset pos` |
| 6710 | 12 | `Dual channel` |
| 6711 | 6 | `Auxil3` |
| 6712 | 11 | `022,TapMode` |
| 6713 | 14 | `023,TapAdcMode` |
| 6714 | 16 | `024,TapIfEncode?` |
| 6715 | 19 | `025,TapFPGASetSPeed` |
| 6716 | 18 | `026,TapAccFilterEn` |
| 6717 | 14 | `027,TapParamKp` |
| 6718 | 14 | `028,TapParamKi` |
| 6719 | 14 | `029,TapParamKd` |
| 6720 | 20 | `030,TapParamKdFilter` |
| 6721 | 19 | `031,TapParamKilimit` |
| 6722 | 19 | `032,TapParamKdLimit` |
| 6723 | 14 | `033,TapParamK2` |
| 6724 | 15 | `034,TapPreDelay` |
| 6725 | 18 | `035,TapReturnDelay` |
| 6726 | 18 | `036,TapCollectData` |
| 6727 | 16 | `037,TapMaxErrVal` |
| 6728 | 10 | `B zero I04` |
| 6729 | 10 | `B-limitI14` |
| 6730 | 10 | `B+limitI15` |
| 6731 | 4 | `IN24` |
| 6732 | 4 | `IN25` |
| 6733 | 4 | `IN26` |
| 6734 | 4 | `IN27` |
| 6735 | 4 | `IN28` |
| 6736 | 4 | `IN29` |
| 6737 | 4 | `IN30` |
| 6738 | 4 | `IN31` |
| 6739 | 4 | `IN32` |
| 6740 | 4 | `IN33` |
| 6741 | 4 | `IN34` |
| 6742 | 4 | `IN35` |
| 6743 | 4 | `IN36` |
| 6744 | 4 | `IN37` |
| 6745 | 4 | `IN40` |
| 6746 | 4 | `IN43` |
| 6747 | 4 | `IN46` |
| 6748 | 4 | `IN49` |
| 6749 | 4 | `IN52` |
| 6750 | 8 | `SP Z I77` |
| 6751 | 7 | `SP1_I93` |
| 6752 | 7 | `SP2_I94` |
| 6753 | 5 | `OUT24` |
| 6754 | 5 | `OUT25` |
| 6755 | 5 | `OUT26` |
| 6756 | 5 | `OUT27` |
| 6757 | 5 | `OUT28` |
| 6758 | 7 | `X OUT48` |
| 6759 | 7 | `Y OUT49` |
| 6760 | 7 | `Z OUT50` |
| 6761 | 7 | `A OUT51` |
| 6762 | 7 | `B OUT52` |
| 6763 | 7 | `C OUT53` |
| 6764 | 7 | `SP2 O54` |
| 6765 | 7 | `SP4 O55` |
| 6766 | 7 | `SP6 O56` |
| 6767 | 7 | `SP1 O57` |
| 6768 | 7 | `SP3 O58` |
| 6769 | 7 | `SP5 O59` |
| 6770 | 16 | `AbsServoInitFail` |
| 6771 | 5 | `FindS` |
| 6772 | 8 | `ReplaceS` |
| 6773 | 4 | `Find` |
| 6774 | 7 | `Replace` |
| 6775 | 3 | `CAN` |
| 6776 | 7 | `FindErr` |
| 6777 | 10 | `FindS Wait` |
| 6778 | 17 | `Find End Not Find` |
| 6779 | 7 | `XY Plan` |
| 6780 | 7 | `XZ Plan` |
| 6781 | 7 | `XY Plan` |
| 6782 | 7 | `XC Plan` |
| 6783 | 7 | `XZ Plan` |
| 6784 | 7 | `CZ Plan` |
| 6785 | 4 | `ArcC` |
| 6786 | 4 | `ArcR` |
| 6787 | 6 | `CW/CCW` |
| 6788 | 5 | `Speed` |
| 6789 | 9 | `Mac Coord` |
| 6790 | 8 | `SpaceArc` |
| 6791 | 6 | `AStart` |
| 6792 | 7 | `AMiddle` |
| 6793 | 4 | `AEnd` |
| 6794 | 5 | `Speed` |
| 6795 | 16 | `CopyUpTO5120Char` |
| 6796 | 11 | `NewFileFail` |
| 6797 | 11 | `NewFileSucc` |
| 6798 | 14 | `NewFileLoaded?` |
| 6799 | 10 | `ReplaceErr` |
| 6800 | 9 | `RelaceErr` |
| 6801 | 11 | `FindReplEnd` |
| 6802 | 11 | `CanNotTeach` |
| 6803 | 15 | `OutputSignalErr` |
| 6804 | 18 | `SpaceArcModifySucc` |
| 6805 | 18 | `SpaceArcModifySucc` |
| 6806 | 18 | `SpaceArcModifySucc` |
| 6807 | 18 | `SpaceArcModifySucc` |
| 6808 | 18 | `SpaceArcModifySucc` |
| 6809 | 18 | `SpaceArcModifySucc` |
| 6810 | 18 | `SpaceArcModifySucc` |
| 6811 | 18 | `SpaceArcModifySucc` |
| 6812 | 3 | `New` |
| 6813 | 4 | `Jump` |
| 6814 | 4 | `Repl` |
| 6815 | 4 | `Find` |
| 6816 | 3 | `Del` |
| 6817 | 4 | `Save` |
| 6818 | 5 | `Teach` |
| 6819 | 5 | `Modif` |
| 6820 | 5 | `XZArc` |
| 6821 | 5 | `YZArc` |
| 6822 | 5 | `XYArc` |
| 6823 | 6 | `SpaceA` |
| 6824 | 4 | `Line` |
| 6825 | 5 | `Teach` |
| 6826 | 4 | `Repl` |
| 6827 | 11 | `MotionErrNo` |
| 6828 | 15 | `EtherCATErrAxis` |
| 6829 | 14 | `InvalidFunCode` |
| 6830 | 11 | `InvalidAddr` |
| 6831 | 11 | `InvalidData` |
| 6832 | 10 | `ActionFail` |
| 6833 | 10 | `ActionExec` |
| 6834 | 7 | `IsBusy` |
| 6835 | 11 | `FileDataErr` |
| 6836 | 14 | `InvalidNetPath` |
| 6837 | 13 | `DeviceNotResp` |
| 6838 | 13 | `ModbusDataErr` |
| 6839 | 4 | `Time` |
| 6840 | 9 | `Undefined` |
| 6841 | 12 | `OpenFileFail` |
| 6842 | 11 | `BaseAddrErr` |
| 6843 | 11 | `DecimalPErr` |
| 6844 | 14 | `MotionErrParam` |
| 6845 | 13 | `MotionErrData` |
| 6846 | 17 | `MotionErrAxisStop` |
| 6847 | 17 | `MotionErrConflict` |
| 6848 | 20 | `MotionErrModifyParam` |
| 6849 | 18 | `MotionErrInputData` |
| 6850 | 19 | `MotionErrAccDecMode` |
| 6851 | 15 | `MotionErrSCurve` |
| 6852 | 14 | `MotionErrScram` |
| 6853 | 18 | `MotionErrTargetPos` |
| 6854 | 23 | `MotionErrInvalidCommand` |
| 6855 | 15 | `MotionErrFPGARW` |
| 6856 | 17 | `MotionErrFifoFull` |
| 6857 | 17 | `MotionErrFifoFull` |
| 6858 | 13 | `MotionErrRate` |
| 6859 | 17 | `MotionErrFirmware` |
| 6860 | 13 | `MotionErrAxis` |
| 6861 | 17 | `MotionErrEtherCAT` |
| 6862 | 13 | `MotionErrAxis` |
| 6863 | 16 | `MotionErrMailBox` |
| 6864 | 17 | `MotionErrRigidTap` |
| 6865 | 18 | `MotionErrFifoEvent` |
| 6866 | 16 | `MotionErrFPGABus` |
| 6867 | 17 | `MotionErrRigidTap` |
| 6868 | 10 | `CantNotRun` |
| 6869 | 20 | `JumpMemoryPosExecute` |
| 6870 | 2 | `No` |
| 6871 | 18 | `JumpExecuteWait...` |
| 6872 | 22 | `LoadPositioningWait...` |
| 6873 | 10 | `UART0_POLL` |
| 6874 | 10 | `UART1_POLL` |
| 6875 | 10 | `UART3_POLL` |
| 6876 | 8 | `TCP_POLL` |
| 6877 | 8 | `UDP_POLL` |
| 6878 | 2 | `NO` |
| 6879 | 4 | `Dect` |
| 6880 | 2 | `No` |
| 6881 | 3 | `Val` |
| 6882 | 5 | `Servo` |
| 6883 | 6 | `ServoP` |
| 6884 | 8 | `ECATZero` |
| 6885 | 9 | `DELTA_ABS` |
| 6886 | 8 | `YIFE-ABS` |
| 6887 | 6 | `HC_ABS` |
| 6888 | 7 | `EM_ECAT` |
| 6889 | 7 | `HC_ECAT` |
| 6890 | 18 | `AbsoluteEncoderErr` |
| 6891 | 14 | `012,UART0 Baud` |
| 6892 | 11 | `036,LocalIP` |
| 6893 | 21 | `079,ModbusPollTimeOut` |
| 6894 | 16 | `080,ModbusResend` |
| 6895 | 14 | `081,UART3 Baud` |
| 6896 | 12 | `082,LocalIP2` |
| 6897 | 8 | `MacAddr2` |
| 6898 | 14 | `029,UART1 Baud` |
| 6899 | 8 | `TapDelay` |
| 6900 | 12 | `TabCycleTyep` |
| 6901 | 7 | `SCRAM33` |
| 6902 | 42 | `SimulationDataGeneratedWhetherToSimulation` |
| 6903 | 9 | `TapMaxErr` |
| 6904 | 9 | `TapDynErr` |
| 6905 | 8 | `SpindleS` |
| 6906 | 15 | `TapEncoderTotal` |
| 6907 | 16 | `TapSpEncoderVal0` |
| 6908 | 16 | `TapSpEncoderVal1` |
| 6909 | 14 | `TapEncoderVal0` |
| 6910 | 14 | `TapEncoderVal1` |
| 6911 | 12 | `TapFollowErr` |
| 6912 | 25 | `HandwheelModelCan'tDoThis` |
| 6913 | 25 | `G01 Rolling Path Optimize` |
| 6915 | 6 | `F rate` |
| 6916 | 7 | `F pitch` |
| 6918 | 28 | `AbsoluteEncoderTurnsPosition` |
| 6919 | 28 | `AbsoluteEncoderTurnsPositio2` |
| 6920 | 30 | `052, Input Check Level 160~191` |
| 6921 | 30 | `053, Input Check Level 192~223` |
| 6922 | 5 | `POLIH` |
| 6923 | 3 | `YES` |
| 6924 | 2 | `NO` |
| 6925 | 9 | `OPEN[EOB]` |
| 6926 | 9 | `SAVE[EOB]` |
| 6927 | 5 | `RESET` |
| 6928 | 19 | `P select teach file` |
| 6929 | 19 | `teach file not exis` |
| 6930 | 17 | `file load success` |
| 6931 | 21 | `file name less 8 char` |
| 6932 | 23 | `No occupy sys file name` |
| 6933 | 16 | `File open failed` |
| 6934 | 16 | `File save sucess` |
| 6935 | 18 | `paste data cur loc` |
| 6936 | 16 | `clear cur param?` |
| 6937 | 4 | `help` |
| 6938 | 3 | `CAM` |
| 6939 | 5 | `Empty` |
| 6940 | 5 | `paste` |
| 6941 | 4 | `copy` |
| 6942 | 6 | `delete` |
| 6943 | 6 | `SaveAS` |
| 6944 | 4 | `load` |
| 6945 | 5 | `serch` |
| 6946 | 4 | `type` |
| 6947 | 12 | `days Remain:` |
| 6948 | 24 | `switch user mode do this` |
| 6949 | 12 | `01.Rr 1 MC 0` |
| 6950 | 13 | `Type(Rr1,MC0)` |
| 6951 | 12 | `MC Pro teeth` |
| 6952 | 12 | `MC Pro teeth` |
| 6953 | 17 | `03.B angle Pro TS` |
| 6954 | 23 | `TS the MC need machined` |
| 6955 | 14 | `04.Spiral lead` |
| 6956 | 11 | `Spiral lead` |
| 6957 | 21 | `05.X Search pos speed` |
| 6958 | 18 | `X Search pos speed` |
| 6959 | 21 | `06.X pos and feed dis` |
| 6960 | 24 | `X pos and feed point dis` |
| 6961 | 17 | `07.GW start speed` |
| 6962 | 14 | `GW start speed` |
| 6963 | 17 | `08.Grinding speed` |
| 6964 | 3 | `YES` |
| 6965 | 2 | `NO` |
| 6966 | 9 | `OPEN[EOB]` |
| 6967 | 9 | `SAVE[EOB]` |
| 6968 | 5 | `RESET` |
| 6969 | 19 | `P select teach file` |
| 6970 | 19 | `teach file not exis` |
| 6971 | 17 | `file load success` |
| 6972 | 21 | `file name less 8 char` |
| 6973 | 23 | `No occupy sys file name` |
| 6974 | 16 | `File open failed` |
| 6975 | 16 | `File save sucess` |
| 6976 | 18 | `paste data cur loc` |
| 6977 | 16 | `clear cur param?` |
| 6978 | 4 | `help` |
| 6979 | 3 | `CAM` |
| 6980 | 5 | `Empty` |
| 6981 | 5 | `paste` |
| 6982 | 4 | `copy` |
| 6983 | 6 | `delete` |
| 6984 | 6 | `SaveAS` |
| 6985 | 4 | `load` |
| 6986 | 5 | `serch` |
| 6987 | 4 | `type` |
| 6988 | 12 | `days Remain:` |
| 6989 | 24 | `switch user mode do this` |
| 6990 | 11 | `01.RB1 MK 0` |
| 6991 | 14 | `Type(RB1 MK 0)` |
| 6992 | 15 | `02.MC PRO teeth` |
| 6993 | 12 | `MC PRO teeth` |
| 6994 | 20 | `03.B_angle Pro times` |
| 6995 | 18 | `MC Angle Pro times` |
| 6996 | 11 | `04.Spr lead` |
| 6997 | 8 | `Spr lead` |
| 6998 | 19 | `05.X find pos speed` |
| 6999 | 16 | `X find POS speed` |
| 7000 | 23 | `06.Feed dis after X POS` |
| 7001 | 20 | `Feed dis after X POS` |
| 7002 | 17 | `07.GW start speed` |
| 7003 | 14 | `GW start speed` |
| 7004 | 10 | `08.G speed` |
| 7005 | 7 | `G speed` |
| 7006 | 12 | `09.G Ang_Vel` |
| 7007 | 9 | `G Ang_Vel` |
| 7008 | 23 | `10 A Dfl_Ang when Xzero` |
| 7009 | 20 | `A Dfl_Ang when Xzero` |
| 7010 | 6 | `degree` |
| 7011 | 16 | `11.X CB distance` |
| 7012 | 13 | `X CB distance` |
| 7013 | 11 | `12.X GG POS` |
| 7014 | 14 | `X GG Start POS` |
| 7015 | 11 | `13.Y GG POS` |
| 7016 | 14 | `Y GG Start POS` |
| 7017 | 11 | `14.Z GG POS` |
| 7018 | 14 | `Z GG Start POS` |
| 7019 | 11 | `15.A GG POS` |
| 7020 | 14 | `A GG Start POS` |
| 7021 | 17 | `16.SL F_angle Pro` |
| 7022 | 14 | `SL F_angle Pro` |
| 7023 | 11 | `17.GW depth` |
| 7024 | 8 | `GW depth` |
| 7025 | 12 | `18.2GG(Y1N0)` |
| 7026 | 12 | `MC need 2GG?` |
| 7027 | 4 | `Y1N0` |
| 7028 | 20 | `19.2GG A OffsetAngle` |
| 7029 | 17 | `2GG A OffsetAngle` |
| 7030 | 12 | `20.2GG Y POS` |
| 7031 | 9 | `2GG Y POS` |
| 7032 | 12 | `21.2GG depth` |
| 7033 | 9 | `2GG depth` |
| 7034 | 16 | `22.X G angle pos` |
| 7035 | 15 | `X G agl Sta_pos` |
| 7036 | 14 | `23.Y G agl pos` |
| 7037 | 15 | `Y G agl sta_pos` |
| 7038 | 16 | `24.Z G angle pos` |
| 7039 | 17 | `Z G angle Sta_pos` |
| 7040 | 16 | `25.A G angle pos` |
| 7041 | 17 | `A G angle Sta_pos` |
| 7042 | 18 | `26.B_Corner pro SL` |
| 7043 | 15 | `B_Corner pro SL` |
| 7044 | 19 | `27. Agl depth of GW` |
| 7045 | 15 | `Agl depth of GW` |
| 7046 | 17 | `28.2G Agl A O_Agl` |
| 7047 | 14 | `2G Agl A O_Agl` |
| 7048 | 15 | `29.2G Agl Z POS` |
| 7049 | 12 | `2G Agl Z POS` |
| 7050 | 20 | `30.2GG Agl Pro depth` |
| 7051 | 17 | `2GG Agl Pro depth` |
| 7052 | 17 | `31. CM return dis` |
| 7053 | 14 | `CM return dis` |
| 7054 | 14 | `32 UseThimble?` |
| 7055 | 11 | `UseThimble?` |
| 7056 | 14 | `33.Ret G X Len` |
| 7057 | 11 | `Ret G X Len` |
| 7058 | 4 | `Fast` |
| 7059 | 16 | `34.Ret GG Z high` |
| 7060 | 13 | `Ret GG Z high` |
| 7061 | 16 | `35.Ret  GG Speed` |
| 7062 | 13 | `Ret  GG Speed` |
| 7063 | 17 | `36.GG taper depth` |
| 7064 | 14 | `GG taper depth` |
| 7065 | 19 | `37.G Agl TaperDepth` |
| 7066 | 16 | `G Agl TaperDepth` |
| 7067 | 8 | `38.Feed?` |
| 7068 | 4 | `Feed` |
| 7069 | 7 | `39.Knif` |
| 7070 | 4 | `Knif` |
| 7071 | 6 | `40.GG?` |
| 7072 | 3 | `GG?` |
| 7073 | 14 | `41.G B_corner?` |
| 7074 | 11 | `G B_corner?` |
| 7075 | 16 | `42.G 2 B_corner?` |
| 7076 | 13 | `G 2 B_corner?` |
| 7077 | 8 | `43.Unlod` |
| 7078 | 6 | `Unload` |
| 7079 | 11 | `1.CM Rel Dt` |
| 7080 | 9 | `CM Rel Dt` |
| 7081 | 6 | `second` |
| 7082 | 14 | `2.Flap lift Dt` |
| 7083 | 10 | `Flap up Dt` |
| 7084 | 16 | `3.FeedRack go Dt` |
| 7085 | 14 | `FeedRack go Dt` |
| 7086 | 16 | `5.FeedBack up Dt` |
| 7087 | 14 | `FeedBack up Dt` |
| 7088 | 11 | `5.TMC TM Dt` |
| 7089 | 9 | `TMC TM Dt` |
| 7090 | 12 | `6.CM C CM Dt` |
| 7091 | 10 | `CM C CM Dt` |
| 7092 | 14 | `7.TM C back Dt` |
| 7093 | 12 | `TM C back Dt` |
| 7094 | 12 | `8.FR fall Dt` |
| 7095 | 10 | `FR fall Dt` |
| 7096 | 12 | `9.FR back Dt` |
| 7097 | 10 | `FR back Dt` |
| 7098 | 14 | `10.Pos C go Dt` |
| 7099 | 11 | `Pos C go Dt` |
| 7100 | 16 | `11.Pos C back Dt` |
| 7101 | 13 | `Pos C back Dt` |
| 7102 | 17 | `12.fender drop Dt` |
| 7103 | 14 | `fender drop Dt` |
| 7104 | 15 | `13.fender up Dt` |
| 7105 | 14 | `14.CM C Rel Dt` |
| 7106 | 11 | `CM C Rel Dt` |
| 7107 | 13 | `15.UL C UL Dt` |
| 7108 | 10 | `UL C UL Dt` |
| 7109 | 11 | `IN00 X zero` |
| 7110 | 11 | `IN00 Y zero` |
| 7111 | 11 | `IN00 Z zero` |
| 7112 | 11 | `IN00 A zero` |
| 7113 | 8 | `IN04 EMS` |
| 7114 | 12 | `IN05 Ext sta` |
| 7115 | 12 | `IN06 Ext sto` |
| 7116 | 14 | `IN07 M detct S` |
| 7117 | 12 | `IN08 FR Back` |
| 7118 | 15 | `IN09 TM Place S` |
| 7119 | 12 | `IN10 X Pso S` |
| 7120 | 12 | `IN16 X-limit` |
| 7121 | 12 | `IN17 X+limit` |
| 7122 | 12 | `IN18 Y-limit` |
| 7123 | 12 | `IN19 Y+limit` |
| 7124 | 12 | `IN20 Z-limit` |
| 7125 | 12 | `IN21 Z+limit` |
| 7126 | 12 | `IN22 A-limit` |
| 7127 | 12 | `IN23 A+limit` |
| 7128 | 11 | `OUT00 Spi +` |
| 7129 | 11 | `OUT02 Spi -` |
| 7130 | 15 | `OUT02 FR A/R F0` |
| 7131 | 15 | `OUT03 FR U/D F1` |
| 7132 | 12 | `OUT04 TMC F2` |
| 7133 | 12 | `OUT05 CMC F3` |
| 7134 | 12 | `OUT06 ULC F4` |
| 7135 | 8 | `OUT07 FC` |
| 7136 | 13 | `OUT08 coolant` |
| 7137 | 11 | `OUT09 Pos C` |
| 7138 | 11 | `OUT10 UL CV` |
| 7139 | 9 | `PARAM SET` |
| 7140 | 7 | `descrip` |
| 7141 | 5 | `unit:` |
| 7142 | 6 | `range:` |
| 7143 | 23 | `SW(infeed set)set PARAM` |
| 7144 | 2 | `MC` |
| 7145 | 9 | `Act PARAM` |
| 7146 | 3 | `Dly` |
| 7147 | 7 | `Act Dly` |
| 7148 | 4 | `Test` |
| 7149 | 12 | `RET GG X Len` |
| 7150 | 16 | `34.RET GG Z high` |
| 7151 | 13 | `RET GG Z high` |
| 7152 | 15 | `35.RET GG Speed` |
| 7153 | 15 | `35.RET GG Speed` |
| 7154 | 17 | `36.GG Taper depth` |
| 7155 | 14 | `GG Taper depth` |
| 7156 | 11 | `A6 COM fail` |
| 7157 | 29 | `SYS use time end !need unlock` |
| 7158 | 26 | `UART1/UART2/UART3 only one` |
| 7159 | 26 | `Data Backup,Auto overwrite` |
| 7160 | 19 | `Data backup success` |
| 7161 | 16 | `Data backup fail` |
| 7162 | 14 | `Data recovery?` |
| 7163 | 23 | `sucessful! restart SYS?` |
| 7164 | 19 | `Data recovery fail!` |
| 7165 | 26 | `Data Backup,Auto overwrite` |
| 7166 | 24 | `Init PARAM from CSV file` |
| 7167 | 12 | `Init success` |
| 7168 | 17 | `Save PARAM to CSV` |
| 7169 | 12 | `SAVE SUCCESS` |
| 7170 | 9 | `SAVE FAIL` |
| 7171 | 13 | `read CSV fail` |
| 7172 | 31 | `items number for csv incorrect!` |
| 7173 | 26 | `Sure CSV index are correct` |
| 7174 | 36 | `Init fail!drive selection correct!!!` |
| 7175 | 15 | `save ,wait.....` |
| 7176 | 14 | `Init, wait....` |
| 7177 | 13 | `5axis G PARAM` |
| 7178 | 12 | `update servo` |
| 7179 | 6 | `X axis` |
| 7180 | 6 | `Export` |
| 7181 | 6 | `Y-axis` |
| 7182 | 6 | `Z-axis` |
| 7183 | 6 | `A-axis` |
| 7184 | 6 | `B-axis` |
| 7185 | 6 | `C-axis` |
| 7186 | 6 | `7-axis` |
| 7187 | 6 | `8-axis` |
| 7188 | 6 | `9-axis` |
| 7189 | 7 | `10-axis` |
| 7190 | 7 | `11-axis` |
| 7191 | 7 | `12-axis` |
| 7192 | 13 | `12-axis PARAM` |
| 7193 | 13 | `11-axis PARAM` |
| 7194 | 13 | `10-axis PARAM` |
| 7195 | 12 | `9-axis PARAM` |
| 7196 | 12 | `8-axis PARAM` |
| 7197 | 12 | `7-axis PARAM` |
| 7198 | 12 | `C-axis PARAM` |
| 7199 | 12 | `B-axis PARAM` |
| 7200 | 12 | `A-axis PARAM` |
| 7201 | 12 | `Z-axis PARAM` |
| 7202 | 12 | `Y-axis PARAM` |
| 7203 | 12 | `X-axis PARAM` |
| 7204 | 7 | `X Param` |
| 7205 | 9 | `open lock` |
| 7206 | 11 | `open w lock` |
| 7207 | 11 | `high 32 bit` |
| 7208 | 12 | `Clbt H 32bit` |
| 7209 | 2 | `A6` |
| 7210 | 15 | `servo type erro` |
| 7211 | 12 | `FAIL ,reload` |
| 7212 | 23 | `delet file and save it` |
| 7213 | 22 | `delet file and save it` |
| 7214 | 12 | `save success` |
| 7215 | 21 | `022,oilpump timing on` |
| 7216 | 26 | `023,oilpump hold time(sec)` |
| 7217 | 24 | `024,oilpump ctr freq(Hz)` |
| 7218 | 15 | `004,data backup` |
| 7219 | 16 | `005,data recovey` |
| 7220 | 17 | `38, the knife way` |
| 7221 | 12 | `Config PARAM` |
| 7222 | 9 | `start I62` |
| 7223 | 8 | `STOP I64` |
| 7224 | 7 | `EMS I65` |
| 7225 | 16 | `Saxis Zphase I76` |
| 7226 | 22 | `ECAT_WKC R error count` |
| 7227 | 22 | `ECAT_WKC W error count` |
| 7228 | 5 | `DEBUG` |
| 7229 | 23 | `C workpiece tool offset` |
| 7230 | 27 | `CurTool C WP Len compensate` |
| 7231 | 9 | `Panasonic` |
| 7232 | 5 | `PARAM` |
| 7233 | 8 | `Cur Page` |
| 7234 | 2 | `TY` |
| 7235 | 2 | `PE` |
| 7236 | 33 | `056Double G Start close meanwhile` |
| 7237 | 21 | `059,G91 to G90 enable` |
| 7238 | 22 | `085,B-feed speed Limit` |
| 7239 | 25 | `030,Air alarm input port` |
| 7240 | 27 | `089,Ext start 1 input port` |
| 7241 | 27 | `090,Ext start 2 input port` |
| 7242 | 27 | `091,Ext pause 1 input port` |
| 7243 | 26 | `092,Ext pause 2 input port` |
| 7244 | 27 | `093,Ext reset 1 input port` |
| 7245 | 26 | `094,Ext reset 1 input port` |
| 7246 | 27 | `095,Run light output 1port` |
| 7247 | 27 | `096,stop light output 2port` |
| 7248 | 6 | `Chute1` |
| 7249 | 6 | `Chute2` |
| 7250 | 5 | `hole1` |
| 7251 | 5 | `hole2` |
| 7252 | 5 | `MR XY` |
| 7253 | 5 | `MR XZ` |
| 7254 | 5 | `MR YZ` |
| 7255 | 6 | `In_arc` |
| 7256 | 5 | `P_arc` |
| 7257 | 27 | `Real time error of tapping:` |
| 7258 | 5 | `Wear` |
| 7259 | 28 | `Modbus ext_output comu alarm` |
| 7260 | 28 | `Modbus ext_intput comu alarm` |
| 7261 | 21 | `Modbus Commu abnormal` |
| 7262 | 9 | `syn error` |
| 7263 | 16 | `Spi follow error` |
| 7264 | 19 | `Slave Followe error` |
| 7265 | 10 | `All errors` |
| 7266 | 17 | `Num turns encoder` |
| 7267 | 17 | `origin calibrat` |
| 7268 | 1 | `T` |
| 7269 | 5 | `index` |
| 7270 | 3 | `sin` |
| 7468 | 6 | `IN05` |
| 7469 | 6 | `IN06` |
| 7470 | 6 | `IN07` |
| 7471 | 6 | `IN08` |
| 7472 | 6 | `IN09` |
| 7473 | 6 | `IN10` |
| 7474 | 6 | `IN11` |
| 7475 | 6 | `IN12` |
| 7476 | 6 | `IN13` |
| 7477 | 6 | `IN14` |
| 7478 | 6 | `IN15` |
| 7508 | 5 | `OUT02` |
| 7509 | 5 | `OUT03` |
| 7510 | 5 | `OUT04` |
| 7511 | 5 | `OUT05` |
| 7512 | 5 | `OUT06` |
| 7513 | 5 | `OUT07` |
| 7514 | 5 | `OUT08` |
| 7515 | 5 | `OUT09` |
| 7516 | 5 | `OUT10` |
| 7517 | 5 | `OUT11` |
| 7518 | 5 | `OUT12` |
| 7519 | 5 | `OUT13` |
| 7520 | 5 | `OUT14` |
| 7521 | 5 | `OUT15` |
| 7522 | 5 | `OUT16` |
| 7523 | 5 | `OUT17` |
| 7524 | 5 | `OUT18` |
| 7525 | 5 | `OUT19` |
| 7526 | 5 | `OUT20` |
| 7527 | 5 | `OUT21` |
| 7528 | 5 | `OUT22` |
| 7529 | 5 | `OUT23` |
| 7530 | 6 | `XOUT24` |
| 7531 | 6 | `YOUT25` |
| 7532 | 6 | `ZOUT26` |
| 7533 | 6 | `AOUT27` |
| 7536 | 6 | `D A` |
| 7556 | 3 | `MDI` |
| 7904 | 1 | `X` |
| 7905 | 1 | `Y` |
| 7906 | 1 | `Z` |
| 7907 | 1 | `A` |
| 8033 | 7 | `Reserve` |
| 8039 | 41 | `038,- - - - - - - - - - - - - - - - - - -` |
| 8049 | 1 | `R` |
| 8050 | 1 | `T` |
| 8194 | 6 | `(9)M01` |
| 8200 | 5 | `(F)F0` |
| 8201 | 5 | `(Z)F1` |
| 8202 | 5 | `(1)F2` |
| 8203 | 5 | `(2)F3` |
| 8204 | 5 | `(3)F4` |
| 8285 | 1 | `B` |
| 8286 | 1 | `C` |
