function D = P_1D_peak(D)
    for m = 1:length(D.Chosen_mk)
        figure;
        F = D.sF:D.eF;

        subplot(3,1,1);
        x = D.x(D.sF:D.eF,D.Chosen_mk(m));
        [xpks, xlocs] = findpeaks(x, F);
        D.markers{D.Chosen_mk(m)}.xpks=xpks;
        D.markers{D.Chosen_mk(m)}.xlocs=xlocs;
        plot(F, x);
        hold on;
        plot(F(D.markers{D.Chosen_mk(m)}.xlocs), D.markers{D.Chosen_mk(m)}.xpks, 'ro', 'MarkerSize', 10);
        xlabel('Frame');
        ylabel('x');
        title(D.markers{D.Chosen_mk(m)}.MarkerName, 'Interpreter', 'none');
        legend('Original Data', 'Found Peaks');

        subplot(3,1,2);
        y = D.y(D.sF:D.eF,D.Chosen_mk(m));
        [ypks, ylocs] = findpeaks(y, F);
        D.markers{D.Chosen_mk(m)}.ypks=ypks;
        D.markers{D.Chosen_mk(m)}.ylocs=ylocs;
        plot(F, y);
        hold on;
        plot(F(D.markers{D.Chosen_mk(m)}.ylocs), D.markers{D.Chosen_mk(m)}.ypks, 'ro', 'MarkerSize', 10);
        xlabel('Frame');
        ylabel('y');
        legend('Original Data', 'Found Peaks');

        subplot(3,1,3);
        z = D.z(D.sF:D.eF,D.Chosen_mk(m));
        [zpks, zlocs] = findpeaks(z, F);
        D.markers{D.Chosen_mk(m)}.zpks=zpks;
        D.markers{D.Chosen_mk(m)}.zlocs=zlocs;
        plot(F, z);
        hold on;
        plot(F(D.markers{D.Chosen_mk(m)}.zlocs), D.markers{D.Chosen_mk(m)}.zpks, 'ro', 'MarkerSize', 10);
        xlabel('Frame');
        ylabel('z');
        legend('Original Data', 'Found Peaks');
    end
end

