function markerTraj(D,files);
%% plot all markers Trajectory during trial (still picture)
for fileIndex = 1:length(files)
    % Define outputFolder before using it
    outputFolder = '/Users/yilinwu/Desktop/nic/Vicon/plot/all markers Trajectory/';
    
    f = D{fileIndex}.startTime*120 + 1:D{fileIndex}.endTime*120;
     % Extract file name from the full file path
    [~, fileName, ~] = fileparts(D{fileIndex}.filePath);

    figure;
    for m=1:length (D{fileIndex}.Chosen_mk)
        plot3(D{fileIndex}.x(f,D{fileIndex}.Chosen_mk(m)), ...
            D{fileIndex}.y(f,D{fileIndex}.Chosen_mk(m)), ...
            D{fileIndex}.z(f,D{fileIndex}.Chosen_mk(m)),LineWidth=1);
    
        xlim([min(D{fileIndex}.x(:)), max(D{fileIndex}.x(:))]);
        ylim([min(D{fileIndex}.y(:)), max(D{fileIndex}.y(:))]);
        zlim([min(D{fileIndex}.z(:)), max(D{fileIndex}.z(:))]);
        grid on
        hold on;
    end
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('all markers Trajectory File: ', fileName)
    legend(arrayfun(@(m) D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.MarkerName, 1:length(D{fileIndex}.Chosen_mk), 'UniformOutput', false), 'Interpreter', 'none');


    % Move the definition above the saveas calls
    figureName = sprintf('markerTraj_D%d.fig', fileIndex);  % Unique filename based on fileIndex
    saveas(figure(1), fullfile(outputFolder, figureName));
end