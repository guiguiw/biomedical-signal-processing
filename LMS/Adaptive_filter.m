clc;

% IIR filter coefficients
u_num = [0.2, 0.5, -1];
u_den = [1, -0.2, 0.8];

% Random signal generation with zero mean
x = randn(1,512);
t = length (x);

% Desired signal (Output of IIR filter with input x)
d = filter(u_num, u_den, x);

% Calculation of delta
p = mean(x.^2);
a = 0.99;
L = 20;
r = 1/(10*L*p);
del = a*r;

% FIR filter using LMS algorithm
[b, y, e] = lms(x, d, del, L);

% Plot IIR & FIR output
plot(d, 'r');
hold on;
plot(y, 'b');
legend('desired signal','obtained signal');
xlabel('time');
ylabel('amplitude')
figure;

% Frequency spectrum - desired v/s obtained
plot(abs(fft(d)));
hold on;
plot(abs(fft(y)));
legend('desired signal','obtained signal');
xlabel('frequency');
ylabel('amplitude')
figure;

% Magnitude and phase response of FIR and IIR filters

freqz(u_num, u_den, 512);
figure;
freqz(b,1, 512);


% LMS algorithm implementation
function [b,y,e] = lms(x,d,delta,L)    
    M = length(x); % Get data length
    b = zeros(1,L); y = zeros(1,M); % Initialize outputs
    for n = L:M
       x1 = x(n:-1:n-L + 1); % Isolate reversed signal segment
       y(n) = b * x1'; % Convolution
       e(n) = d(n) - y(n); % Calculate error signal
       b = b + delta*e(n)*x1; % Adjust filter coefficients. Eq. 8.17
    end
end