function [f] = calcf_rocket(x, t, Data)

% Unpack x and Data into appropriate variable names
mw = x(1);
zr = x(2);
wr = x(3);
xr = x(4);
ur = x(5);

rhow = Data.rhow; % Water density
Ae = Data.Ae; % Cross-sectional area of exhaust nozzle
Vb = Data.Vb; % Volume of bottle
pa0 = Data.pa0; % Initial air pressure
Va0 = Data.Va0; % Initial air volume
gamma = Data.gamma; % Specific heat ratio for air
patm = Data.patm; % Atmospheric pressure
g = Data.g; % gravity
mr = Data.mr; % rocket mass
rho = Data.rho; % air density 
Aref = Data.Aref; % reference area for CD
CD = Data.CD; % CD

if (mw > 0),
    
    % Determine current water volume
    Vw = mw/rhow;
    
    % Determine current air volume
    Va = Vb - Vw;
    
    % Determine current air pressure
    pa = max(pa0*(Va0/Va)^gamma,patm);

    % Determine current exhaust velocity
    Ve = sqrt(2*(pa-patm)/rhow);
    
else
    
    Ve = 0;
    
end

% Determine external forces
T = rhow*Ae*Ve^2;
Vr = sqrt(ur^2 + wr^2);
D = 0.5*rho*Vr^2*Aref*CD;
Fx = (T-D)*ur/Vr;
Fz = (T-D)*wr/Vr - (mw+mr)*g;

% f1 is dmw/dt = -rhow*Ae*Ve
f1 = -rhow*Ae*Ve;

% f2 is dzr/dt = wr
f2 = wr;

% f3 is dwr/dt = Fz/m
f3 = Fz/(mw+mr);

% f4 is dxr/dt = ur
f4 = ur;

% f5 is dur/dt = Fx/m
f5 = Fx/(mw+mr);

% Pack into column vector
f = [f1; f2; f3; f4; f5];


