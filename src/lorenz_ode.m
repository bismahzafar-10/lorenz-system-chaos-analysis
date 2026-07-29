function dXdt = lorenz_ode(t, X, sigma, rho, beta)
% LORENZ_ODE Defines the non-linear coupled differential equations of the Lorenz system.
%
% Inputs:
%   t     - Scalar, current time (required by ode45 interface)
%   X     - Vector [x; y; z], state vector
%   sigma - Scalar, Prandtl number (standard: 10)
%   rho   - Scalar, Rayleigh number (standard: 28)
%   beta  - Scalar, geometric aspect ratio (standard: 8/3)
%
% Output:
%   dXdt  - Column vector [dxdt; dydt; dzdt]

    % Unpack state variables
    x = X(1);
    y = X(2);
    z = X(3);

    % Governing Lorenz equations
    dxdt = sigma * (y - x);
    dydt = x * (rho - z) - y;
    dzdt = x * y - beta * z;

    dXdt = [dxdt; dydt; dzdt];
end
