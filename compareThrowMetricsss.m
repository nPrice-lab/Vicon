function compareThrowMetricsss(D, markerIndices)


% compareThrowMetrics(D, [2, 14], 3);
markerIndices=[2, 14];

% Iterate over markers
for k = 1:length(markerIndices)    
    figure;
    
    for m = 2:length(D.markers{markerIndices(k)}.throw_data)
        cd(:, m) = D.markers{markerIndices(k)}.throw_data{m}.CD;
        plot(cd)
        hold on
    end
    
    legendStrings = cell(1, length(D.markers{markerIndices(k)}.throw_data) - 1);
    for m = 2:length(D.markers{markerIndices(k)}.throw_data)
        P_HV(:, m) = D.markers{markerIndices(k)}.throw_data{m}.P_HV;
        plot(P_HV)
        hold on
        legendStrings{m-1} = ['Throw', num2str(m)];
    end
    
    legend(legendStrings);
    title(['Peak Hand Speed - Marker ', num2str(markerIndices(k))]);
end

% Repeat the above process for other metrics (P_HA, M_HR, C_D) if needed.
