%% extract metrics such as: 
% cycle duration=CD; 
% peak hand speed=P_HV; 
% peak hand acceleration=P_HA; 
% maximum hand range (variation in position)=M_HR; 
% cycle distance (i.e. how far does the hand move during a full throwing cycle)= C_D. 

function D = P_Throw_Metrics(D,files);

for fileIndex = 1:length(files)

    % Assuming D.markers contains information for all markers
    for m = 1:length(D{fileIndex}.Chosen_mk)
            %if D.markers{D.Chosen_mk(m)}.z_valleyLocs(1) smaller, return
        if D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_valleyLocs(1) < D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_peakLocs(1)
            z_vlocs = D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_valleyLocs;
        end
    
        %if D.markers{D.Chosen_mk(m)}.z_valleyLocs(1) bigger, return
        if D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_valleyLocs(1) > D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_peakLocs(1)
            z_vlocs = D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_peakLocs;
        end
        % Iterate through each throw
        for v = 2:length(z_vlocs)
    
            frame_rate=120;
            % Calculate and save throw data for each marker
            CD = (z_vlocs(v) - z_vlocs(v-1)) / frame_rate;
            HV = sqrt(diff(D{fileIndex}.x(z_vlocs(v-1):z_vlocs(v), D{fileIndex}.Chosen_mk(m))).^2 + ...
                diff(D{fileIndex}.y(z_vlocs(v-1):z_vlocs(v), D{fileIndex}.Chosen_mk(m))).^2 + ...
                diff(D{fileIndex}.z(z_vlocs(v-1):z_vlocs(v), D{fileIndex}.Chosen_mk(m))).^2) / CD;
            
            P_HV = max(HV);
            P_HA = max(diff(HV) / CD);
            M_HR = max(sqrt((D{fileIndex}.x(z_vlocs(v-1), D{fileIndex}.Chosen_mk(m)) - D{fileIndex}.x(z_vlocs(v), D{fileIndex}.Chosen_mk(m))).^2 + ...
                (D{fileIndex}.y(z_vlocs(v-1), D{fileIndex}.Chosen_mk(m)) - D{fileIndex}.y(z_vlocs(v), D{fileIndex}.Chosen_mk(m))).^2 + ...
                (D{fileIndex}.z(z_vlocs(v-1), D{fileIndex}.Chosen_mk(m)) - D{fileIndex}.z(z_vlocs(v), D{fileIndex}.Chosen_mk(m))).^2));
            C_D = sum(sqrt(diff(D{fileIndex}.x(z_vlocs(v-1):z_vlocs(v), D{fileIndex}.Chosen_mk(m))).^2 + ...
                diff(D{fileIndex}.y(z_vlocs(v-1):z_vlocs(v), D{fileIndex}.Chosen_mk(m))).^2 + ...
                diff(D{fileIndex}.z(z_vlocs(v-1):z_vlocs(v), D{fileIndex}.Chosen_mk(m))).^2));
    
            % Save calculated throw data to the marker structure
            D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.throw_data{v}.CD = CD;
            D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.throw_data{v}.P_HV = P_HV;
            D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.throw_data{v}.P_HA = P_HA;
            D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.throw_data{v}.M_HR = M_HR;
            D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.throw_data{v}.C_D = C_D;
        end
    end
end