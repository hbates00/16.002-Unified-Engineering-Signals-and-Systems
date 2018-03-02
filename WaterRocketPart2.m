%%plots shit

hold on
title('Distance Vs Water Mass', 'fontsize', 16)

plot(WaterMass, Distance)

xlabel('Water Mass (kg)', 'fontsize', 12)
ylabel('Distance (m)', 'fontsize', 12)


%% Flipped plots shit

hold on
title('Distance Vs Water Mass', 'fontsize', 16)

plot(WaterMass, Distance)

xlabel('Distance (m)', 'fontsize', 12)
ylabel('Water Mass (kg)', 'fontsize', 12)

%%

minmw = [];

for i = 0:.05:1.95
    Data = modified_sim(i, 90);
    minmw(end+1) = Data;
end

%%

hold on
title('Angle Vs Minimum Water Mass', 'fontsize', 16)

plot(angle, minwater)

xlabel('Angle (degrees)', 'fontsize', 12)
ylabel('Water Mass (kg)', 'fontsize', 12)
 

        
        