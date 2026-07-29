function generate_figures(t, X_ref, X_pert_cell, distance, log_distance, X0_ref, delta)
% GENERATE_FIGURES Generates and exports all figures to assets/figures/

    set(0, 'DefaultAxesFontName', 'Helvetica');
    set(0, 'DefaultAxesFontSize', 10);
    
    output_dir = '../assets/figures/';

    %% Figure 1: Spatial Grid of Initial Conditions[cite: 3]
    fig1 = figure('Visible', 'off', 'Position', [100, 100, 700, 550]);
    [gx, gy, gz] = meshgrid(X0_ref(1)-0.2:0.1:X0_ref(1)+0.2, ...
                            X0_ref(2)-0.2:0.1:X0_ref(2)+0.2, ...
                            X0_ref(3)-0.2:0.1:X0_ref(3)+0.2);
    plot3(gx(:), gy(:), gz(:), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 4); hold on;
    plot3(X0_ref(1), X0_ref(2), X0_ref(3), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title('Reference Initial Conditions and Perturbations');[cite: 3]
    legend({'Perturbed Initial Conditions', 'Reference Initial Condition'}, 'Location', 'northeast');[cite: 3]
    grid on; view(3);
    saveas(fig1, [output_dir, 'Figure1_Reference_Initial_Conditions_and_Perturbations.png']);

    %% Figure 2: Time Series Plots[cite: 3]
    fig2 = figure('Visible', 'off', 'Position', [100, 100, 750, 600]);
    subplot(3,1,1); plot(t, X_ref(:,1), 'b'); ylabel('x'); title('x(t)'); grid on;[cite: 3]
    subplot(3,1,2); plot(t, X_ref(:,2), 'b'); ylabel('y'); title('y(t)'); grid on;[cite: 3]
    subplot(3,1,3); plot(t, X_ref(:,3), 'b'); ylabel('z'); title('z(t)'); xlabel('Time'); grid on;[cite: 3]
    saveas(fig2, [output_dir, 'Figure2_Time_series_data.png']);

    %% Figure 3: Dual Trajectory Attractor[cite: 3]
    fig3 = figure('Visible', 'off', 'Position', [100, 100, 700, 550]);
    plot3(X_ref(:,1), X_ref(:,2), X_ref(:,3), 'b-', 'LineWidth', 0.6); hold on;[cite: 3]
    plot3(X_pert_cell{1}(:,1), X_pert_cell{1}(:,2), X_pert_cell{1}(:,3), 'r-', 'LineWidth', 0.5);[cite: 3]
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title('Lorenz System Trajectories');[cite: 3]
    legend({'Initial Condition 1', 'Initial Condition 2'}, 'Location', 'southeast');[cite: 3]
    grid on; view(3);
    saveas(fig3, [output_dir, 'Figure3_Lorenz_System_Trajectories.png']);

    %% Figure 4: Euclidean Separation Distance[cite: 3]
    fig4 = figure('Visible', 'off', 'Position', [100, 100, 700, 400]);
    plot(t, distance, 'b-', 'LineWidth', 0.8);
    xlabel('Time'); ylabel('Distance');[cite: 3]
    title('Distance between Original and Perturbed Trajectories');[cite: 3]
    xlim([0 100]); grid on;[cite: 3]
    saveas(fig4, [output_dir, 'Figure4_Distance_between_Original_and_Perturbed_Trajectories.png']);

    %% Figure 5: Natural Logarithm Distance Plot[cite: 3]
    fig5 = figure('Visible', 'off', 'Position', [100, 100, 700, 400]);
    plot(t, log_distance, 'b-', 'LineWidth', 0.8);
    xlabel('Time'); ylabel('Log(Distance)');[cite: 3]
    title('Log of Distance between Original and Perturbed Trajectories');[cite: 3]
    xlim([0 100]); grid on;[cite: 3]
    saveas(fig5, [output_dir, 'Figure5_Log_of_Distance_between_Original_and_Perturbed_Trajectories.png']);

    %% Figure 6: Multi-Perturbation Trajectory Ensemble[cite: 3]
    fig6 = figure('Visible', 'off', 'Position', [100, 100, 700, 550]);
    plot3(X_ref(:,1), X_ref(:,2), X_ref(:,3), 'b-', 'LineWidth', 0.8, 'DisplayName', 'Original'); hold on;[cite: 3]
    for k = 1:length(X_pert_cell)
        plot3(X_pert_cell{k}(:,1), X_pert_cell{k}(:,2), X_pert_cell{k}(:,3), ...
              'LineWidth', 0.4, 'DisplayName', sprintf('Perturbed %d', k));[cite: 3]
    end
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title('Lorenz System Trajectories with Perturbations');[cite: 3]
    legend('Location', 'southeast');[cite: 3]
    grid on; view(3);
    saveas(fig6, [output_dir, 'Figure6_Lorenz_System_Trajectories_with_Perturbations.png']);

    close all;
end
