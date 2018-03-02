function [x, t] = FE_rocket(x0, dt, Data)

% Set initial conditions
x(:,1) = x0;
t(1) = 0;
i = 1;

% Main integration loop
% Loop will execute at least one iteration and then will terminate
% when the altitude (assumed to be the second state) is no longer positive 

while ( (i==1) || (x(2,i) > 0) ),

    % Calculate state dynamics (f) at time i
    f = calcf_rocket(x(:,i), t(i), Data);
    
    % Find states at time i+1 using Forward Euler method
    x(:,i+1) = x(:,i) + f*dt;
    
    % Increment time and time index
    t(i+1) = t(i) + dt;
    i = i + 1;
    
end

