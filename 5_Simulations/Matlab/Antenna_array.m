%This Code was Written By Nemeen Shah
%Subscribe to My YouTube Channel: https://Youtube.com/NematicsLab
%Size of PCB
pcbThickness = 1.6e-3;  %1.6mm
pcbLength = 152.4e-3;   %152.4mm or 6inch
pcbWidth = 101.6e-3;    %101.6mm 0r 4inch
%Specifying Material of PCB
pcbMaterial = 'FR4';
pcbEpsilonR = 4.4;
%Creating dielectic Material
d = dielectric(pcbMaterial); 
d.EpsilonR = pcbEpsilonR;
d.Thickness = pcbThickness;
AntennaPlane=antenna.Rectangle('Length',0.5e-2,'Width',5e-2,'Center',[0, 0]); %Creating Feed Plane of Antenna 
GndPlane = antenna.Rectangle('Length',pcbLength,'Width',pcbWidth); %Creating Ground Plane of Antenna
%Creating Different Shapes of antenna
Rec = antenna.Rectangle('Length',10e-2,'Width',2e-2,'Center',[0,-20e-3]);
Rec1 = antenna.Rectangle('Length',6e-2,'Width',2e-2,'Center',[0,20e-3]);
%%Creating PCB Stack
p = pcbStack;
p.Name = 'Strip-fed slot';
p.BoardShape = GndPlane;
p.BoardThickness = pcbThickness;
p.Layers = {AntennaPlane,d,GndPlane}; %[x Cordinate,y Cordinate,startLayer stopLayer]
p.FeedLocations = [0,(-pcbWidth/2)+6e-2,1,3];
 
%Adding all different shapes of antenna
AntennaPlane = AntennaPlane + Rec + Rec1;
p.Layers = {AntennaPlane,d,GndPlane};
%Plotting Different patterns and graphs
figure(1);
show(p); %Display Antenna 
figure(2);
pattern(p,1.943e9); %Display Radiation Pattern at 1.943GHZ
figure(3);
impedance(p,1.6e9:2e7:2.2e9); %Display Impedance Graph from 1.6GHz to 2.2GHz
freq = linspace(1.6e9, 2.2e9, 50);  % Creating Frequency Vector
s = sparameters(p,freq,50);     % Calalculate S11 for all frequencys
figure(4);
rfplot(s);%Diplay S11 Plot