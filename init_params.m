% ---- Plant (true) parameters -- set in PMSM block dialog fields ----
Ld_plant = 0.20e-3;
Lq_plant = 0.30e-3;
lambda_plant = 0.09;

% ---- Controller (assumed/nominal) parameters -- used in Decoupling & PIR gains ----
mismatch_pct = 0;   % <-- set this to +20, -20, etc. for robustness sweeps
Ld_ctrl = Ld_plant * (1 + mismatch_pct/100);
Lq_ctrl = Lq_plant * (1 + mismatch_pct/100);
lambda_ctrl = lambda_plant * (1 + mismatch_pct/100);
