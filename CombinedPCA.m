function D = CombinedPCA(D, files);


% Define output folder
outputFolder = '/Users/yilinwu/Desktop/nic/Vicon/plot/PCA/';

% Create a new figure to combine all plots
combinedFig = figure;

% Iterate over each file
for fileIndex = 1:length(files)    
    % Combine X, Y, Z data into a single matrix
    idx = D{fileIndex}.startTime * 120 + 1:D{fileIndex}.endTime * 120;
    T = idx(1):idx(end);

    data = [];
    for mk = D{fileIndex}.Chosen_mk
        data = [data, D{fileIndex}.x(T,mk), D{fileIndex}.y(T,mk), D{fileIndex}.z(T,mk)];
    end

    % Perform PCA
    [coeff, score, latent, ~, explained] = pca(data);

    % Save PCA values in D.{fileIndex}.PCA
    D{fileIndex}.PCA.data=data;
    D{fileIndex}.PCA.coeff = coeff;
    D{fileIndex}.PCA.score = score;
    D{fileIndex}.PCA.latent = latent;
    D{fileIndex}.PCA.explained = explained;


    nSubplot=3+2*length(D{fileIndex}.Chosen_mk); % Update number of subplots
    
    % Plot the percentage of variance explained by each principal component
    subplot(length(files), nSubplot, (fileIndex-1)*nSubplot + 1, 'Parent', combinedFig);
    pareto(explained);
    xlabel('Principal Component');
    ylabel('Variance Explained (%)');
    title(['Variance Explained by PC - File ', num2str(fileIndex)]);

    % Plot the principal component scores to visualize the data in the reduced dimensional space
    subplot(length(files), nSubplot, (fileIndex-1)*nSubplot + 2, 'Parent', combinedFig);
    scatter(score(:,1), score(:,2), 5, D{fileIndex}.time(T), 'filled');
    xlabel('Principal Component 1');
    ylabel('Principal Component 2');
    title(['Principal Component Scores - File ', num2str(fileIndex)]);
    colormap('jet');
    colorbar;

    % Plot biplot
    % Create labels for each row of the coefficients matrix
    labels = cellstr(num2str((1:size(coeff,1))', 'Dimension %d'));
    subplot(length(files), nSubplot, (fileIndex-1)*nSubplot + 3, 'Parent', combinedFig);
    biplot(coeff(:,1:2),'Scores',score(:,1:2),'VarLabels',labels,'MarkerSize',5);
    xlabel('Principal Component 1');
    ylabel('Principal Component 2');
    title(['Biplot of PCA - File ', num2str(fileIndex)]);

    % Plot marker data and reduced data for each marker separately
    for a = 1:length(D{fileIndex}.Chosen_mk)
        % Plot marker data
        subplot(length(files), nSubplot, (fileIndex-1)*nSubplot + 4 + 2*(a-1), 'Parent', combinedFig);
        plot(D{fileIndex}.time(T), data(:, (a-1)*3+1:a*3), 'DisplayName', ['Marker Data (', num2str(D{fileIndex}.Chosen_mk(a)), ')']);
        ylabel('Marker Data');
        xlabel('Time');
        title(['Marker Data - Marker ', num2str(D{fileIndex}.Chosen_mk(a))]);
        legend('Location', 'Best');

        % Plot reduced data
        subplot(length(files), nSubplot, (fileIndex-1)*nSubplot + 4 + 2*(a-1) + 1, 'Parent', combinedFig);
        plot(D{fileIndex}.time(T), score(:, (a-1)*3+1:a*3), 'DisplayName', ['Reduced Data (', num2str(D{fileIndex}.Chosen_mk(a)), ')']);
        ylabel('Reduced Data');
        xlabel('Time');
        title(['Reduced Data - Marker ', num2str(D{fileIndex}.Chosen_mk(a))]);
        legend('Location', 'Best');
    end

end

% Save the combined figure
saveas(combinedFig, fullfile(outputFolder, 'Combined_Plots.png'));


