function D = P_1D_valley_with_Kalman(D)

% Kalman filter parameters
A = 1;  % State transition matrix
H = 1;  % Measurement matrix
Q = 0.01;  % Process noise covariance
R = 0.1;  % Measurement noise covariance
x_est = zeros(length(D.sF:D.eF), 1);  % Initial state estimate
P_est = ones(length(D.sF:D.eF), 1);  % Initial error covariance estimate

for m = 1:length(D.Chosen_mk)
    figure;
    F = D.sF:D.eF;

    % Kalman filter for x dimension
    x = -D.x(D.sF:D.eF,D.Chosen_mk(m));
    [x_valley, x_vlocs] = findpeaks(x, F);
    [x_est, P_est] = kalman_filter(x, A, H, Q, R, x_valley, x_vlocs);

    subplot(3,1,1);
    plot(F, -x);
    hold on;
    plot(F(D.markers{D.Chosen_mk(m)}.x_vlocs), -D.markers{D.Chosen_mk(m)}.x_valley, 'ro', 'MarkerSize', 10);
    plot(F, -x_est, 'g', 'LineWidth', 2);
    xlabel('Frame');
    ylabel('x');
    title(D.markers{D.Chosen_mk(m)}.MarkerName, 'Interpreter', 'none');
    legend('Original Data', 'Found Valleys', 'Kalman Filter');

    % Kalman filter for y dimension
    y = -D.y(D.sF:D.eF,D.Chosen_mk(m));
    [y_valley, y_vlocs] = findpeaks(y, F);
    [y_est, ~] = kalman_filter(y, A, H, Q, R, y_valley, y_vlocs);

    subplot(3,1,2);
    plot(F, -y);
    hold on;
    plot(F(D.markers{D.Chosen_mk(m)}.y_vlocs), -D.markers{D.Chosen_mk(m)}.y_valley, 'ro', 'MarkerSize', 10);
    plot(F, -y_est, 'g', 'LineWidth', 2);
    xlabel('Frame');
    ylabel('y');
    legend('Original Data', 'Found Valleys', 'Kalman Filter');

    % Kalman filter for z dimension
    z = -D.z(D.sF:D.eF,D.Chosen_mk(m));
    [z_valley, z_vlocs] = findpeaks(z, F);
    [z_est, ~] = kalman_filter(z, A, H, Q, R, z_valley, z_vlocs);

    subplot(3,1,3);
    plot(F, -z);
    hold on;
    plot(F(D.markers{D.Chosen_mk(m)}.z_vlocs), -D.markers{D.Chosen_mk(m)}.z_valley, 'ro', 'MarkerSize', 10);
    plot(F, -z_est, 'g', 'LineWidth', 2);
    xlabel('Frame');
    ylabel('z');
    legend('Original Data', 'Found Valleys', 'Kalman Filter');

end

end

function [estimates, covariances] = kalman_filter(measurements, A, H, Q, R, initial_estimate, initial_covariance)
    % Kalman filter implementation
    n = length(measurements);
    estimates = zeros(n, 1);
    covariances = zeros(n, 1);
    x_hat = initial_estimate;
    P_hat = initial_covariance;

    for k = 1:n
        % Prediction
        x_hat_minus = A * x_hat;
        P_minus = A * P_hat * A' + Q;

        % Update
        K = P_minus * H' / (H * P_minus * H' + R);
        x_hat = x_hat_minus + K * (measurements(k) - H * x_hat_minus);
        P_hat = (1 - K * H) * P_minus;

        estimates(k) = x_hat;
        covariances(k) = P_hat;
    end
end
