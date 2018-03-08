% Basic FFT Example:

Fs = 1000;                    % Sampling frequency
T = 1/Fs;                     % Sample time
L = 5000;                     % Length of signal
t = (0:L-1)*T;                % Time vector

% Sum of a 50 Hz sinusoid and a 120 Hz sinusoid
x = 1*sin(2*pi*2*t) + 2*sin(2*pi*6*t) + 0.1*randn(size(t));     % Sinusoids plus noise
% x = zeros(L,1); x(1:1000) = 1;                                  % Step Function

% Take the FFT of the signal
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
x_fft = fft(x,NFFT)/L;
freqs = Fs/2*linspace(0,1,NFFT/2+1);


% Plot the signal and Fourier Transform
f1 = figure(1);
set(f1,'Position',[100 100 1600 800]);

subplot 211
plot(t, x, 'k')
title('Signal Corrupted with Zero-Mean Random Noise','FontWeight','Demi','FontSize',12);
xlabel('Time (milliseconds)','FontWeight','Demi','FontSize',12);
grid on; box on; 

subplot 212
%plot(freqs,  2 * abs( x_fft(1:NFFT/2+1) ), 'k-' )     % Show the whole positive spectrum
%plot([ -freqs(end:-1:1) freqs] ,  2 * abs( [x_fft(NFFT/2:end) x_fft(1:NFFT/2+1)] ), 'k-' )      % Show the whole spectrum (positive and negative)
%stem([ -freqs(end:-1:1) freqs] ,  2 * abs( [x_fft(NFFT/2:end) x_fft(1:NFFT/2+1)] ), 'k-' )      % Show the whole spectrum (positive and negative)
ind1 = 1:100; plot(freqs(ind1),  2 * abs( x_fft(ind1) ), 'k-','LineWidth',2 ) 
title('Single-Sided Amplitude Spectrum of y(t)','FontWeight','Demi','FontSize',12);
xlabel('Frequency (Hz)','FontWeight','Demi','FontSize',12);
ylabel('|Y(f)|','FontWeight','Demi','FontSize',12);
grid on; box on; 