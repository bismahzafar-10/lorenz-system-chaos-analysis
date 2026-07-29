% RUN_SIMULATIONS Main driver script for Lorenz System Chaos Analysis
clear; clc; close all;

% Create output directories for assets
if ~exist('../assets/figures', 'dir')
    mkdir('../assets/figures');
end

%% 1. Parameter Definition & Integration Setup
sigma = 10.0;             % Prandtl number
rho   = 28.0;             % Rayleigh number
beta  = 8/3;              % Geometric aspect ratio[cite: 3]

tspan = [0 100];          % Time domain [0, 100][cite: 3]
dt = 0.01;                % Fixed time step resolution[cite: 3]
t_eval = tspan(1):dt:tspan(2);

% Solver options for high precision
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9);

%% 2. Reference State & Simulation
X0_ref = [1.0; 1.0; 1.0]; % Control reference vector (x0, y0, z0)[cite: 3]

[t_ref, X_ref] = ode45(@(t, X) lorenz_ode(t, X, sigma, rho, beta), ...
                       t_eval, X0_ref, options);

%% 3. Generate Perturbation Mesh Grid (Delta = 0.2)
delta = 0.2;              % Grid perturbation step[cite: 3]

% Perturbed initial conditions vector setup
perturbed_ICs = [
    1.0 + delta, 1.0,         1.0;          % Perturbed 1
    1.0,         1.0 + delta, 1.0;          % Perturbed 2
    1.0,         1.0,         1.0 + delta;  % Perturbed 3
    1.0 + delta, 1.0 + delta, 1.0;          % Perturbed 4
    1.0 - delta, 1.0,         1.0;          % Perturbed 5
    1.0,         1.0 - delta, 1.0 + delta   % Perturbed 6
];

num_pert = size(perturbed_ICs, 1);
X_pert_cell = cell(num_pert, 1);

for i = 1:num_pert
    IC_i = perturbed_ICs(i, :)';
    [~, X_p] = ode45(@(t, X) lorenz_ode(t, X, sigma, rho, beta), ...
                     t_eval, IC_i, options);
    X_pert_cell{i} = X_p;
end

%% 4. Calculate Empirical Lyapunov Exponent
[lambda, distance, log_distance] = lyapunov_exponent(t_eval, X_ref, X_pert_cell{1});

fprintf('======================================================\n');
fprintf('   LORENZ CHAOS QUANTIFICATION REPORT\n');
fprintf('======================================================\n');
fprintf('Calculated Empirical Lyapunov Exponent (lambda): %.4f\n', lambda);
fprintf('Paper Verified Reference Benchmark (lambda):     0.2135\n', 0.2135);[cite: 3]
fprintf('======================================================\n');

%% 5. Generate Figures
generate_figures(t_eval, X_ref, X_pert_cell, distance, log_distance, X0_ref, delta);
