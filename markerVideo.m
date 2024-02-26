function markerVideo(D,files);

for fileIndex = 1:length(files)

    %% Input Validations
    assert(length(D{fileIndex}.colors) == D{fileIndex}.MarkersCount, 'Number of colors should be equal to the number of markers.');

    %% Setup video writing
    outputFolder = '/Users/yilinwu/Desktop/nic/Vicon/output video/';
    videoFilename = sprintf('MarkersVideo_D%d.mp4', fileIndex);  % Unique filename based on fileIndex
    VideoPath = fullfile(outputFolder, videoFilename);

    MarkersVideo = VideoWriter(VideoPath, 'MPEG-4');
    MarkersVideo.FrameRate = 120;
    open(MarkersVideo);
    %% Create a cell array to store plot objects for each marker
    fig = figure;
    objPlot = cell(1,length(D{fileIndex}.Chosen_mk));
    for m = 1:length(D{fileIndex}.Chosen_mk)
        objPlot{m} = plot3(NaN, NaN, NaN, '.', 'MarkerFaceColor', D{fileIndex}.colors(m,:));
        hold on; % Hold the plot to overlay markers
    end
    hold off; % Release the hold after plotting all markers
    legend(arrayfun(@(m) D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.MarkerName, 1:length(D{fileIndex}.Chosen_mk), 'UniformOutput', false), 'Interpreter', 'none');


    %% plot selected markers Trajectory during trial with different color (moving video saved)
    for f = D{fileIndex}.startTime*120+1:D{fileIndex}.endTime*120
        for m = 1:length(D{fileIndex}.Chosen_mk)
            % plot x, y z, for one frame for one markers
            set(objPlot{m}, 'XData', D{fileIndex}.x(f, D{fileIndex}.Chosen_mk(m)), 'YData', D{fileIndex}.y(f, D{fileIndex}.Chosen_mk(m)), 'ZData', D{fileIndex}.z(f, D{fileIndex}.Chosen_mk(m)), 'MarkerSize', 50);
        end

        xlim([min(D{fileIndex}.x(:)), max(D{fileIndex}.x(:))]);
        ylim([min(D{fileIndex}.y(:)), max(D{fileIndex}.y(:))]);
        zlim([min(D{fileIndex}.z(:)), max(D{fileIndex}.z(:))]);
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        title(['Time(s):', num2str(f/120)]); % Display current frame number as title
        grid on

        writeVideo(MarkersVideo, getframe(fig));
    end
    close(MarkersVideo);
end