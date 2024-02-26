function D = getData(files);
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


    for fileIndex = 1:length(files)
        D{fileIndex}.filePath = files{fileIndex};
        

        data = readtable(D{fileIndex}.filePath);
                
        % Get the original header names
        D{fileIndex}.headers = data.Properties.VariableNames;
     
        D{fileIndex}.frameRate=120;

        % get total frame index and time
        D{fileIndex}.frame = table2array(data(2:end,1));
        D{fileIndex}.time = D{fileIndex}.frame/D{fileIndex}.frameRate;

        %get markers name, save in makers (cell array) as MarkerName, and x, y ,z
        %for the marker
        D{fileIndex}.MarkersCount=0;

        % Loop through the headers and update names as required
        for column = 3:length(D{fileIndex}.headers)-1
            if ~contains(D{fileIndex}.headers{column}, 'Var')
                D{fileIndex}.MarkersCount=D{fileIndex}.MarkersCount+1;
                D{fileIndex}.markers{D{fileIndex}.MarkersCount}.MarkerName=D{fileIndex}.headers{column};
                D{fileIndex}.markers{D{fileIndex}.MarkersCount}.rawX=table2array(data(2:end,column));
                D{fileIndex}.markers{D{fileIndex}.MarkersCount}.rawY=table2array(data(2:end,column+1));
                D{fileIndex}.markers{D{fileIndex}.MarkersCount}.rawZ=table2array(data(2:end,column+2));
            end
            if contains(D{fileIndex}.headers{column}, 'Var')
            end
        end
    end


    for fileIndex = 1:length(files)
        for mk=1:D{fileIndex}.MarkersCount
            if iscell(D{fileIndex}.markers{mk}.rawX)
                D{fileIndex}.markers{mk}.rawX=str2double(D{fileIndex}.markers{mk}.rawX);
            end
            if iscell(D{fileIndex}.markers{mk}.rawY)
                D{fileIndex}.markers{mk}.rawY=str2double(D{fileIndex}.markers{mk}.rawY);
            end
            if iscell(D{fileIndex}.markers{mk}.rawZ)
                D{fileIndex}.markers{mk}.rawZ=str2double(D{fileIndex}.markers{mk}.rawZ);
            end


        end
    end





