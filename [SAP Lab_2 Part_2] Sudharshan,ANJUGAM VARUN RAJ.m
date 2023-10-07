%[SAP LAB_2} Sudharshan_ANJUGAM _VARUN RAJ, Muhammad Arshad_AHMED

[data,fs] = audioread ('Don_Giovanni_2.wav');

% Reads in the audio file "Don_Giovanni_2.wav" and stores the audio data in the variable "data" and the sampling frequency in the variable "fs".

numSample = 500;

% Sets the number of samples to use for filtering.

fp1 = 800;
fs1 = 1400;
As1 = 100;

% Sets the passband frequency, stopband frequency, and stopband attenuation for the low-pass filter.

wp1 = 2*pi*fp1/fs;
ws1 = 2*pi*fs1/fs;
BF1 = ws1-wp1;
wc1 = (wp1 + ws1) / 2;

% Calculate s the passband and stopband frequencies in radians, the transition band frequency, and the cutoff frequency for the low-pass filter.

M1 = ceil ((As1-7.95) / (2.286 * BF1)) + 1;
N1 = M1 + 1;
beta1 = 0.1102 * (As1-8.7);

% Calculates the filter order, the length of the filter, and the Kaiser window shape parameter for the low-pass filter.

Window = (kaiser (N1, beta1));
b1 = fir1 (M1, wc1 / pi, Window);

% Generates the filter coefficients for the low-pass filter using the Kaiser window method.

figure (1);
freqz (b1,1,512);
title ('Frequency response of FIR LPF');

% Plots the frequency response of the low-pass filter using the filter coefficients.

x1_low = filter (b1,1,data);
sound (x1_low, fs);

% Applies the low-pass filter to the audio data and plays the filtered audio.

l = input ('Enter the n Size = ');
y = filter (numSample, l, x1_low);
subplot (4,1,4);
ts = 1/fs ;
t= (0:ts:(length(y)-1)/fs);
plot (t, y, 'k');
title ('After n points move smoothly');

% Applies a moving average filter to the filtered audio with the filter length specified by the user and plots the smoothed waveform.

x3 = fft (x1_low, 2048);
f6 = fs * (1: 1024) / 2048;
figure (2);
subplot (211);
plot (y);
title ('Time-domain waveform of signal after FIR low-pass filtering');
xlabel ('Time');
ylabel ('Amplitude');
subplot (212);
plot (f6 (1: 1024), abs (x3 (1: 1024)));
title ('Frequency-domain waveform of signal after FIR low-pass filtering')
xlabel ('Frequency');
ylabel ('Amplitude');

% Plots the time-domain and frequency-domain waveforms of the filtered and smoothed audio.