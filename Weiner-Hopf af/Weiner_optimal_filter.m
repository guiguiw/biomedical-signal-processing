clear all;

% signal
t = 0:1e-2:10;
x1 = 1 + cos(2*pi*10*t);
x2 = cos(3*pi*1*t);
x = x1+x2;
subplot(3,1,1);
plot(t,x1);
xlabel('time');
ylabel('Amplitude');
subplot(3,1,2);
plot(t,x2);
xlabel('time');
ylabel('Amplitude');
subplot(3,1,3);
plot(t,x);
xlabel('time');
ylabel('Amplitude');

% calculating signal power
sp = 10*log10(norm(x)^2/numel(x));

% snr = -8dB
% snr = sig_power - noise_power
% noise power or variance (as it is 0 mean) 
np = sp+8;
v = 10^(np/10);

% noise
n = sqrt(v)*randn(size(x));
plot (t,n);
xlabel('time');
ylabel('Amplitude');

% signal + noise
xn = x+n;
plot (t,xn);
xlabel('time');
ylabel('Amplitude');
s = snr(xn);
plot(t,xn,'r');

% Weiner optimal filtering    
b = weiner_hopf(xn, x, 1001);
plot(b);
xlabel('maxLag');
ylabel('coeficient');
title('filter coefficients')
y = filter(b,1,xn);
plot(t,y,'r',t,x,'b');
legend('filter output','oringinal signal')
xlabel('time');
ylabel('Amplitude');
title('filter output v/s original signal')

% Frequency spectrum
Y = fft(y);
X = fft(x);
plot(abs(Y),'b');
hold on;
plot(abs(X),'m');
xlabel('frequency')
title('Frequency Spectrum')
legend('filter output', 'original signal');

% Fuction 
function b = weiner_hopf(xn, x, L)
    rxx = xcorr(xn,L); % Autocorrelation
    rxx = rxx(L + 1:end)'; % Positive lags only
    rxy = xcorr(xn,x,L); % Crosscorrelation
    rxy = rxy(L + 1:end)'; % Positive lags only
    rxx_matrix = toeplitz(rxx); % Correlation matrix
    b = rxx_matrix\rxy;
end


    








