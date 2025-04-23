% Parameters for Signal Generation
f = 20000;                % Frequency of the signal (2.4 GHz)
c = 3e8;                  % Speed of light (m/s)
lambda = c / f;           % Wavelength of the signal
fs = 1e6;                 
t = (0:100-1)/fs ; 
signal = -1i*exp(2i*pi*f*t); % Generate a sinusoidal signal
plot(t, real(signal));
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Orignal Signal');

% Array Geometry
N = 4;                     % Number of antennas as N increas the Side loops will be smaller and beam will be more directed 
d = lambda / 2;            % Antenna spacing (lambda/2)

% Angle of Beam Direction (desired beam direction)
theta = -15;                % Desired beam direction (in degrees)

% Phase Shift Calculation for each antenna
k = 2 * pi / lambda;       % Wavenumber
% Preallocate space for phase shifts and delayed signals
phase_shifts = zeros(1, N);
signals_with_phases = zeros(N, length(t));
delayed_signals     = zeros(N, length(t));


angles = -90:1:90;             % Angle range for evaluation (-90° to 90°)
num_angles = length(angles);   % Number of angles
power_values = zeros(1, num_angles); % Initialize power array for polar plot

for idx = 1:num_angles
    thetaa = angles(idx);       % Current evaluation angle
 
for n = 1:N
    % Calculate the time delay for each antenna
    Delta_tn = (n-1) * d * sind(thetaa)/c ;
    % Convert time delay to phase shift (radians)
    phase_shifts(n) =   k * (c * Delta_tn)    ;            %%2 * pi * f * Delta_tn;
    % Apply phase shift to the signal for each antenna
    signals_with_phases(n, :) =   signal *  exp(-1i*phase_shifts(n)) ;              %%sin(2 * pi * f * t - phase_shifts(n)*c); %%%%%%%%%%%%%%%%%%%%%%%% Need an explantion ??????????  ;                
    
end

% Compute the power as the squared magnitude of the array factor
    beamformed_signal = sum(real(signals_with_phases), 1);
    power_values(idx) = sum((abs(beamformed_signal)).^2)/ length(beamformed_signal);
end


% Plot Power vs. Angle in a Polar Plot (Radiation Pattern)
figure;
plot(angles, 10 * log10(power_values), 'LineWidth', 2);
xlabel('Angels (deg)');
ylabel('Power radited (dB)');
title('Radiation Pattern Without beamforming (Power in dB)');
grid on;

%% beamforming 

  % Hamming Window: Reduces sidelobes while slightly broadening the main lobe.
         weights = 1;    %.54 - .46*cos(2*pi*(0:N-1)/(N-1));
         normalized_wight =   weights/sqrt((sum((abs(weights)).^2))/N); %To minimize SNR loss while using weights:

   % phahse shift will be applied to each antenna 
phase_shiftsa = zeros(N,1);
signals_with_phasesa = zeros(N,length(t));
 for n = 1:N
    % Calculate the time delay for each antenna
    Delta_tna = (n-1) * d * sind(theta)/c ;
    % Convert time delay to phase shift (radians)
    phase_shiftsa(n) = exp(-2i*(n-1)*pi*d*sind(theta)/lambda);  %% k * (c * Delta_tna)    ;            %%2 * pi * f * Delta_tn;
    % Apply phase shift to the signal for each antenna
    signals_with_phasesa(n, :) = weights * signal .* phase_shiftsa(n)  ; %%sin(2 * pi * f * t - phase_shiftsa(n)*c); %%%%%%%%%%%%%%%%%%%%%%%% Need an explantion ??????????  ;                
    
 end

 % Visualize phase shifts
phase_shiftsinDeg = ((2*(0:N-1)*pi*d*sind(theta)/lambda) * 180)/ pi;
figure;
stem(1:N, phase_shiftsinDeg);
xlabel('Antenna Index');
ylabel('Phase Shift (Degrees)');
title('Phase Shifts Applied to Each Antenna');
grid on;

% Plot weights
%figure;
%stem(1:N, weights);
%xlabel('Antenna Index');
%ylabel('Weight');
%title('Hamming Window Weights');
%grid on;



