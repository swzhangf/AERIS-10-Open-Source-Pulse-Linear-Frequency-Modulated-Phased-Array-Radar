%% ---- Slotted waveguide column (dielectric-filled, alumina) ----
% Your numbers:
f0      = 10.5e9;           % Hz
eps_r   = 9.8;              % alumina (99.5–99.8%)
a       = 8.5e-3;           % broad wall (m)
b       = 3.5e-3;           % narrow wall (m)
Mcols   = 16;               % (for panel-level, not used here)
Nslots  = 32;               % per column

% Physical constants
c0   = physconst('LightSpeed');
lam0 = c0/f0;

%% ---- Rectangular waveguide TE10 cutoff (filled with eps_r) ----
% fc10 = (c0 / (2*a*sqrt(eps_r)))
fc10 = c0/(2*a*sqrt(eps_r));
if f0 <= fc10
    error('f0 is below TE10 cutoff for the filled waveguide.')
end

% Guide wavelength in dielectric:  λg = λ0 / sqrt(1 - (fc10/f0)^2)
lamg = lam0 / sqrt(1 - (fc10/f0)^2);

%% ---- Design rules derived from λg ----
% Slot spacing: s = λg/2
slotSpacing = lamg/2;                     % ~ 16.915 mm (with λg=33.83 mm)
% Slot length (longitudinal): L ≈ 0.47*λg  (trim in proto if needed)
slotLen     = 0.47*lamg;                  % ~ 15.9 mm
% Slot width: keep electrically narrow but machinable
slotWid     = 0.02*lam0;                  % ~ 0.57 mm at 10.5 GHz

% Slot offset from centerline: start ~ 0.25*a (tune per-slot for taper)
x_offset    = 0.25*a;                     % ~ 2.1 mm

% Probe length inside dielectric (for note/consistency):
Lprobe      = lam0/(4*sqrt(eps_r));       % ~ 2.28 mm

%% ---- Overall waveguide length and feed locations ----
% Center the slot train about z=0 (Antenna Toolbox uses feed/slot offsets
% relative to the waveguide center by default).
z_first = ((Nslots)/2-0.5)*slotSpacing ;    % first-slot z position (centered array)
z_feed  = -z_first - lamg/4;               % ~ quarter-wave behind first slot
z_short = z_feed - lamg/4;                % backshort another quarter-wave behind

% Put some margin beyond the last slot and behind the short:
z_margin_front = 2*slotSpacing;
z_margin_back  = 2*slotSpacing;
wgLength = lamg + (Nslots-1)*slotSpacing;
% This keeps the backshort inside the model and gives space beyond last slot.

% Antenna Toolbox expects total Length (z extent), Width (y=a), Height (x=b)
Length = wgLength;
Width  = a;
Height = b;

% Slot-to-top: distance from slot center to the top (outer) broad-wall edge.
% If the slot offset from center is +x_offset toward the top wall,
% then SlotToTop ≈ (a/2 - x_offset).
slotToTop = (a/2 - x_offset);

% The SlotOffset property is the lateral offset from the guide centerline.
% Use +x_offset (sign convention follows object; if inverted, use -x_offset).
slotOffset = x_offset;

% Feed parameters:
feedHeight = Lprobe;          % use the probe length as the pin intrusion (model note)
feedWidth  = 1.2e-3;          % ~1.2 mm hole/pin diameter (adjust to your connector)
feedOffset = [z_feed, 0];     % [z y] offset (y=0 at column center)

%% ---- Build the slotted waveguide in Antenna Toolbox ----
slotShape = antenna.Rectangle('Length',slotLen,'Width',slotWid);

ant = waveguideSlotted( ...
    'Length',        Length, ...
    'Width',         Width, ...
    'Height',        Height, ...
    'NumSlots',      Nslots, ...
    'Slot',          slotShape, ...
    'SlotSpacing',   slotSpacing, ...
    'SlotOffset',    slotOffset, ...
    'ClosedWaveguide', 1, ...
    'SlotToTop',     lamg/2, ...
    'FeedHeight',    feedHeight, ...
    'FeedOffset',    feedOffset, ...
    'FeedWidth',     feedWidth);

% For plotting/inspection
figure; show(ant); title('Dielectric-informed slotted waveguide (geometry driven)');

%% ---- Optional: verify positions quickly in the command window ----
fprintf('lambda0 = %.3f mm, lambda_g = %.3f mm\n', lam0*1e3, lamg*1e3);
fprintf('SlotSpacing = %.3f mm, SlotLen = %.3f mm, SlotWid = %.3f mm\n', slotSpacing*1e3, slotLen*1e3, slotWid*1e3);
fprintf('Slot offset = %.3f mm  (SlotToTop = %.3f mm)\n', slotOffset*1e3, slotToTop*1e3);
fprintf('z_first = %.2f mm, z_feed = %.2f mm, z_short = %.2f mm\n', z_first*1e3, z_feed*1e3, z_short*1e3);
fprintf('FeedHeight (probe) ~ %.2f mm, FeedWidth ~ %.2f mm\n', feedHeight*1e3, feedWidth*1e3);
