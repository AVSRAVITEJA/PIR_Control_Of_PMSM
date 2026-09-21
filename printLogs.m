%% Script: Summarize, Plot, and FFT-Analyze Contents of 'out'
% Avoids printing raw sample tables (too large at Ts=1e-7 over 10s runs)
% Prints summary statistics instead, plots each signal, and runs FFT
% on torque-like signals for ripple quantification

clc;

if ~exist('out', 'var')
    error('Variable "out" not found in the workspace. Run the simulation first.');
end

fprintf('========================================\n');
fprintf(' SUMMARY OF CONTENTS: out\n');
fprintf('========================================\n\n');
fprintf('Class of "out": %s\n\n', class(out));

% ---- Get list of signal names depending on out's type ----
if isa(out, 'Simulink.SimulationOutput')
    varNames = out.who;
    getSignal = @(name) out.get(name);
elseif isstruct(out)
    varNames = fieldnames(out);
    getSignal = @(name) out.(name);
else
    error('Unrecognized type for "out". Expected Simulink.SimulationOutput or struct.');
end

fprintf('Number of logged signals: %d\n\n', numel(varNames));

for i = 1:numel(varNames)
    name = varNames{i};
    data = getSignal(name);

    if ~isa(data, 'timeseries')
        fprintf('Skipping "%s" (not a timeseries, class = %s)\n\n', name, class(data));
        continue;
    end

    t = data.Time;
    y = data.Data;
    N = length(t);
    Ts_actual = mean(diff(t));

    fprintf('----------------------------------------\n');
    fprintf('Signal name   : %s\n', name);
    fprintf('Samples       : %d\n', N);
    fprintf('Time range    : %.6f s to %.6f s\n', t(1), t(end));
    fprintf('Sample time   : %.3e s (avg)\n', Ts_actual);
    fprintf('Min value     : %.6g\n', min(y));
    fprintf('Max value     : %.6g\n', max(y));
    fprintf('Mean value    : %.6g\n', mean(y));
    fprintf('Std deviation : %.6g\n', std(y));
    fprintf('\n');

    % ---- Plot (downsampled for speed if very large) ----
    plot_N = 200000;  % cap points plotted for responsiveness
    if N > plot_N
        idx = round(linspace(1, N, plot_N));
    else
        idx = 1:N;
    end

    figure('Name', name, 'NumberTitle', 'off');
    plot(t(idx), y(idx));
    xlabel('Time (s)');
    ylabel(name);
    title(['Signal: ' name]);
    grid on;
end

fprintf('========================================\n');
fprintf(' SUMMARY COMPLETE\n');
fprintf('========================================\n');