% Plot individual signals for each antenna
figure;
hold on;
for n = 1:N
    plot(t, real(signals_with_phasesa(n, :)), 'DisplayName', ['Antenna ' num2str(n)]);
end
hold off;
xlabel('Time (s)');
ylabel('Amplitude');
title('Signals from Each Antenna with Phase Shifts');
legend;
grid on;

  % Wave in 15 degree direction 
  phase_shift = exp(-2i*pi*d*sind(theta) *(0:N-1)' /lambda);
  beamformed_signal_After =   signals_with_phasesa' * phase_shift  ;
  % Plot the Beamformed Signal
figure;
plot(t,real(beamformed_signal_After));
xlabel('Time (s)');
ylabel('Amplitude');
title('Beamformed Signal in the Direction 15°');
grid on;

% Display results
disp('Max amplitude of beamformed signal:');
disp(max(abs(beamformed_signal_After)));  % Display max amplitude



  angles = -90:1:90;             % Angle range for evaluation (-90° to 90°)
num_angles = length(angles);   % Number of angles
power_values = zeros(1, num_angles); % Initialize power array for polar plot

for idx = 1:num_angles
    thetaa = angles(idx);       % Current evaluation angle
 
for n = 1:N
    % Calculate the time delay for each antenna
    Delta_tn = (n-1) * d * sind(thetaa)/c ;
    % Convert time delay to phase shift (radians)
    phase_shifts(n) =   exp(2i*(n-1)*pi*d*sind(thetaa)/lambda)    ;            %%2 * pi * f * Delta_tn;
    % Apply phase shift to the signal for each antenna
    signals_with_phases(n, :) =   signals_with_phasesa(n, :)*phase_shifts(n);                 
    
end

% Compute the power as the squared magnitude of the array factor
    beamformed_signal = sum(signals_with_phases, 1);
    power_values(idx) = sum(abs(beamformed_signal).^2) / length(beamformed_signal);
end


% Plot Power vs. Angle in a Polar Plot (Radiation Pattern)
figure;
plot(angles, 10 * log10(power_values/max(power_values)), 'LineWidth', 2);
xlabel('Angels (deg)');
ylabel('Power radited (dB)');
title('Radiation Pattern after beamforming (Power in dB)');
grid on;


%% Add Noise to the Signal and Calculate SNR
snr_without_beamforming = [];
snr_with_beamforming = [];

% Add white Gaussian noise to the original signal
noise_power = 0.1; % Adjust noise power as needed
noisy_signal = signal + sqrt(noise_power/2) * (randn(size(signal)) + 1i * randn(size(signal)));

% Plot the noisy signal
figure;
plot(t, real(noisy_signal));
xlabel('Time (s)');
ylabel('Amplitude');
title('Noisy Signal');
grid on;

% Calculate SNR without beamforming
signal_power = sum(abs(signal).^2) / length(signal); % Average power of original signal
noise_power_calculated = sum(abs(noisy_signal - signal).^2) / length(signal); % Average power of noise
snr_without_beamforming = 10 * log10(signal_power / noise_power_calculated); % SNR in dB

% Add noise to signals for beamforming process
noisy_signals_with_phases = signals_with_phasesa + sqrt(noise_power/2) * (randn(size(signals_with_phasesa)) + 1i * randn(size(signals_with_phasesa)));

% Beamform the noisy signal
noisy_beamformed_signal = noisy_signals_with_phases' * phase_shift;

% Calculate SNR after beamforming
beamformed_signal_power = sum(abs(beamformed_signal_After).^2) / length(beamformed_signal_After);
beamformed_noise_power = sum(abs(noisy_beamformed_signal - beamformed_signal_After).^2) / length(noisy_beamformed_signal);
snr_with_beamforming = 10 * log10(beamformed_signal_power / beamformed_noise_power);

% Display SNR values
disp('SNR without beamforming (dB):');
disp(snr_without_beamforming);

disp('SNR with beamforming (dB):');
disp(snr_with_beamforming);

% Plot beamformed noisy signal
figure;
plot(t, real(noisy_beamformed_signal));
xlabel('Time (s)');
ylabel('Amplitude');
title('Noisy Beamformed Signal');
grid on;