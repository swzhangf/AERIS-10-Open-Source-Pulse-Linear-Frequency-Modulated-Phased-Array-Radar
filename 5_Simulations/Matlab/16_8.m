%Size of PCB
pcbThickness = 0.578e-3;  
pcbLength = 200e-3;   
pcbWidth = 200e-3; 

f = 10.5e+9;
c = 3e+8;
lambda = c/f;
 
Length_patch = 8.76e-3;
Width_patch = 9.545e-3;
dist_patch = lambda/2;
feeder_width = 0.94e-3;
  
%Specifying Material of PCB
pcbEpsilonR = 3.48;
%Creating dielectic Material
d = dielectric(Name="RO4350B",EpsilonR=pcbEpsilonR,LossTangent=0.003,Thickness=pcbThickness); 
GndPlane = antenna.Rectangle('Length',pcbLength,'Width',pcbWidth); %Creating Ground Plane of Antenna
%Creating Different Shapes of antenna 
Rec1 = antenna.Rectangle('Length',dist_patch-Length_patch,'Width',feeder_width,'Center',[0,(dist_patch-Length_patch)/2]); %feeder
Rec2 = antenna.Rectangle('Length',Length_patch,'Width',Width_patch,'Center',[0,(dist_patch-Length_patch)+(Length_patch)/2]); %patch

for i=1:1:16
	for j=1:1:8
		Rec1 = Rec1 + antenna.Rectangle('Length',dist_patch-Length_patch,'Width',feeder_width,'Center',[i-1,j*(dist_patch)+(dist_patch-Length_patch)/2]);
		Rec2 = Rec2 + antenna.Rectangle('Length',Length_patch,'Width',Width_patch,'Center',[i-1,j*(dist_patch)+(dist_patch-Length_patch)+(Length_patch)/2]);
	end
end

%Adding all different shapes of antenna
AntennaPlane =  Rec1 + Rec2;

%%Creating PCB Stack
p = pcbStack;
p.Name = 'Strip-fed slot';
p.BoardShape = GndPlane;
p.BoardThickness = pcbThickness;
p.Layers = {AntennaPlane,d,GndPlane}; %[x Cordinate,y Cordinate,startLayer stopLayer]
p.FeedLocations = [0,0,1,3;0,dist_patch,1,3;0,dist_patch*2,1,3;0,dist_patch*3,1,3;0,dist_patch*4,1,3;0,dist_patch*5,1,3;0,dist_patch*6,1,3;0,dist_patch*7,1,3;0,dist_patch*8,1,3;0,dist_patch*9,1,3;0,dist_patch*10,1,3;0,dist_patch*11,1,3;0,dist_patch*12,1,3;0,dist_patch*13,1,3;0,dist_patch*14,1,3;0,dist_patch*15,1,3];

%Plotting Different patterns and graphs
figure(1);
show(p); %Display Antenna 
% figure(2);
% pattern(p,1.943e9); %Display Radiation Pattern at 1.943GHZ
% figure(3);
% impedance(p,1.6e9:2e7:2.2e9); %Display Impedance Graph from 1.6GHz to 2.2GHz
% freq = linspace(1.6e9, 2.2e9, 50);  % Creating Frequency Vector
% s = sparameters(p,freq,50);     % Calalculate S11 for all frequencys
% figure(4);
% rfplot(s);%Diplay S11 Plot