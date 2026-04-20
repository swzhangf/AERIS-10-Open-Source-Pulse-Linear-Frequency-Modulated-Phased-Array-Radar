<QucsStudio Schematic 5.8>
<Properties>
View=46.9285,-48.9912,1171.72,565.529,1.16667,175,86
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
.TR TR1 1 830 400 0 9 0 "lin"0"0"0"10 µs"1"5020"1"Trapezoidal"0"1e-16"0"500"0"0.001"0"1 µA"0"yes"0"none"0
C C4 1 500 250 17 -26 1 "32.79pF"1"0"0""0"neutral"0"SMD0603"0
C C5 1 640 250 17 -26 1 "106.1pF"1"0"0""0"neutral"0"SMD0603"0
C C6 1 780 250 17 -26 1 "32.79pF"1"0"0""0"neutral"0"SMD0603"0
L L3 1 570 170 -26 10 0 "107.3nH"1"0"0""0"inductor_1mH"0
L L4 1 710 170 -26 10 0 "107.3nH"1"0"0""0"inductor_1mH"0
R R2 1 440 170 -26 15 0 "25 Ω"1"26.85"0"european"0"SMD0603"0
R R3 1 440 300 -26 15 0 "25 Ω"1"26.85"0"european"0"SMD0603"0
L L5 1 570 300 -26 10 0 "107.3nH"1"0"0""0"inductor_1mH"0
L L6 1 710 300 -26 10 0 "107.3nH"1"0"0""0"inductor_1mH"0
GND * 1 290 240 0 0 0
R R1 1 900 240 15 -26 1 "50 Ω"1"26.85"0"european"0"SMD0603"0
Vfile V1 1 370 210 18 -26 0 "multi_ramp_stairs.csv"0"out.Vt"0"hold"0"yes"0"1"0"0"0
Vfile V2 1 370 270 18 -26 0 "multi_ramp_stairs.csv"0"out.Vt"0"hold"0"yes"0"1"0"0"0
</Components>
<Wires>
470 170 500 170
370 170 410 170
370 170 370 180
500 170 500 220
640 170 640 220
780 170 780 220
500 170 540 170
600 170 640 170
640 170 680 170
740 170 780 170
900 170 900 210
780 170 900 170
370 300 410 300
470 300 500 300
600 300 640 300
740 300 780 300
900 270 900 300
780 300 900 300
780 280 780 300
640 300 680 300
640 280 640 300
500 300 540 300
500 280 500 300
290 240 370 240
370 300 370 300 "Vin_N" 300 330 0 ""
370 170 370 170 "Vin_P" 400 120 0 ""
900 170 900 170 "Vout_P" 930 120 0 ""
900 300 900 300 "Vout_N" 930 300 0 ""
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
Text 430 350 16 #000000 0 low-pass filter, 60MHz cutoff \n 5^{th} order Butterworth , PI-type, \n impedance 50 \\Omega
</Paintings>
