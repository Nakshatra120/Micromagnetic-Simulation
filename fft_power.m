% import data
filename = 'table.txt';
[A,delimiterOut]=importdata(filename);

% pick out m.region1y () column
my = A.data(:,6);

% cut out first 20 percent of points
L = length(my);
L2 = round(L/5); 
my = A.data(L2:L,6);

% take FFT and calculate amplitude
N = L-L2;    % number of points
Fs = N/(100*10^(-9)); % sampling frequency for 100ns of data
Y = fft(my);    % take fft
P2 = abs(Y/N);  % two-sided spectrum
P1 = P2(1:round(N/2));   % single-sided amplitude spectrum
P1(2:end-1) = 2*P1(2:end-1);
f3=[0:(length(Y)/2-1)]/10^(-7);     % frequencies for plot

% calculate power
p = abs(Y)/(length(Y)/2);
p = p(1:length(Y)/2).^2;

% plot amplitude
figure(1);
plot(f3,P1)
title("Amplitude Spectrum")
xlabel("f (Hz)")
ylabel("Amplitude")

% plot power
figure(2);
plot(f3,p) 
title("Power Spectrum")
xlabel("f (Hz)")
ylabel("Power")