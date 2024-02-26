%% plot colour code trajectories according to throw number
function D=P_Throw_VP(D,files);


for fileIndex = 1:length(files)


    figure;
    % Assuming D.markers contains information for all markers
    for m = 1:length(D{fileIndex}.Chosen_mk)
    
        %if D.markers{D.Chosen_mk(m)}.z_vlocs(1) smaller, return
        if D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_valleyLocs(1) < D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_peakLocs(1)
            z_vlocs = D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_valleyLocs;
            throw_numbers = 1:length(z_vlocs);
        end
    
        %if D.markers{D.Chosen_mk(m)}.z_vlocs(1) bigger, return
        if D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_valleyLocs(1) > D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_peakLocs(1)
            z_vlocs = D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_peakLocs;
            throw_numbers = 1:length(z_vlocs);
        end
    
        % Iterate through each throw
        for v = 2:length(z_vlocs)
    
            % Plot from the previous point to the current one
            plot3(D{fileIndex}.x(z_vlocs(v-1):z_vlocs(v), D{fileIndex}.Chosen_mk(m)), ...
                D{fileIndex}.y(z_vlocs(v-1):z_vlocs(v), D{fileIndex}.Chosen_mk(m)), ...
                D{fileIndex}.z(z_vlocs(v-1):z_vlocs(v), D{fileIndex}.Chosen_mk(m)), ...
                'LineWidth', 1, 'DisplayName', sprintf('Throw %d', throw_numbers(v)));
            hold on;
            frame_rate = 120;
            D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.throw_tp{v,:}= (z_vlocs(v-1):z_vlocs(v)) / frame_rate;
        end
        % Check if z_vlocs is the last data point
        if z_vlocs(1) ~= 1
            disp('first throw not complete');
        end
        if z_vlocs(end) ~= length(D{fileIndex}.z)
            disp('Last throw not complete');
        end
    end
    
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    xlim([min(D{fileIndex}.x(:)), max(D{fileIndex}.x(:))]);
    ylim([min(D{fileIndex}.y(:)), max(D{fileIndex}.y(:))]);
    zlim([min(D{fileIndex}.z(:)), max(D{fileIndex}.z(:))]);
    grid on;
    
    legend('Location', 'best');
    
    title(arrayfun(@(m) D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.MarkerName, 1:length(D{fileIndex}.Chosen_mk), 'UniformOutput', false), 'Interpreter', 'none');
    figureName = sprintf('colouredMarkerTraj_D%d.fig', fileIndex);
    outputFolder = '/Users/yilinwu/Desktop/nic/Vicon/plot/markers throw Trajectory/';
    saveas(figure(1), fullfile(outputFolder, figureName));
end