% wg_alumina_slotted_gain.m
% Alumina-filled slotted waveguide (openEMS) with speed/final toggle
% + S11 + Far-field + Directivity + (Realized) Gain.
% Axes: X=b (thickness), Y=a (broad), Z=length (propagation).

clear; clc;

%% ---------------- Toggles ----------------
speedMode      = true;     % set false for full/final run
forcePatterns  = true;     % set true to compute patterns even in FAST mode

%% ---------------- User Parameters (mm) ----------------
f0      = 10.5e9;                   % Hz
fbw     = 0.20;                     % S11 band ±10%
eps_r   = 9.8;                      % alumina
tanD    = 1e-4;                     % alumina loss tangent

a       = 8.5;                      % Y (mm)
b       = 3.5;                      % X (mm)
twall   = 0.6;                      % wall thickness (mm)

% slot rules
slotWidth_rule = 0.02;              % w ~ 0.02*lambda0
slotLen_rule   = 0.47;              % L ~ 0.47*lambda_g
x_off_baseFrac = 0.25;              % base offset ~ 0.25*a
x_off_minFrac  = 0.22;              % clamp min
x_off_maxFrac  = 0.30;              % clamp max
kaiser_beta    = 1.65;              % ~ -25 dB-like taper

% coax (SMA-ish) defaults
r_in_default  = 0.30;               % mm
r_out_default = 1.50;               % mm

% speed/final presets
if speedMode
    Nslots = 9;
    r_in   = 0.50;                  % thicker pin -> coarser mesh
    r_out  = 1.80;
    slot_W_override = 0.8;          % widen slot to 0.8 mm
    endCrit = 5e-4;
    ratio   = 2.2;
    doNF2FF = false;
else
    Nslots = 32;
    r_in   = r_in_default;
    r_out  = r_out_default;
    slot_W_override = [];
    endCrit = 1e-4;
    ratio   = 1.7;
    doNF2FF = true;
end
% allow forcing patterns on in fast mode
if forcePatterns
    doNF2FF = true;
end

r_os = r_out + 0.40;                % outer shell radius (mm)

%% ---------------- Derived guide quantities ----------------
lambda0 = (3e8/f0)*1e3;             % mm
fc10    = (3e8)/(2*(a*1e-3)*sqrt(eps_r));
assert(f0>fc10, 'f0 below TE10 cutoff with alumina fill.');

lambda_g = lambda0 / sqrt(1 - (fc10/f0)^2);
dz       = lambda_g/2;
slot_L   = slotLen_rule   * lambda_g;
slot_W   = slotWidth_rule * lambda0;
if ~isempty(slot_W_override), slot_W = slot_W_override; end
x_off_base = x_off_baseFrac * a;

% longitudinal layout (Z)
z_first  = -((Nslots-1)/2)*dz;
z_feed   =  z_first - lambda_g/4;
z_short  =  z_feed  - lambda_g/4;

% margins along Z
if speedMode
    front_margin = dz;
    back_margin  = dz;
else
    front_margin = 2*dz;
    back_margin  = 2*dz;
end

z_min = z_short - back_margin;
z_max = -z_first + front_margin;
Lz    = (z_max - z_min);

fprintf('lambda0=%.2f mm, lambda_g=%.2f mm, dz=%.2f mm\n',lambda0,lambda_g,dz);
fprintf('z_first=%.2f mm, z_feed=%.2f mm, z_short=%.2f mm\n',z_first,z_feed,z_short);

%% ---------------- openEMS / CSX ----------------
unit = 1e-3;                        % mm
FDTD = InitFDTD('EndCriteria', endCrit);
FDTD = SetGaussExcite(FDTD, f0, (f0*fbw)/2);
FDTD = SetBoundaryCond(FDTD, {'PML_8','PML_8','PML_8','PML_8','PML_8','PML_8'});

CSX = InitCSX();

% materials
CSX = AddMetal(CSX,'PEC');

CSX = AddMaterial(CSX,'ALUMINA');
CSX = SetMaterialProperty(CSX,'ALUMINA','Epsilon',eps_r,'Mue',1, ...
    'Kappa', 2*pi*f0*8.854187817e-12*eps_r*tanD);

