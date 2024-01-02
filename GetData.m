function [D] = GetData(file);
%[data,frame,headers,MarkersCount,makers,x,y,z] = GetData;

%% clean the data
% Read the CSV file from Vicon load to Matlab
% Properties setting: 
% Filename:Current Tral
% File Extension:.csv
% First Frame:Selected Start
% Last Frame:Selected End
% Delimiter:,
% Export Gait Cycle Parameters:no
% Export Events:no
% Devices:
    % Devices for Export:All
    % Combined Forceplates:All
% Joints
    % Kinematics:none
% Model Outputs
    % Model Outputs:All
    % Modeled Markers:All
% Segments
    % Global Angle:None
% Trajectories
    % Components:All
    % Distance From Origin:None
    % Trajectory Count:Yes
data = readtable(file);


% get total frame index
D.frame = table2array(data(2:end,1));

% Get the original header names
headers = data.Properties.VariableNames;

%get markers name, save in makers (cell array) as MarkerName, and x, y ,z
%for the marker
D.MarkersCount=0;
% Loop through the headers and update names as required
for column = 3:length(headers)-1
    if ~contains(headers{column}, 'Var')
        D.MarkersCount=D.MarkersCount+1;
        D.markers{D.MarkersCount}.MarkerName=headers{column};
        D.markers{D.MarkersCount}.x=table2array(data(2:end,column));
        D.markers{D.MarkersCount}.y=table2array(data(2:end,column+1));
        D.markers{D.MarkersCount}.z=table2array(data(2:end,column+2));
    end
    if contains(headers{column}, 'Var')
    end
end

% save all 6 makers in variable x, y, z 
for m=1:D.MarkersCount
    D.x(:,m)=D.markers{m}.x;
    D.y(:,m)=D.markers{m}.y;
    D.z(:,m)=D.markers{m}.z;
end