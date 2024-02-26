function D = PCA(D, files);
% Conducts Principal Component Analysis (PCA) on motion capture data stored in the cell array D.
% Iterates over each file specified in the files variable.
% Combines X, Y, Z coordinate data for chosen markers into a single matrix data.
% Performs PCA on data, extracting PCA coefficients, scores, eigenvalues, and explained variances.
% Plots the percentage of variance explained by each principal component.
% Visualizes the principal component scores in a scatter plot.
% Generates a biplot to display the contribution of each variable to the principal components.
% Compares marker data with reduced data in separate subplots.
% Saves each plot as a PNG file in the specified output folder.

% Define output folder
outputFolder = '/Users/yilinwu/Desktop/nic/Vicon/plot/PCA/';

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

    % Plot the percentage of variance explained by each principal component
    figure;
    pareto(explained);
    xlabel('Principal Component');
    ylabel('Variance Explained (%)');
    title('Variance Explained by Principal Components');
    % Save plot
    saveas(gcf, fullfile(outputFolder, ['Variance_Explained_File_', num2str(fileIndex), '.png']));
    
    % Plot the principal component scores to visualize the data in the reduced dimensional space
    figure;
    scatter(score(:,1), score(:,2), 25, D{fileIndex}.time(T), 'filled');
    xlabel('Principal Component 1');
    ylabel('Principal Component 2');
    title('Principal Component Scores');
    colormap('jet');
    colorbar;
    % Save plot
    saveas(gcf, fullfile(outputFolder, ['Principal_Component_Scores_File_', num2str(fileIndex), '.png']));

    % Create labels for each row of the coefficients matrix
    labels = cellstr(num2str((1:size(coeff,1))', 'Dimension %d'));
    
    % Plot biplot
    figure;
    biplot(coeff(:,1:2),'Scores',score(:,1:2),'VarLabels',labels);
    xlabel('Principal Component 1');
    ylabel('Principal Component 2');
    title('Biplot of PCA');
    % Save plot
    saveas(gcf, fullfile(outputFolder, ['Biplot_File_', num2str(fileIndex), '.png']));

    % Plot marker data and reduced data
    num_markers = numel(D{fileIndex}.Chosen_mk);
    figure;
    for a = 1:num_markers
        subplot(num_markers, 2, 2 * a - 1)
        plot(D{fileIndex}.time(T), data(:, (a-1)*3+1:a*3))
        ylabel(['Marker Data (', num2str(D{fileIndex}.Chosen_mk(a)), ')'])
        title('Inputs')
        legend(cellstr(num2str((1:3)', 'Dimension %d')), 'Location', 'Best'); % Add legend
    
        subplot(num_markers, 2, 2 * a)
        plot(D{fileIndex}.time(T), score(:, (a-1)*3+1:a*3))
        ylabel(['Reduced Data (', num2str(D{fileIndex}.Chosen_mk(a)), ')'])
        title('Outputs')
        legend(cellstr(num2str((1:3)', 'Dimension %d')), 'Location', 'Best'); % Add legend
    end
    % Save plot
    saveas(gcf, fullfile(outputFolder, ['Marker_Reduced_Data_File_', num2str(fileIndex), '.png']));
    

end
