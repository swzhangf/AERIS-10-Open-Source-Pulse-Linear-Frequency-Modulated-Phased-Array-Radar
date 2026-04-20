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
Pac P1 1 250 330 18 -26 0 "1"1"50"1"0 dBm"0"1 GHz"0"26.85"0"con_2"0
GND * 1 250 360 0 0 0
GND * 1 290 100 0 0 4
MLIN MS1 1 290 130 10 -25 1 "Sub1"0"817µm"1"4.122mm"1"26.85"0
MLIN MS2 1 320 200 -26 15 0 "Sub1"0"173µm"1"4.47mm"1"26.85"0
GND * 1 390 100 0 0 4
MLIN MS3 1 390 130 10 -25 1 "Sub1"0"1.884mm"1"3.99mm"1"26.85"0
MLIN MS4 1 420 200 -26 15 0 "Sub1"0"143.3µm"1"4.514mm"1"26.85"0
GND * 1 490 100 0 0 4
MLIN MS5 1 490 130 10 -25 1 "Sub1"0"1.884mm"1"3.99mm"1"26.85"0
MLIN MS6 1 520 200 -26 15 0 "Sub1"0"173µm"1"4.47mm"1"26.85"0
GND * 1 590 100 0 0 4
MLIN MS7 1 590 130 10 -25 1 "Sub1"0"817µm"1"4.122mm"1"26.85"0
Pac P2 1 630 330 18 -26 0 "2"1"50"1"0"0"1 GHz"0"26.85"0"con_2"0
GND * 1 630 360 0 0 0
.SP SP1 1 260 460 0 9 0 "lin"1"450MHz"1"45GHz"1"496"1"no"0"1"0"2"0"none"0
SUBST Sub1 1 440 450 -30 24 0 "3.48"1"102µm"1"35µm"1"0.001"1"2.4e-08"1"0"0"Metal"0"Hammerstad"0"Kirschning"0
</Components>
<Wires>
250 200 250 300
630 200 630 300
250 200 290 200
290 160 290 200
350 200 390 200
390 160 390 200
450 200 490 200
490 160 490 200
550 200 590 200
590 200 630 200
590 160 590 200
</Wires>
<Diagrams>
</Diagrams>
<Paintings>
Text 540 400 16 #000000 0 band-pass filter, 9GHz...12GHz \n 4^{th} order Butterworth  \n impedance 50 \\Omega
</Paintings>
