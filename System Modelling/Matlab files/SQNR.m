clc
% Load signals from Simulink (replace with your actual data)
y_float = floating_mlt;  % Floating-point signal
y_fixed = fixed_mlt;  % Fixed-point signal

% Compute quantization noise
error = y_float - y_fixed;
mlt = max(y_float)
nmlt = min(y_float)

% Calculate signal power and noise power
P_signal = mean(y_float.^2);
P_noise = mean(error.^2);

% Compute SQNR
ratio = double(P_signal/P_noise);
SSQNR = 10 * log10(ratio);
disp(['SQNR: ', num2str(SSQNR),' dB']);