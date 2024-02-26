%% input file here
files ={'/Users/yilinwu/Desktop/nic/Vicon/CSV/02.csv','/Users/yilinwu/Desktop/nic/Vicon/CSV/03.csv'};


files ={'/Users/yilinwu/Desktop/nic/Vicon/CSV/02.csv','/Users/yilinwu/Desktop/nic/Vicon/CSV/03.csv','/Users/yilinwu/Desktop/nic/Vicon/CSV/04.csv'};

%% get data from CSV file to strut
D = getData(files);

%% filter the raw X, Y, and Z coordinates of markers windowSize filter
% save the filtered data in the same data structure. 
% plots the raw and filtered data for each marker separately in three separate figures 
% (one for X, one for Y, and one for Z).
windowSize = 5; 
D = dataFilter(D,windowSize,files);
D = plotFiltered(D, files);
%% choose makers, time, colors,store name
% select the markers you wish to plot. 
% must less than D.MarkersCount  

% choose the time frame you wish to display on the plot.
% must within D.frame

% generate colors based on D{fileIndex}.MarkersCount  

% Create a cell array to store marker names

Chosen_mk=[2,14];

for fileIndex = 1:length(files)
    D{fileIndex}.Chosen_mk=Chosen_mk;
    D{fileIndex}.startTime =0;
    D{fileIndex}.endTime =10;
    D{fileIndex}.colors = hsv(D{fileIndex}.MarkersCount);
    for m = 1:length(D{fileIndex}.Chosen_mk)
        D{fileIndex}.mkNames{m} = D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.MarkerName; % Store marker names
    end
end

%% plot selected markers Trajectory during trial with different color (moving video saved) 
markerVideo(D,files);

%% plot all markers Trajectory during trial (still picture)
markerTraj(D,files);

%% plotting 1D position over time for one or individual markers (e.g. three graphs with axes XT, YT, ZT) with peak/valley
D = valleyAndPeak(D, files);

%% plot colour code trajectories according to throw number
D=P_Throw_VP(D,files);

%% extract metrics such as: 
% cycle duration=CD; 
% peak hand speed=P_HV; 
% peak hand acceleration=P_HA; 
% maximum hand range (variation in position)=M_HR; 
% cycle distance (i.e. how far does the hand move during a full throwing cycle)= C_D. 
D = P_Throw_Metrics(D,files);

%% Conducts Principal Component Analysis (PCA) on motion capture data stored in the cell array D.
D = PCA(D, files);
D = CombinedPCA(D, files);