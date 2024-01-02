[D] = GetData;

%% choose makers, time, colors
% select the markers you wish to plot. 
% must less than D.MarkersCount  
D.Chosen_mk=1:6;

% choose the time frame you wish to display on the plot.
% must within D.frame  
D.sF=D.frame(1);
D.eF=D.frame(200);

% generate colors based on D.MarkersCount  
D.colors = hsv(D.MarkersCount);

% Create a cell array to store marker names
for m = 1:length(D.Chosen_mk)
    D.mkNames{m} = D.markers{D.Chosen_mk(m)}.MarkerName; % Store marker names
end

%% plot selected markers Trajectory during trial with different color (moving video saved) 
P_mks_V(D);

%% plot all markers Trajectory during trial (still picture)
P_mks_P(D);

