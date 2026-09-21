# PIR Control of PMSM for Torque Ripple Reduction

## Overview

This project presents a **Proportional-Integral-Resonant (PIR) current controller** for an **Interior Permanent Magnet Synchronous Motor (IPMSM)** intended for electric vehicle (EV) traction applications.

The proposed controller incorporates resonant compensation at the dominant sixth harmonic, \(6\omega_e\), to selectively attenuate periodic torque ripple associated with cogging torque, inverter dead-time nonlinearity, and current waveform distortion. The approach retains the conventional PI control structure while providing targeted harmonic compensation without requiring an increase in the underlying PI controller bandwidth.

The controller is evaluated under variable-speed operation, electrical-frequency reversals, motor parameter variations, and current-sensor inaccuracies.

## Objectives

* Develop a PIR current controller with adaptive resonant compensation at \(6\omega_e\).
* Evaluate controller stability and performance under variable-speed operation.
* Validate resonant-frequency tracking during electrical-frequency reversals.
* Assess robustness to variations in \(L_d\), \(L_q\), and permanent-magnet flux linkage.
* Evaluate the effect of current-sensor inaccuracies on ripple suppression.
* Quantify torque-ripple reduction using FFT-based analysis.
* Compare PIR and conventional PI current-control performance.

## Methodology

The control architecture combines a conventional PI current controller with a resonant compensator tuned to the dominant sixth-harmonic component of the electrical frequency.

$$
\omega_r = 6\omega_e
$$

The resonant frequency is updated according to the instantaneous electrical frequency, allowing the controller to maintain targeted harmonic compensation across varying operating conditions.

The performance of the proposed controller is evaluated against a conventional PI controller using time-domain and frequency-domain torque analysis.

## Simulation

The models are developed and evaluated using **MATLAB/Simulink**.

The simulation study covers:

* Variable-speed operation
* Motoring and regenerative operating conditions
* Electrical-frequency reversals
* Motor parameter variations
* Current-sensor inaccuracies
* PI vs. PIR controller comparison
* FFT-based torque-ripple analysis

## Repository Structure

```text
PIR_Control_Of_PMSM/
│
├── ev_project_1.slx
├── pir_based_control_pmsm_motors.slx
├── fftTorqueAnalysis.m
├── printLogs.m
├── review1_EVproject.pptx
├── .gitignore
└── LICENSE
```

### File Description

| File                                | Description                            |
| ----------------------------------- | -------------------------------------- |
| `ev_project_1.slx`                  | EV/IPMSM simulation model              |
| `pir_based_control_pmsm_motors.slx` | PIR-based PMSM control model           |
| `fftTorqueAnalysis.m`               | FFT-based torque-ripple analysis       |
| `printLogs.m`                       | Simulation data processing and logging |
| `review1_EVproject.pptx`            | Project presentation                   |
| `LICENSE`                           | MIT License                            |

## Performance Evaluation

Torque-ripple performance is evaluated by analyzing the electromagnetic torque in both the time and frequency domains.

FFT analysis is used to identify the dominant harmonic components and compare their magnitudes between the conventional PI and proposed PIR controllers.

Further quantitative results will be documented as the simulation study is completed.

## Tools and Technologies

* MATLAB
* Simulink
* IPMSM Modeling
* PI/PIR Current Control
* FFT Analysis
* Electric Vehicle Traction Systems

## License

This project is licensed under the **MIT License**. See the [`LICENSE`](LICENSE) file for details.