CSX = AddMaterial(CSX,'AIR');
CSX = SetMaterialProperty(CSX,'AIR','Epsilon',1,'Mue',1);

CSX = AddMaterial(CSX,'PTFE');
CSX = SetMaterialProperty(CSX,'PTFE','Epsilon',2.1);

%% ---------------- Geometry (X=b, Y=a, Z=length) ----------------
x0 = -b/2;  x1 =  b/2;
y0 = -a/2;  y1 =  a/2;
z0 = z_min; z1 = z_max;

% alumina fill
CSX = AddBox(CSX,'ALUMINA',1,[x0 y0 z0],[x1 y1 z1]);

% PEC walls + backshort
CSX = AddBox(CSX,'PEC',10,[x1           y0 z0],[x1+twall  y1 z1]); % top
CSX = AddBox(CSX,'PEC',10,[x0-twall     y0 z0],[x0        y1 z1]); % bottom
CSX = AddBox(CSX,'PEC',10,[x0 y1        z0],[x1 y1+twall  z1]);    % +Y
CSX = AddBox(CSX,'PEC',10,[x0 y0-twall  z0],[x1 y0        z1]);    % -Y
CSX = AddBox(CSX,'PEC',12,[x0 y0 z_short],[x1 y1 z_short+twall]);  % backshort

% Kaiser taper -> slot offsets (alternate signs for dz=lambda_g/2)
w = kaiser(Nslots, kaiser_beta)';  w = w/max(w);
x_off_mag = x_off_base * sqrt(w);
x_off_mag = min(max(x_off_mag, x_off_minFrac*a), x_off_maxFrac*a);
signs     = (-1).^(0:Nslots-1);
y_centers = signs .* x_off_mag;

% Drill each slot through top wall (AIR with higher priority)
for n = 1:Nslots
    zc  = z_first + (n-1)*dz;
    y_c = y_centers(n);
    y1s = y_c - slot_W/2;
    y2s = y_c + slot_W/2;
    z1s = zc  - slot_L/2;
    z2s = zc  + slot_L/2;
    CSX = AddBox(CSX,'AIR',20,[x1 y1s z1s],[x1+twall y2s z2s]);
end

%% ---------------- Mesh (STRUCT; BEFORE AddCoaxialPort) ----------------
if speedMode
    maxCell = min([slot_W, r_in, lambda0/15]);
else
    maxCell = min([slot_W, r_in, lambda0/20]);
end

% Y lines (include slot edges)
dy_lines = unique(sort([y0-2, y0, y1, y1+2, y_centers-slot_W/2, y_centers+slot_W/2]));
dy = SmoothMeshLines(dy_lines, maxCell, ratio);

% Z lines (include slot edges + feed/short)
slot_z_edges = zeros(1, 2*Nslots);
for n = 1:Nslots
    zc = z_first + (n-1)*dz;
    slot_z_edges(2*n-1) = zc - slot_L/2;
    slot_z_edges(2*n)   = zc + slot_L/2;
end
dz_lines = unique(sort([z0-5, z0, slot_z_edges, z_feed, z_short, z1, z1+5]));
dz = SmoothMeshLines(dz_lines, maxCell, ratio);

% X lines (thickness)
dx = SmoothMeshLines([x0-2, x0, x1, x1+2], maxCell, ratio);

mesh = struct('x', dx, 'y', dy, 'z', dz);
CSX  = DefineRectGrid(CSX, unit, mesh);

%% ---------------- Coaxial probe feed (AFTER mesh) ----------------
% Coax along +Y from -Y wall at z = z_feed
start = [0, y0 - twall - 0.5, z_feed];   % outside PEC by 0.5 mm
stop  = [0, y0 + 0.05,        z_feed];   % 50 µm inside alumina

% 11-arg API: AddCoaxialPort(CSX,prio,portnr,'PEC','PTFE',start,stop,dir,r_i,r_o,r_os,...)
[CSX, port] = AddCoaxialPort( ...
    CSX, 100, 1, 'PEC', 'PTFE', start, stop, 'y', r_in, r_out, r_os, ...
    'ExciteAmp', 1.0);

