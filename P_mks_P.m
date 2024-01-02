function P_mks_P(D);
%% plot all markers Trajectory during trial (still picture)
figure;
for m=1:length (D.Chosen_mk)
    plot3(D.x(:,D.Chosen_mk(m)),D.y(:,D.Chosen_mk(m)),D.z(:,D.Chosen_mk(m)),LineWidth=5);

    xlim([min(D.x(:)), max(D.x(:))]);
    ylim([min(D.y(:)), max(D.y(:))]);
    zlim([min(D.z(:)), max(D.z(:))]);
    grid on
    hold on;
end
xlabel('X');
ylabel('Y');
zlabel('Z');
title('all markers Trajectory')
legend(arrayfun(@(m) D.markers{D.Chosen_mk(m)}.MarkerName, 1:length(D.Chosen_mk), 'UniformOutput', false), 'Interpreter', 'none');
saveas(figure(1),['/Users/yilinwu/Desktop/nic/Vicon/plot/all markers Trajectory/all markers Trajectory.fig']);
