%% Script: FFT Ripple Analysis on a Single Logged Signal
% Run AFTER identifying your torque signal's name from the summary above
% Example: signalName = 'Te_data';

signalName = 'Te';   % <-- CHANGE THIS to your actual torque signal name

if isa(out, 'Simulink.SimulationOutput')
    data = out.get(signalName);
else
    data = out.(signalName);
end

t = data.Time;
y = data.Data;

% ---- Select a steady-state time window (avoid startup transient) ----
t_start = 5.0;   % seconds -- adjust to a window where speed/load is steady
t_end   = 6.0;   % seconds -- 1 second window is plenty for FFT resolution

idx = (t >= t_start) & (t <= t_end);
t_window = t(idx);
y_window = y(idx);

% ---- Resample to uniform time base if needed (timeseries can have
%      slightly non-uniform steps from solver) ----
Ts_uniform = 1e-6;  % choose based on your needed frequency resolution
t_uniform = t_start:Ts_uniform:t_end;
y_uniform = interp1(t_window, y_window, t_uniform, 'linear');

% ---- FFT ----
N = length(y_uniform);
Fs = 1/Ts_uniform;
Y = fft(y_uniform - mean(y_uniform));  % remove DC offset
P2 = abs(Y/N);
P1 = P2(1:floor(N/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;

% ---- Plot spectrum ----
figure('Name', 'Torque FFT', 'NumberTitle', 'off');
plot(f, P1);
xlim([0, 2000]);   % adjust range to cover 6th harmonic of your test speed
xlabel('Frequency (Hz)');
ylabel('Torque Magnitude (Nm)');
title('FFT of Torque Ripple');
grid on;

% ---- Extract magnitude at 6th electrical harmonic ----
% Compute fe from your test speed: fe = p * wm(rpm)/60
p = 4;               % pole pairs
wm_rpm = 4500;        % <-- CHANGE to the actual test speed for this window
fe = p * wm_rpm / 60;
f6 = 6 * fe;

[~, idx6] = min(abs(f - f6));
mag_6th = P1(idx6);

fprintf('Fundamental electrical freq (fe): %.2f Hz\n', fe);
fprintf('6th harmonic freq (6fe)          : %.2f Hz\n', f6);
fprintf('6th harmonic torque magnitude    : %.6f Nm\n', mag_6th);

% ---- Ripple factor ----
ripple_pct = (max(y_window) - min(y_window)) / mean(y_window) * 100;
fprintf('Peak-to-peak ripple factor       : %.3f %%\n', ripple_pct);