%% ---------------- NF2FF box (robust across versions) ----------------
doNF2FF = doNF2FF || forcePatterns;   % keep your toggles

if doNF2FF
    nf_box_name = 'nf2ff';
    nf_start = [x0 - (twall+1), y0 - (twall+1), z0 - 5];
    nf_stop  = [x1 + (twall+1), y1 + (twall+1), z1 + 5];

    % Try modern creator that RETURNS a struct:
    nf2ff = [];
    try
        nf2ff = CreateNF2FFBox(CSX, nf_box_name, nf_start, nf_stop);
    catch
        % Fallback: older helper that RETURNS nothing; synthesize the struct
        try
            AddNF2FFBox(CSX, nf_box_name, nf_start, nf_stop);
            nf2ff = struct('name', nf_box_name);
        catch
            % Some very old versions add via AddBox/SetNF2FFBox—last resort:
            error('NF2FF box creation failed. Your openEMS build lacks Create/AddNF2FFBox.');
        end
    end
end



%% ---------------- Write / View / Run ----------------
if speedMode, Sim_Path = 'sim_wg_alumina_fast';
else,        Sim_Path = 'sim_wg_alumina_final'; end
Sim_CSX  = 'wg_alumina.xml';
[~,~] = rmdir(Sim_Path, 's'); mkdir(Sim_Path);
WriteOpenEMS(fullfile(Sim_Path, Sim_CSX), FDTD, CSX);

if exist('AppCSXCAD','file'), AppCSXCAD(fullfile(Sim_Path, Sim_CSX)); end
RunOpenEMS(Sim_Path, Sim_CSX, '--engine=multithreaded');

%% ---------------- S11 (robust block) ----------------
f1 = f0*(1 - fbw/2);  
f2 = f0*(1 + fbw/2);
Npts = 401;
fvec = linspace(f1, f2, Npts);

try
    port = calcPort(port, Sim_Path, fvec, 'RefImpedance', 50);
catch
    port = calcPort(port, Sim_Path, fvec);
end

if isfield(port, 'uf') && isfield(port.uf,'ref') && isfield(port.uf,'inc')
    S11 = port.uf.ref ./ port.uf.inc;
elseif isfield(port, 'U') && isfield(port.U,'ref') && isfield(port.U,'inc')
    S11 = port.U.ref ./ port.U.inc;
else
    error('Unknown port struct fields. Inspect "port".');
end

figure; plot(fvec/1e9, 20*log10(abs(S11)), 'LineWidth',1.5);
grid on; xlabel('Frequency (GHz)'); ylabel('|S_{11}| (dB)');
if speedMode, title(sprintf('|S_{11}| alumina %d-slot (FAST)', Nslots));
else,        title(sprintf('|S_{11}| alumina %d-slot (FINAL)', Nslots)); end

% S11 at f0 for mismatch efficiency
[~, idx0] = min(abs(fvec - f0));
Gamma0 = S11(idx0);
eta_m  = 1 - abs(Gamma0)^2;

