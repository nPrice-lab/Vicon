function [D] = GetData(files)
%% Read the CSV file from Vicon load to Matlab
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
    
    % Initialize D structure
    D = struct('frame', {}, 'MarkersCount', 0, 'markers', {});

    % Iterate through each file
    for fileIndex = 1:length(files)
        file = files{fileIndex};

        % Read the CSV file from Vicon and load it into Matlab
        data = readtable(file);

        % Get total frame index
        D(fileIndex).frame = table2array(data(2:end, 1));

        % Get the original header names
        headers = data.Properties.VariableNames;

        % Loop through the headers and update names as required
        for column = 3:length(headers)-1
            if ~contains(headers{column}, 'Var')
                D(fileIndex).MarkersCount = D(fileIndex).MarkersCount + 1;
                D(fileIndex).markers(D(fileIndex).MarkersCount).MarkerName = headers{column};
                D(fileIndex).markers(D(fileIndex).MarkersCount).rawX = table2array(data(2:end, column));
                D(fileIndex).markers(D(fileIndex).MarkersCount).rawY = table2array(data(2:end, column + 1));
                D(fileIndex).markers(D(fileIndex).MarkersCount).rawZ = table2array(data(2:end, column + 2));
            end
            % You can add more conditions if needed
            if contains(headers{column}, 'Var')
            end
        end
    end
end
