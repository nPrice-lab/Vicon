function D = plotFiltered(D, files)

for fileIndex = 1:length(files)
    
    % Extract file name from the full file path
    [~, fileName, ~] = fileparts(D{fileIndex}.filePath);

    % Plot X-axis
    figure;
    for m = 1:D{fileIndex}.MarkersCount
        subplot(4, 6, m)
        plot(D{fileIndex}.time, D{fileIndex}.markers{m}.rawX())
        hold on
        plot(D{fileIndex}.time, D{fileIndex}.markers{m}.x())
        legend('Input Data', 'Filtered Data');
        title(['Marker ', num2str(m)]);
        xlabel('Time');
        ylabel('x');
    end
    sgtitle(['File: ', fileName]);

    % Plot Y-axis
    figure;
    for m = 1:D{fileIndex}.MarkersCount
        subplot(4, 6, m)
        plot(D{fileIndex}.time, D{fileIndex}.markers{m}.rawY())
        hold on
        plot(D{fileIndex}.time, D{fileIndex}.markers{m}.y())
        legend('Input Data', 'Filtered Data');
        title(['Marker ', num2str(m)]);
        xlabel('Time');
        ylabel('y');
    end
    sgtitle(['File: ', fileName]);

    % Plot Z-axis
    figure;
    for m = 1:D{fileIndex}.MarkersCount
        subplot(4, 6, m)
        plot(D{fileIndex}.time, D{fileIndex}.markers{m}.rawZ())
        hold on
        plot(D{fileIndex}.time, D{fileIndex}.markers{m}.z())
        legend('Input Data', 'Filtered Data');
        title(['Marker ', num2str(m)]);
        xlabel('Time');
        ylabel('z');
    end
    sgtitle(['File: ', fileName]);
end
