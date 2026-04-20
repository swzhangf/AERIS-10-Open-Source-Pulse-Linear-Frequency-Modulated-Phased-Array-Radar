<QucsStudio Schematic 5.8>
<Properties>
View=0,0,800,800,1,0,0
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
Pac P1 1 200 330 18 -26 0 "1"1"50"1"0 dBm"0"1 GHz"0"26.85"0"con_2"0
GND * 1 200 360 0 0 0
GND * 1 240 100 0 0 4
MLIN MS1 1 240 130 10 -25 1 "Sub1"0"1.048mm"1"4.177mm"1"26.85"0
MLIN MS2 1 270 200 -26 15 0 "Sub1"0"173µm"1"4.579mm"1"26.85"0
GND * 1 340 100 0 0 4
MLIN MS3 1 340 130 10 -25 1 "Sub1"0"2.358mm"1"4.061mm"1"26.85"0
MLIN MS4 1 370 200 -26 15 0 "Sub1"0"143.3µm"1"4.625mm"1"26.85"0
GND * 1 440 100 0 0 4
MLIN MS5 1 440 130 10 -25 1 "Sub1"0"2.358mm"1"4.061mm"1"26.85"0
MLIN MS6 1 470 200 -26 15 0 "Sub1"0"173µm"1"4.579mm"1"26.85"0
GND * 1 540 100 0 0 4
MLIN MS7 1 540 130 10 -25 1 "Sub1"0"1.048mm"1"4.177mm"1"26.85"0
Pac P2 1 580 330 18 -26 0 "2"1"50"1"0"0"1 GHz"0"26.85"0"con_2"0
GND * 1 580 360 0 0 0
.SP SP1 1 210 460 0 9 0 "lin"1"450MHz"1"45GHz"1"496"1"no"0"1"0"2"0"none"0
SUBST Sub1 1 390 450 -30 24 0 "3.48"1"102µm"1"35µm"1"0.001"1"2.4e-08"1"0"0"Metal"0"Hammerstad"0"Kirschning"0
</Components>
<Wires>
200 200 200 300
580 200 580 300
200 200 240 200
240 160 240 200
300 200 340 200
340 160 340 200
400 200 440 200
440 160 440 200
500 200 540 200
540 200 580 200
540 160 540 200
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
Text 490 400 16 #000000 0 band-pass filter, 9GHz...11.5GHz \n 4^{th} order Butterworth  \n impedance 50 \\Omega
</Paintings>
