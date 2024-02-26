function D = dataFilter(D,windowSize,files);
%% filter the raw X, Y, and Z coordinates of markers windowSize filter
% save the filtered data in the same data structure. 
% plots the raw and filtered data for each marker separately in three separate figures 
% (one for X, one for Y, and one for Z).

b = (1/windowSize) * ones(1, windowSize);
a = 1;

for fileIndex = 1:length(files)

    for m = 1:D{fileIndex}.MarkersCount

        % Apply filter only to valid, finite data
        validIndices = isfinite(D{fileIndex}.markers{m}.rawX) & isfinite(D{fileIndex}.markers{m}.rawY) & isfinite(D{fileIndex}.markers{m}.rawZ);

        % Initialize filtered data with NaN
        D{fileIndex}.markers{m}.x = NaN(size(D{fileIndex}.markers{m}.rawX));
        D{fileIndex}.markers{m}.y = NaN(size(D{fileIndex}.markers{m}.rawY));
        D{fileIndex}.markers{m}.z = NaN(size(D{fileIndex}.markers{m}.rawZ));
    
        % Apply filter to valid indices
        D{fileIndex}.markers{m}.x(validIndices) = filtfilt(b, a, D{fileIndex}.markers{m}.rawX(validIndices));
        D{fileIndex}.markers{m}.y(validIndices) = filtfilt(b, a, D{fileIndex}.markers{m}.rawY(validIndices));
        D{fileIndex}.markers{m}.z(validIndices) = filtfilt(b, a, D{fileIndex}.markers{m}.rawZ(validIndices));
    
        % Save all 6 markers in variables x, y, z 
        D{fileIndex}.x(:,m) = D{fileIndex}.markers{m}.x;
        D{fileIndex}.y(:,m) = D{fileIndex}.markers{m}.y;
        D{fileIndex}.z(:,m) = D{fileIndex}.markers{m}.z;
    
    end

end


