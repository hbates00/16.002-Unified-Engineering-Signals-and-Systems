% Main function to integrate water rocket test stand behavior

% Set (user) inputs
Data = setinputs_rocket();

% The following are technically input parameters, but should not
% be adjusted
Data.g = 9.81; % gravity (m/s^2)
Data.rhow = 1E3; % Water density (kg/m^3)
Data.patm = 1.01E5; % Atmospheric pressure (Pa)
Data.rho = 1.22; % atmospheric air density (kg/m^3)
Data.gamma = 1.4; % Specific heat ratio for air
Data.lrod = 0.15; % Length of launch rod (m)

% Calculate some additional quantities needed for the simulation
Data.Vw0 = Data.mw0/Data.rhow; % Initial water volume
Data.Va0 = Data.Vb - Data.Vw0; % Initial air volume
Data.paA = Data.patm + Data.dpA; % Initial air pressure (Pa)

% Determine velocity at end of launch rod from energy balance
% First determine the work during this phase
gamma = Data.gamma; % Specific heat ratio for air
paA = Data.paA; % Initial air pressure
VaA = Data.Va0; % Initial air volume
Ae = Data.Ae; % Cross-sectional area of exhaust nozzle
lrod = Data.lrod; % Length of launch rod
patm = Data.patm; % Atmospheric pressure
mr = Data.mr; % Mass of rocket
g = Data.g; % gravity
alpha0 = Data.alpha0*pi/180; % initial launch angle (in radians)

VaB = VaA + Ae*lrod;
W = 1/(gamma-1)*paA*VaA*(1 - (VaA/VaB)^(gamma-1)) - patm*(VaB-VaA);

% Now determine the velocity at the end of the rod
VrB = sqrt(2*(W/mr - g*lrod*sin(alpha0)));

% Set initial pressure
Data.pa0 = paA*(VaA/VaB)^(gamma);

% Uncomment these if the rod is assumed to fill with water only
% (otherwise, the approach assumes the rod is filled with air only)
%Data.Va0 = VaB;
%Data.Vw0 = Data.Vw0-Ae*lrod;

% Set initial condition vector
x0 = [Data.mw0, Data.lrod*sin(alpha0), VrB*sin(alpha0), Data.lrod*cos(alpha0), VrB*cos(alpha0) ];

% Set timestep 
dt = 1E-3; % (s) DO NOT CHANGE THIS

% Call integrator
[x,t] = FE_rocket(x0,dt,Data);

% Unpack states
mw = x(1,:);
zr = x(2,:);
wr = x(3,:);
xr = x(4,:);
ur = x(5,:);

% Find distance traveled (which will be final value of xr in xr array)
xmax = xr(end);
fprintf(1,'Distance traveled = %5.2f m\n',xmax);

% Find maximum height
zmax = max(zr);
fprintf(1,'Apogee = %5.2f m\n',zmax);

%%

% Plot results
figure(1);
plot(xr,zr,'k');
xlabel('x_r (m)');
ylabel('z_r (m)');
title('Trajectory');

figure(2);
subplot(511)
plot(t,xr);
xlabel('t (s)');
ylabel('x_r (m)');
title('x location vs. time');

subplot(512)
plot(t,zr);
xlabel('t (s)');
ylabel('z_r (m)');
title('Altitude vs. time');

subplot(513);
plot(t,ur);
xlabel('t (s)');
ylabel('u_r (m/s)');
title('x-velocity vs. time');

subplot(514);
plot(t,wr);
xlabel('t (s)');
ylabel('w_r (m/s)');
title('z-velocity vs. time');

subplot(515);
plot(t,mw);
xlabel('t (s)');
ylabel('m_w (kg)');
title('Water mass vs. time');


