function [lambda, distance, log_distance] = lyapunov_exponent(t, X_ref, X_pert)
% LYAPUNOV_EXPONENT Computes Euclidean distance and empirical Lyapunov exponent.
%
% Inputs:
%   t            - Time vector
%   X_ref        - Reference state matrix (N x 3)
%   X_pert       - Perturbed state matrix (N x 3)
%
% Outputs:
%   lambda       - Primary empirical Lyapunov exponent (slope of log-distance)
%   distance     - Euclidean separation distance vector
%   log_distance - Natural logarithm of Euclidean separation distance

    % 1. Calculate Euclidean spatial separation distance over time[cite: 3]
    diff = X_ref - X_pert;
    distance = sqrt(sum(diff.^2, 2));

    % 2. Take natural logarithm[cite: 3]
    % Avoid log(0) numerical anomalies by clipping minimum threshold
    dist_clipped = max(distance, 1e-16);
    log_distance = log(dist_clipped);

    % 3. Fit linear slope across early divergence region (t in [0, 30])
    fit_idx = (t >= 0.0) & (t <= 30.0);
    p = polyfit(t(fit_idx), log_distance(fit_idx)', 1);
    
    % Primary Lyapunov exponent is the slope[cite: 3]
    lambda = p(1);
end
