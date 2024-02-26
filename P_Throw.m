%% plot colour code trajectories according to throw number
function P_Throw(D)

figure;
% Assuming D.markers contains information for all markers
for m = 1:length(D.Chosen_mk)

    z_vlocs = D.markers{D.Chosen_mk(m)}.z_vlocs;
    throw_numbers = 1:length(z_vlocs);

    % Iterate through each throw
    for v = 1:length(z_vlocs)
        if v == 1
            % Plot the entire trajectory up to the first valley point
            plot3(D.x(1:z_vlocs(v), D.Chosen_mk(m)), ...
                D.y(1:z_vlocs(v), D.Chosen_mk(m)), ...
                D.z(1:z_vlocs(v), D.Chosen_mk(m)), ...
                'LineWidth', 1, 'DisplayName', sprintf('Throw %d', throw_numbers(v)));
            hold on;
        else
            % Plot from the previous valley point to the current one
            plot3(D.x(z_vlocs(v-1):z_vlocs(v), D.Chosen_mk(m)), ...
                D.y(z_vlocs(v-1):z_vlocs(v), D.Chosen_mk(m)), ...
                D.z(z_vlocs(v-1):z_vlocs(v), D.Chosen_mk(m)), ...
                'LineWidth', 1, 'DisplayName', sprintf('Throw %d', throw_numbers(v)));
            hold on;
        end
    end
end

xlabel('X');
ylabel('Y');
zlabel('Z');
xlim([min(D.x(:)), max(D.x(:))]);
ylim([min(D.y(:)), max(D.y(:))]);
zlim([min(D.z(:)), max(D.z(:))]);
grid on;

legend('Location', 'best');

title(arrayfun(@(m) D.markers{D.Chosen_mk(m)}.MarkerName, 1:length(D.Chosen_mk), 'UniformOutput', false), 'Interpreter', 'none');
saveas(figure(1),['/Users/yilinwu/Desktop/nic/Vicon/plot/markers throw Trajectory/markers throw Trajectory.fig']);

