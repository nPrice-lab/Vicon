function D = valleyAndPeak(D,files);

for fileIndex = 1:length(files)

    for m = 1:length(D{fileIndex}.Chosen_mk)
        figure;
        F = D{fileIndex}.startTime*120+1:D{fileIndex}.endTime*120;
        T= D{fileIndex}.time(D{fileIndex}.startTime*120+1:D{fileIndex}.endTime*120);

        subplot(3,1,1);
        x = -D{fileIndex}.x(F,D{fileIndex}.Chosen_mk(m));
        [x_valley, x_vlocs] = findpeaks(x, F);

        D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.x_valley=x_valley;
        D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.x_vlocs=x_vlocs;


        % Plotting the original data and the identified valleys
        plot(T, -x); % Plotting the negated data
        hold on;
        plot(D{fileIndex}.time(D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.x_vlocs), -D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.x_valley, 'ro', 'MarkerSize', 10);
        xlabel('Time');
        ylabel('x');
        title(D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.MarkerName, 'Interpreter', 'none');
        % Adding legend to the plot
        legend('Original Data', 'Found Valleys');

        subplot(3,1,2);
        y = -D{fileIndex}.y(F,D{fileIndex}.Chosen_mk(m));
        [y_valley, y_vlocs] = findpeaks(y, F);
        D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.y_valley=y_valley;
        D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.y_vlocs=y_vlocs;
        plot(T, -y);
        hold on;
        plot(D{fileIndex}.time(D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.y_vlocs), -D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.y_valley, 'ro', 'MarkerSize', 10);
        xlabel('Time');
        ylabel('y');
        legend('Original Data', 'Found Valleys');

        subplot(3,1,3);
        z = -D{fileIndex}.z(F,D{fileIndex}.Chosen_mk(m)); % Negating the data to find valleys
        [z_valley, z_vlocs] = findpeaks(z, F);
        D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_valley=z_valley;
        D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_vlocs=z_vlocs;
        plot(T, -z);
        hold on;
        plot(D{fileIndex}.time(D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_vlocs), -D{fileIndex}.markers{D{fileIndex}.Chosen_mk(m)}.z_valley, 'ro', 'MarkerSize', 10);
        xlabel('Time');
        ylabel('z');
        legend('Original Data', 'Found Valleys');

    end
end