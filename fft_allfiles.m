% Set the range of values for {a}
a_values = 4:20;

% Iterate through each value of {a}
for a = a_values
    % Construct the filename
    filename = sprintf('table_20nm_%02dAmp.txt', a);
    
    % Import data
    [A, delimiterOut] = importdata(filename);
    
    % Pick out m.region1y () column
    my = A.data(:, 6);
    
    % Cut out first 20 percent of points
    L = length(my);
    L2 = round(L / 5);
    my = A.data(L2:L, 6);
    
    % Take FFT and calculate amplitude
    N = L - L2;   % number of points
    Fs = N / (100 * 10^(-9)); % sampling frequency for 100ns of data
    Y = fft(my);   % take fft
    P2 = abs(Y / N); % two-sided spectrum
    P1 = P2(1:round(N / 2)); % single-sided amplitude spectrum
    P1(2:end-1) = 2 * P1(2:end-1);
    f3 = [0:(length(Y) / 2 - 1)] / 10^(-7); % frequencies for plot
    
    % Calculate power
    p = abs(Y) / (length(Y) / 2);
    p = p(1:length(Y) / 2) .^ 2;
    
    % Plot amplitude
    figure;
    plot(f3, P1);
    title(sprintf('%dAmp Amplitude Spectrum', a));
    xlabel('f (Hz)');
    ylabel('Amplitude');
    
    % Plot power
    figure;
    plot(f3, p);
    title(sprintf('%dAmp Power Spectrum', a));
    xlabel('f (Hz)');
    ylabel('Power');
end