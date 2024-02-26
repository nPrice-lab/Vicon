% PCAdemo
% demonstration of how Principal Components Analysis performs
% dimensionality reduction

% we start with a 4-dimensional dataset (e.g. four time-series datasets)
% perform PCA
% and then plot the output 4-dimensional dataset to illustrate how the
% first dimensions account for most of the variance in the original data

f1 = 3; % (Hz) frequency
f2 = 5;

t = 0:0.001:4; % (s) time vector

x(:,1) = 4*sin(2*pi*f1*t) + randn(size(t));
x(:,2) = 6*sin(2*pi*f2*t) + randn(size(t));
x(:,3) = 2*sin(2*pi*f1*t) + 3*sin(2*pi*f2*t) + randn(size(t));
x(:,4) = randn(size(t));

%% PCA

[~,y] = pca(x);


%% PLOTTING
figure
for a = 1:4
    subplot(4,2,2*a-1)
    plot(t,x(:,a))
    ylabel(sprintf('x(:,%d)',a))

    subplot(4,2,2*a)
    plot(t,y(:,a))
    ylabel(sprintf('y(:,%d)',a))
end

subplot(4,2,1)
title('Inputs')
subplot(4,2,2)
title('Outputs')