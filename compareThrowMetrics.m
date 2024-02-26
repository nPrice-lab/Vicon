function compareThrowMetrics(D);

figure;
for m=2:length(D.markers{2}.throw_data)
    cd2(:,m)=D.markers{2}.throw_data{m}.CD;
    cd14(:,m)=D.markers{14}.throw_data{m}.CD;
    plot(cd2)
    hold on
    plot(cd14)
    legend('cd2','cd14');
    title('cycle duratioddn');
end

figure;
for m=2:length(D.markers{2}.throw_data)
    P_HV2(:,m)=D.markers{2}.throw_data{m}.P_HV;
    P_HV14(:,m)=D.markers{14}.throw_data{m}.P_HV;
    plot(P_HV2)
    hold on
    plot(P_HV14)
    legend('P_HV2','P_HV14');
    title('peak hand speed');
end

figure;
for m=2:length(D.markers{2}.throw_data)
    P_HA2(:,m)=D.markers{2}.throw_data{m}.P_HA;
    P_HA14(:,m)=D.markers{14}.throw_data{m}.P_HA;
    plot(P_HA2)
    hold on
    plot(P_HA14)
    legend('P_HA2','P_HA14');
    title('peak hand acceleration');
end

figure;
for m=2:length(D.markers{2}.throw_data)
    M_HR2(:,m)=D.markers{2}.throw_data{m}.M_HR;
    M_HR14(:,m)=D.markers{14}.throw_data{m}.M_HR;
    plot(M_HR2)
    hold on
    plot(M_HR14)
    legend('M_HR2','M_HR14');
    title('maximum hand range');
end

figure;
for m=2:length(D.markers{2}.throw_data)
    C_D2(:,m)=D.markers{2}.throw_data{m}.C_D;
    C_D14(:,m)=D.markers{14}.throw_data{m}.C_D;
    plot(C_D2)
    hold on
    plot(C_D14)
    legend('C_D2','C_D14');
    title('cycle distance');
end