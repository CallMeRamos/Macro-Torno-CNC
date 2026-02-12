O0001
IF[#400==0] M30
IF [[#400 <= 0] || [#400>12]]
{
IF [#11028==1] THEN #3000=1(系统最大刀设置错误)
IF [#11028==0] THEN #3000=1(The maximum error knife setting system)
}
IF [[#200 > #400] || [#200 <=0 ]]
{
IF [#11028==1] THEN #3000=1(T代码刀号错误)
IF [#11028==0] THEN #3000=1(T tool number error code)
}

(TP4=IN5, TP3=IN6, TP2=IN7, TP1=IN8)
(#200 target tool , #4120 current tool)
#1422=1 (Brake release)
#1423=1 (Turret unclamp)
G4X1
M88P23L0Q5000 (Unclamp checking)
M88P21L1Q5000 (Unclamp checking)
M88P22L1Q5000 (Brake release checking)

(Calculate shortest path considering circular nature of turret)
#201=#4120/100 (Current tool position)
#202=#200-#201 (Direct distance)

(Handle wrap-around for shortest path)
IF[#202>6] THEN #202=#202-12
IF[#202<-6] THEN #202=#202+12

(Determine rotation direction based on shortest path)
IF[#202>0]
{
#33=1 (CW Mark)
#1402=1
}
ELSE
{
#33=-1 (CCW Mark)
#1403=1
}

N11
N12
#100=FIX[#4120/100]
WHILE[#200!=#100]DO88
M88P15L1Q5000
M88P15L0Q5000
#100=#100+#33
IF[#100==0]
{
#100=12
}
IF[#100==13]
{
#100=1
}
END88

#1402=0 (CW Off)
#1403=0 (CCW Off)
#1423=0 (Turret clamp)
G04 P1000 (delay 1500 ms)
#1422=0 (Brake OFF)

M88P23L0Q5000 (clamp checking)
M88P21L1Q5000 (clamp checking)
M88P22L0Q5000 (Brake off checking)


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

IF[#200==8]
{
#8=0
WHILE[#7<=8000]DO8
IF[ [#1005==0]&&[#1006==1]&&[#1007==1]&&[#1008==1] ]GOTO8
G4P10
#8=#8+10
END8
}
N8

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



M30
