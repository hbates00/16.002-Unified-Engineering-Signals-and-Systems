function [Data] = modified_setinputs(a, b)

% The following are the user adjustable input parameters for simulating the rocket
% trajectory

Data.dpA = 2.76E5; % Initial pressure difference (Pa)
Data.mr = 0.400; % Rocket mass including payload, just not water (kg)
Data.CD = 0.5; % Drag coefficient
Data.Ae = 5E-4; % Bottle exhaust area (m^2)
Data.Vb = 2E-3; % Volume of bottle (m^3)
Data.Aref = 8E-3; % CD reference area (m^2)  COMMENT: for the water
                  % rocket lab, you should not vary Aref.  Assume
                  % it is a fixed number used to scale the drag
                  % coefficient to produce the actual drag force.
                  
% COMMENT: eventually, the following two parameters you may want to set outside
% of this function, since you will probably determine them by
% minimizing mw0 for all possible alpha0
Data.mw0 = a; % Initial water mass (kg)
Data.alpha0 = b; % Initial launch angle (degrees) 