%% ---------------- Far-field, Directivity, Gain ----------------
if doNF2FF
    theta = linspace(0,180,361);   % deg
    phi   = linspace(0,360,721);   % deg

    % Ensure we pass a struct with .name; if a string slipped through, wrap it
    if ischar(nf2ff)
        nf2ff = struct('name', nf2ff);
    end

    try
        ff3d = CalcNF2FF(nf2ff, Sim_Path, f0, theta, phi, 'OutDir','nf2ff');
    catch
        % Some builds don’t support 'OutDir' option
        ff3d = CalcNF2FF(nf2ff, Sim_Path, f0, theta, phi);
    end


    % Radiation intensity U = |E|^2/(2*eta0) at r=1 m
    eta0 = 376.730313668;
    U = (E.^2) ./ (2*eta0);      % W/sr

    % Integrate over sphere to get Prad
    th = deg2rad(theta(:));      % Nx1
    ph = deg2rad(phi(:)).';      % 1xM
    dth = [diff(th); th(end)-th(end-1)];
    dph = [diff(ph), ph(end)-ph(end-1)];
    [DTH, DPH] = ndgrid(dth, dph);
    [SINE, ~]  = ndgrid(sin(th), ones(size(ph)));
    dOmega = SINE .* DTH .* DPH;
    Prad = sum(U .* dOmega, 'all');

    % Directivity
    D = 4*pi * U / Prad;
    [Dmax, imax] = max(D(:));
    [i_th, i_ph] = ind2sub(size(D), imax);
    th_max = theta(i_th);  ph_max = phi(i_ph);

    % Accepted power Pacc from port struct (best-effort across versions)
    Pacc = NaN;
    if isfield(port,'P_inc') && isfield(port,'P_ref')
        Pinc0 = port.P_inc(idx0); Pref0 = port.P_ref(idx0);
        Pacc = real(Pinc0 - Pref0);
    elseif isfield(port,'uf') && isfield(port,'if') ...
           && isfield(port.uf,'inc') && isfield(port.if,'inc') ...
           && isfield(port.uf,'ref') && isfield(port.if,'ref')
        Uinc = port.uf.inc(idx0);  Iinc = port.if.inc(idx0);
        Uref = port.uf.ref(idx0);  Iref = port.if.ref(idx0);
        Pacc = real(0.5*(Uinc*conj(Iinc) - Uref*conj(Iref)));
    elseif isfield(port,'U') && isfield(port,'I') ...
           && isfield(port.U,'inc') && isfield(port.I,'inc') ...
           && isfield(port.U,'ref') && isfield(port.I,'ref')
        Uinc = port.U.inc(idx0);  Iinc = port.I.inc(idx0);
        Uref = port.U.ref(idx0);  Iref = port.I.ref(idx0);
        Pacc = real(0.5*(Uinc*conj(Iinc) - Uref*conj(Iref)));
    end
    if ~isfinite(Pacc) || Pacc<=0
        warning('Pacc not found in port struct; assuming Pacc = 1 W.');
        Pacc = 1.0;
    end
    eta_rad = Prad / Pacc;  eta_rad = max(min(eta_rad,1),0);

    % Gains
    Gmax      = eta_rad * Dmax;
    Greal_max = eta_m  * Gmax;
    Gmax_dBi      = 10*log10(Gmax);
    Greal_max_dBi = 10*log10(Greal_max);

    fprintf('\n=== Gain summary @ %.3f GHz ===\n', f0/1e9);
    fprintf('Prad = %.3f W, Pacc = %.3f W  =>  eta_rad = %.1f %%\n', Prad, Pacc, 100*eta_rad);
    fprintf('Mismatch efficiency eta_m = %.1f %%  (|S11|=%.2f dB)\n', 100*eta_m, 20*log10(abs(Gamma0)));
    fprintf('Dmax = %.2f (%.2f dBi) at (theta=%.1f°, phi=%.1f°)\n', Dmax, 10*log10(Dmax), th_max, ph_max);
    fprintf('Gmax      = %.2f dBi\n', Gmax_dBi);
    fprintf('Greal_max = %.2f dBi (includes mismatch)\n\n', Greal_max_dBi);

    % Quick E/H-plane plots (normalized)
    [~,i_phi0] = min(abs(phi-0));
    EnormE = E(:,i_phi0) / max(E(:,i_phi0));
    figure; plot(theta, 20*log10(abs(EnormE)+1e-15),'LineWidth',1.5);
    grid on; xlabel('\theta (deg)'); ylabel('Normalized |E| (dB)'); ylim([-60 0]);
    title('E-plane cut (\phi \approx 0^\circ)');

    [~,i_phiH] = min(abs(phi-90));
    EnormH = E(:,i_phiH) / max(E(:,i_phiH));
    figure; plot(theta, 20*log10(abs(EnormH)+1e-15),'LineWidth',1.5);
    grid on; xlabel('\theta (deg)'); ylabel('Normalized |E| (dB)'); ylim([-60 0]);
    title('H-plane cut (\phi \approx 90^\circ)');
end

