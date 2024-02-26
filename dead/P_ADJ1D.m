function D = P_ADJ1D(D);



for m = 1:length(D.Chosen_mk)

    D.markers{D.Chosen_mk(m)}.ADJx=D.x(D.sF:D.eF,D.Chosen_mk(m))-D.x(1,D.Chosen_mk(m));
    D.markers{D.Chosen_mk(m)}.ADJy=D.y(D.sF:D.eF,D.Chosen_mk(m))-D.y(1,D.Chosen_mk(m));
    D.markers{D.Chosen_mk(m)}.ADJz=D.z(D.sF:D.eF,D.Chosen_mk(m))-D.z(1,D.Chosen_mk(m));
end

for m = 1:length(D.Chosen_mk)
    figure;

    subplot(3,1,1);
    plot(D.markers{D.Chosen_mk(m)}.ADJx);
    findpeaks(D.markers{D.Chosen_mk(m)}.ADJx)
    xlabel('Frame')
    ylabel('x')
    grid on
    title(D.markers{D.Chosen_mk(m)}.MarkerName, 'Interpreter', 'none');

    subplot(3,1,2);
    plot(D.markers{D.Chosen_mk(m)}.ADJy);
    findpeaks(D.markers{D.Chosen_mk(m)}.ADJy)
    xlabel('Frame')
    ylabel('y')
    grid on


    subplot(3,1,3);
    plot(D.markers{D.Chosen_mk(m)}.ADJz);
    findpeaks(D.markers{D.Chosen_mk(m)}.ADJz)
    xlabel('Frame')
    ylabel('z')
    grid on

end
