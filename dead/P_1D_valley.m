function D = P_1D_valley(D)

for m = 1:length(D.Chosen_mk)
    figure;
    F = D.sF:D.eF;

    subplot(3,1,1);
    x = -D.x(D.sF:D.eF,D.Chosen_mk(m)); % Negating the data to find valleys
    % Finding peaks (valleys in the original data)
    [x_valley, x_vlocs] = findpeaks(x, F);
    D.markers{D.Chosen_mk(m)}.x_valley=x_valley;
    D.markers{D.Chosen_mk(m)}.x_vlocs=x_vlocs;
    % Plotting the original data and the identified valleys
    plot(F, -x); % Plotting the negated data
    hold on;
    plot(F(D.markers{D.Chosen_mk(m)}.x_vlocs), -D.markers{D.Chosen_mk(m)}.x_valley, 'ro', 'MarkerSize', 10);
    xlabel('Frame');
    ylabel('x');
    title(D.markers{D.Chosen_mk(m)}.MarkerName, 'Interpreter', 'none');
    % Adding legend to the plot
    legend('Original Data', 'Found Valleys');

    subplot(3,1,2);
    y = -D.y(D.sF:D.eF,D.Chosen_mk(m)); % Negating the data to find valleys
    [y_valley, y_vlocs] = findpeaks(y, F);
    D.markers{D.Chosen_mk(m)}.y_valley=y_valley;
    D.markers{D.Chosen_mk(m)}.y_vlocs=y_vlocs;
    plot(F, -y);
    hold on;
    plot(F(D.markers{D.Chosen_mk(m)}.y_vlocs), -D.markers{D.Chosen_mk(m)}.y_valley, 'ro', 'MarkerSize', 10);
    xlabel('Frame');
    ylabel('y');
    legend('Original Data', 'Found Valleys');

    subplot(3,1,3);
    z = -D.z(D.sF:D.eF,D.Chosen_mk(m)); % Negating the data to find valleys
    [z_valley, z_vlocs] = findpeaks(z, F);
    D.markers{D.Chosen_mk(m)}.z_valley=z_valley;
    D.markers{D.Chosen_mk(m)}.z_vlocs=z_vlocs;
    plot(F, -z);
    hold on;
    plot(F(D.markers{D.Chosen_mk(m)}.z_vlocs), -D.markers{D.Chosen_mk(m)}.z_valley, 'ro', 'MarkerSize', 10);
    xlabel('Frame');
    ylabel('z');
    legend('Original Data', 'Found Valleys');

end
