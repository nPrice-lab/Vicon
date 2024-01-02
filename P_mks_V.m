function P_mks_V(D);
%% Input Validations
assert(length(D.colors) == D.MarkersCount, 'Number of colors should be equal to the number of markers.');

%% Setup video writing
VideoPath=fullfile('/Users/yilinwu/Desktop/nic/Vicon/output video/', 'MarkersVideo.mp4');
MarkersVideo = VideoWriter(VideoPath,'MPEG-4');
MarkersVideo.FrameRate = 120;
open(MarkersVideo);

%% Create a cell array to store plot objects for each marker
fig = figure;
objPlot = cell(1,length(D.Chosen_mk));
for m = 1:length(D.Chosen_mk)
    objPlot{m} = plot3(NaN, NaN, NaN, '.', 'MarkerFaceColor', D.colors(m,:));
    hold on; % Hold the plot to overlay markers
end
hold off; % Release the hold after plotting all markers
legend(arrayfun(@(m) D.markers{D.Chosen_mk(m)}.MarkerName, 1:length(D.Chosen_mk), 'UniformOutput', false), 'Interpreter', 'none');


%% plot selected markers Trajectory during trial with different color (moving video saved)

for t = D.sF:D.eF
    for m = 1:length(D.Chosen_mk)
        % plot x, y z, for one frame for one markers
        set(objPlot{m}, 'XData', D.x(t, D.Chosen_mk(m)), 'YData', D.y(t, D.Chosen_mk(m)), 'ZData', D.z(t, D.Chosen_mk(m)), 'MarkerSize', 50);
    end
    
    xlim([min(D.x(:)), max(D.x(:))]);
    ylim([min(D.y(:)), max(D.y(:))]);
    zlim([min(D.z(:)), max(D.z(:))]);
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    title(['Frame: ', num2str(t)]); % Display current frame number as title
    grid on

    writeVideo(MarkersVideo, getframe(fig));
end
close(MarkersVideo);
