% Open file to write
csvFileName = 'pattern_data.csv';
fileID = fopen(csvFileName, 'w');
fprintf(fileID, 'Theta,Phi,Pattern\n'); % CSV headers

% Define angles (break into smaller chunks)
theta = -90:1:90;
phi = -180:1:180;
chunk_size = 50;

%Size of PCB
pcbThickness = 0.508e-3;  
pcbLength = 100e-3;   
pcbWidth = 100e-3; 

n_array = 3;
m_array = 2;

f = 10.5e+9;
c = 3e+8;
lambda = c/f;
 
Length_patch = 8.76e-3;
Width_patch = 9.545e-3;
dist_patch = lambda/2;
feeder_width = 0.94e-3;
delta_phy = 15; %in degrees
  
%Specifying Material of PCB
pcbMaterial = 'RO4350B';
pcbEpsilonR = 3.48;
%Creating dielectic Material
d = dielectric(pcbMaterial); 
d.EpsilonR = pcbEpsilonR;
d.Thickness = pcbThickness;
GndPlane = antenna.Rectangle('Length',pcbLength,'Width',pcbWidth); %Creating Ground Plane of Antenna
%Creating Different Shapes of antenna 
%Rec1 = antenna.Rectangle('Length',feeder_width,'Width',dist_patch-Length_patch,'Center',[0,(dist_patch-Length_patch)/2]); %feeder
%Rec2 = antenna.Rectangle('Length',Length_patch,'Width',Width_patch,'Center',[0,(dist_patch-Length_patch)+(Length_patch)/2]); %patch

for i=1:1:n_array
	for j=1:1:m_array
		Rec1 = Rec1 + antenna.Rectangle('Length',feeder_width,'Width',dist_patch-Length_patch,'Center',[(i-1)*(dist_patch),(j-1)*(dist_patch)+(dist_patch-Length_patch)/2]);
		Rec2 = Rec2 + antenna.Rectangle('Length',Length_patch,'Width',Width_patch,'Center',[(i-1)*(dist_patch),(j-1)*(dist_patch)+(dist_patch-Length_patch)+(Length_patch)/2]);
	end
end


%Adding all different shapes of antenna
AntennaPlane =  Rec1 + Rec2;

%%Creating PCB Stack
p = pcbStack;
p.Name = 'patch slot';
p.BoardShape = GndPlane;
p.BoardThickness = pcbThickness;
p.Layers = {AntennaPlane,d,GndPlane}; 
%[x Cordinate,y Cordinate,startLayer stopLayer]
% p.FeedLocations = [0,0,1,3;dist_patch,0,1,3;dist_patch*2,0,1,3;dist_patch*3,0,1,3;dist_patch*4,0,1,3;dist_patch*5,0,1,3;dist_patch*6,0,1,3;dist_patch*7,0,1,3;dist_patch*8,0,1,3;dist_patch*9,0,1,3;dist_patch*10,0,1,3;dist_patch*11,0,1,3;dist_patch*12,0,1,3;dist_patch*13,0,1,3;dist_patch*14,0,1,3;dist_patch*15,0,1,3];
% p.FeedPhase = [0,delta_phy, delta_phy*2, delta_phy*3, delta_phy*4, delta_phy*5, delta_phy*6, delta_phy*7, delta_phy*8, delta_phy*9, delta_phy*10, delta_phy*11, delta_phy*12, delta_phy*13, delta_phy*14, delta_phy*15];

p.FeedLocations = [0,0.001,1,3;dist_patch,0.001,1,3;dist_patch*2,0.001,1,3];


%Plotting Different patterns and graphs
figure(1);
show(p); %Display Antenna 
%pattern(p,10.5e9); %Display Radiation Pattern at 10.5GHz
% Process and save in chunks
for i = 1:chunk_size:length(theta)
    for j = 1:chunk_size:length(phi)
        % Simulated computation (replace with actual pattern function)
        p_val = rand(); % Example placeholder

        % Write to file
        fprintf(fileID, '%.2f,%.2f,%.6f\n', theta(i), phi(j), p_val);
    end
end

% Close the file
fclose(fileID);

% Display confirmation message
figure(2);
disp('Pattern data saved to CSV.');

% figure(3);
% impedance(p,0.8*f:0.05*f:1.2*f); %Display Impedance Graph from 1.6GHz to 2.2GHz
% freq = linspace(0.8*f, 1.2*f, 50);  % Creating Frequency Vector
% s = sparameters(p,freq,50);     % Calalculate S11 for all frequencys
% figure(4);
% rfplot(s);%Diplay S11 Plot