# Exploring Chaos: Application of the Lorenz System to Atmospheric Predictability

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-orange.svg)](https://www.mathworks.com/products/matlab.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

This repository contains the numerical implementations, perturbation grids, and empirical chaos analysis for the research paper: **"Exploring Chaos: Application of the Lorenz System"** by Bismah Zafar.

---

## 1. Project Overview

Classical physical determinism—famously epitomized by Laplace's demon—suggests complete state predictability given exact initial conditions. However, non-linear atmospheric models demonstrate extreme sensitivity to initial conditions, commonly known as the **"butterfly effect."** 

This project explores the non-periodic Lorenz system using MATLAB numerical simulations to quantify trajectory divergence, derive the empirical maximum Lyapunov exponent, and assess the fundamental predictability limits in meteorological forecasting.

---

## 2. Governing Mathematical Model

The Lorenz system is modeled using three coupled, non-linear ordinary differential equations (ODEs):

$$\frac{dx}{dt} = \sigma(y - x)$$
$$\frac{dy}{dt} = x(\rho - z) - y$$
$$\frac{dz}{dt} = xy - \beta z$$

### Standard Parameter Regimes
To induce fully developed chaotic flow, parameters are locked to standard theoretical values:
* **Prandtl Number ($\sigma$):** $10.0$
* **Rayleigh Number ($\rho$):** $28.0$
* **Geometric Aspect Ratio ($\beta$):** $\frac{8}{3} \approx 2.6667$

---

## 3. Methodology & Numerical Setup

* **Numerical Solver:** Evaluated using MATLAB's explicit `ode45` solver (Runge-Kutta 4th/5th order) across the temporal domain $t \in [0, 100]$ with a uniform time step of $\Delta t = 0.01$.
* **Reference Initial State:** Control vector set at $(x_0, y_0, z_0) = (1.0, 1.0, 1.0)$.
* **Perturbation Mesh Grid:** Systematically perturbed around reference states in steps of $\Delta x = 0.2$, $\Delta y = 0.2$, $\Delta z = 0.2$.

---

## 4. Key Figures & Visualizations

### Spatial Perturbation Mesh

The initial condition grid establishes a structured 3D spatial cluster centered around the reference vector $(1.0, 1.0, 1.0)$ to observe multidirectional divergence dynamics.

<p align="center">
  <img src="Figures/Reference Initial Conditions and Perturbations.png" alt="Reference Initial Conditions and Perturbations" width="70%"/>
  <br>
  <em>Figure 1: Spatial distribution of perturbed initial conditions around the reference state.</em>
</p>

---

### Non-Periodic Time Series Dynamics

Individual trajectories $(x(t), y(t), z(t))$ demonstrate persistent non-periodic oscillations without settling into static equilibria or limit cycles.

<p align="center">
  <img src="Figures/Time series data.png" alt="Lorenz System Time Series Data" width="85%"/>
  <br>
  <em>Figure 2: Time-series components x(t), y(t), and z(t) integrated over t = [0, 100].</em>
</p>

---

### Attractor Topologies & Dual Trajectory Divergence

When two trajectories with microscopic initial variance are mapped in 3D phase space, they initially trace nearly identical paths before diverging across the characteristic lobes of the Lorenz attractor.

|                                   Dual Trajectory Phase Portrait                                  |                                                    Multi-Perturbation Ensemble Field                                                    |
| :-----------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------: |
| <img src="Figures/Lorenz System Trajectories.png" alt="Lorenz System Trajectories" width="100%"/> | <img src="Figures/Lorenz System Trajectories with Perturbations.png" alt="Lorenz System Trajectories with Perturbations" width="100%"/> |
|           *Figure 3: Dual-trajectory divergence between two nearby initial conditions.*           |                         *Figure 6: Lorenz attractor generated from an ensemble of perturbed initial conditions.*                        |

---

### Quantitative Trajectory Separation & Lyapunov Metrics

The Euclidean distance $d(t)$ between the baseline trajectory $\mathbf{X}_{\text{ref}}(t)$ and a perturbed trajectory $\mathbf{X}_{\text{pert}}(t)$ is defined as

$$
d(t) =
\sqrt{
(x_{\mathrm{ref}}-x_{\mathrm{pert}})^2 +
(y_{\mathrm{ref}}-y_{\mathrm{pert}})^2 +
(z_{\mathrm{ref}}-z_{\mathrm{pert}})^2
}.
$$

|                                                          Euclidean Spatial Separation $d(t)$                                                          |                                                                Natural Logarithmic Metric $\ln(d(t))$                                                               |
| :---------------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| <img src="Figures/Distance between Original and Perturbed Trajectories.png" alt="Distance between Original and Perturbed Trajectories" width="100%"/> | <img src="Figures/Log of Distance between Original and Perturbed Trajectories.png" alt="Log of Distance between Original and Perturbed Trajectories" width="100%"/> |
|                        *Figure 4: Euclidean separation between the reference and perturbed trajectories as a function of time.*                       |                               *Figure 5: Natural logarithm of trajectory separation used to examine the exponential divergence rate.*                               |

#### Empirical Results

* **Calculated Largest Lyapunov Exponent ($\lambda$):** $\approx 0.2135$
* **Interpretation:** The positive value ($\lambda > 0$) indicates exponential sensitivity to initial conditions, providing empirical evidence of chaotic dynamics in the simulated Lorenz system.

---

## 5. Practical Implications for Weather Forecasting

The empirical chaos demonstrated by $\lambda \approx 0.2135$ explains the structural collapse of deterministic numerical weather prediction (NWP) models beyond ~7–10 days. To mitigate this unpredictability, modern meteorological systems employ:

1. **Ensemble Prediction Systems (EPS):** Running parallel simulations across perturbed initial grids to generate probabilistic likelihood distributions.
2. **Advanced Data Assimilation:** Continuously incorporating high-frequency satellite and observational data to constrain initial boundary conditions before error saturation occurs.
3. **Non-linear Dynamics Integration:** Constructing multi-scale parameterizations that inherently handle turbulent atmospheric transitions.

---

## 6. How to Run the MATLAB Scripts

1. Clone this repository:
   ```bash
   git clone [https://github.com/your-username/lorenz-system-chaos-analysis.git](https://github.com/your-username/lorenz-system-chaos-analysis.git)
   cd lorenz-system-chaos-analysis
   ```
   
2. Open MATLAB and navigate to the src/ directory.

3. Execute run_simulations.m to generate integration arrays and evaluate Lyapunov values:

   ```bash
   run('run_simulations.m')
   ```

   ---        

   > 📄 **Full Research Paper:** Read the complete paper in [`Exploring_Chaos_Lorenz_System.pdf`](docs/Exploring_Chaos_Lorenz_System.pdf)
