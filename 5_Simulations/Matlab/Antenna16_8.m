n_array = 1;
m_array = 2;

delta_phy = 15; %phase difference between adjacent patches (in degrees)

f = 10.5e+9;
c = 3e+8;
lambda = c/f;
 
Width_patch = 8.76e-3;
Length_patch = 9.545e-3;
dist_patch = lambda/2;
feeder_width = dist_patch - Width_patch;
feeder_length = 0.94e-3;

% Define angles (break into smaller chunks)
theta = -90:1:90;
phi = -180:1:180;
chunk_size = 30;


% Define file name for saving
matFileName = 'pattern_data.mat';

% Create a MAT file object for incremental writing
mf = matfile(matFileName, 'Writable', true);



%Size of PCB
pcbThickness = 0.508e-3;  
pcbWidth = 0.5*feeder_width + (feeder_width +Width_patch)*(m_array);  
pcbLength =dist_patch*n_array; 
  
%Specifying Material of PCB
% pcbMaterial = 'RO4350B';
% pcbEpsilonR = 3.48;
pcbMaterial = 'RO4350B';
pcbEpsilonR = 3.48;
d = dielectric(pcbMaterial); 
d.EpsilonR = pcbEpsilonR;
d.Thickness = pcbThickness;
%Creating dielectic Material

GndPlane = antenna.Rectangle('Length',pcbLength,'Width',pcbWidth,'Center',[0,0]); %Creating Ground Plane of Antenna
%Creating Different Shapes of antenna 
        Rec1 = antenna.Rectangle('Length',feeder_length,'Width',feeder_width,'Center',[-(pcbLength/2)+0.5*dist_patch,-pcbWidth/2+feeder_width/2]);
        Rec2 = antenna.Rectangle('Length',Length_patch,'Width',Width_patch,'Center',[-(pcbLength/2)+0.5*dist_patch,-pcbWidth/2 + feeder_width+Width_patch/2]); 

for j=1:1:n_array
    for i=1:1:m_array
        if((i~=1) || (j~=1))
            Rec1 = Rec1 + antenna.Rectangle('Length',feeder_length,'Width',feeder_width,'Center',[(j-1)*dist_patch-(pcbLength/2)+0.5*dist_patch,-pcbWidth/2+feeder_width/2+(i-1)*dist_patch]);
            Rec2 = Rec2 + antenna.Rectangle('Length',Length_patch,'Width',Width_patch,'Center',[(j-1)*dist_patch-(pcbLength/2)+0.5*dist_patch,-pcbWidth/2+feeder_width+Width_patch/2+ (i-1)*dist_patch]);
        end
    end
end

AntennaPlane = Rec1 + Rec2;


%%Creating PCB Stack
p = pcbStack;
p.Name = 'Strip-fed slot';
p.BoardShape = GndPlane;
p.BoardThickness = pcbThickness;
p.Layers = {AntennaPlane,d,GndPlane};

%[x Cordinate,y Cordinate,startLayer stopLayer]
p.FeedDiameter = feeder_length/4;

p.FeedLocations = [-(pcbLength/2)+0.5*dist_patch,-pcbWidth/2+feeder_length/1.4,1,3];

%p.FeedLocations = [-(pcbLength/2)+0.5*dist_patch,-pcbWidth/2+feeder_length/1.4,1,3;dist_patch-(pcbLength/2)+0.5*dist_patch,-pcbWidth/2+feeder_length/1.4,1,3;dist_patch*2-(pcbLength/2)+0.5*dist_patch,-pcbWidth/2+feeder_length/1.4,1,3];
%p.FeedLocations = [0,feeder_length/1.4,1,3;dist_patch,feeder_length/1.4,1,3;dist_patch*2,feeder_length/1.4,1,3;dist_patch*3,feeder_length/1.4,1,3;dist_patch*4,feeder_length/1.4,1,3;dist_patch*5,feeder_length/1.4,1,3;dist_patch*6,feeder_length/1.4,1,3;dist_patch*7,feeder_length/1.4,1,3;dist_patch*8,feeder_length/1.4,1,3;dist_patch*9,feeder_length/1.4,1,3;dist_patch*10,feeder_length/1.4,1,3;dist_patch*11,feeder_length/1.4,1,3;dist_patch*12,feeder_length/1.4,1,3;dist_patch*13,feeder_length/1.4,1,3;dist_patch*14,feeder_length/1.4,1,3;dist_patch*15,feeder_length/1.4,1,3];
%p.p.FeedPhase = [0 delta_phy delta_phy*2 delta_phy*3 delta_phy*4 delta_phy*5 delta_phy*6 delta_phy*7 delta_phy*8 delta_phy*9 delta_phy*10 delta_phy*11 delta_phy*12 delta_phy*13 delta_phy*14 delta_phy*15];

figure(1);
show(p); %Display Antenna
%figure(2);
% pattern(p,f,-180:30:180,0);
% pattern3Dfig = figure(2); %array pattern
% pattern(p,f);

% Initialize counters for indexing
index = 1;
% Process and store in chunks
for i = 1:chunk_size:length(theta)
    for j = 1:chunk_size:length(phi)
        % Simulated computation (replace with actual pattern function)
        p_val = pattern(p,f,theta(i),phi(j));
        mf.pattern_values(index, 1) = p_val;
        % Store computed values directly into the MAT file (avoiding large RAM usage)
        mf.theta_values(index, 1) = theta(i);
        mf.phi_values(index, 1) = phi(j);
        clear p_val theta(i) phi(j);
        
        
        % Increment index
        index = index + 1;
    end
end

figure(2);
patternCustom( mf.pattern_values,mf.theta_values ,mf.phi_values);
% Display confirmation message
%M = readtable("pattern_data.mat");
%patternCustom(M(:,3),M(:,2),M(:,1));