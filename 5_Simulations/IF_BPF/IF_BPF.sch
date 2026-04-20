<QucsStudio Schematic 5.8>
<Properties>
View=94.7485,22.826,1316.72,704.503,1,177,4
Grid=10,10,1
DataSet=*.dat
DataDisplay=*.dpl
OpenDisplay=1
showFrame=0
FrameText0=Title \n @PATH@@FILE@
FrameText1=Drawn By:
FrameText2=Date: @DATE@
FrameText3=Revision:
</Properties>
<Symbol>
</Symbol>
<Components>
Pac P1 1 570 250 18 -26 0 "1"1"50"1"0 dBm"0"1 GHz"0"26.85"0"con_2"0
GND * 1 570 280 0 0 0
L L1 1 700 250 8 -26 1 "28.88nH"1"0"0""0"inductor_1mH"0
C C1 1 670 250 -8 46 1 "40.6pF"1"0"0""0"neutral"0"SMD0603"0
GND * 1 700 280 0 0 0
L L2 1 810 170 -26 -44 0 "245.1nH"1"0"0""0"inductor_1mH"0
C C2 1 750 170 -26 10 0 "4.785pF"1"0"0""0"neutral"0"SMD0603"0
L L3 1 840 250 8 -26 1 "11.96nH"1"0"0""0"inductor_1mH"0
C C3 1 810 250 -8 46 1 "98.03pF"1"0"0""0"neutral"0"SMD0603"0
GND * 1 840 280 0 0 0
L L4 1 950 170 -26 -44 0 "101.5nH"1"0"0""0"inductor_1mH"0
C C4 1 890 170 -26 10 0 "11.55pF"1"0"0""0"neutral"0"SMD0603"0
Pac P2 1 980 250 18 -26 0 "2"1"50"1"0"0"1 GHz"0"26.85"0"con_2"0
GND * 1 980 280 0 0 0
.SP SP1 1 590 410 0 9 0 "log"1"12MHz"1"1.8GHz"1"500"1"no"0"1"0"2"0"none"0
</Components>
<Wires>
570 170 570 220
570 170 700 170
700 170 700 220
840 170 840 220
980 170 980 220
700 170 720 170
670 220 700 220
670 280 700 280
840 170 860 170
810 220 840 220
810 280 840 280
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
Text 750 350 16 #000000 0 band-pass filter, 120MHz...180MHz \n 4^{th} order Butterworth , PI-type, \n impedance 50 \\Omega
</Paintings>
