clc;

t = 0:0.01:50;
figure;
%Test 1
x1 =  exp(-t/2);
hold on;
plot(t,x1,'b');
lambda1 = sum(x1);
%Test 2
x2 =  exp(-t/20);
plot(t,x2,'r');
lambda2 = sum(x2);
%Test 3
x3 =  exp(-t/2)+exp(-t/20);
plot(t,x3,'m');
lambda3 = sum(x3);
hold off;
title('Original Signals');
xlabel('Time');
ylabel('Amplitude');
legend('x1','x2','x3');

%Basis Function
figure;
i=1;

tau = logspace(-1,2,128);
for i=1:1:128
    beta(:,i) = exp(-t/tau(i)); 
    i=i+1;
end 
imagesc(beta);
title('Basis Function')
xlabel('tau')
ylabel('time samples')

%Graphical display of pseudo-inverse of basis function
figure;
ps_beta = pinv(beta);
imagesc(ps_beta);
title('Basis Function')
xlabel('tau')
ylabel('time samples')

figure;
hold on;
O1 = ps_beta*x1';
plot(O1);
O2 = ps_beta*x2';
plot(O2);
O3 = ps_beta*x3';
plot(O3);
hold off;
title('Unregularized Theta')
legend('theta1','theta2','theta3');
xlabel('tau');
ylabel('amplitude');

% reconstructed signals
figure;
x1_cap_ur = beta*O1;
x2_cap_ur = beta*O2;
x3_cap_ur = beta*O3;
plot(t,x1_cap_ur, t, x2_cap_ur, t, x3_cap_ur);
title('Reconstructed Signals');
xlabel('Time');
ylabel('Amplitude');
legend('x1','x2','x3');


% Regularization
figure;
hold on;
lambda =0.04;
O1r = O1;
prss = @(O1r) (sum((x1' - beta*O1r).^2)/128 + sum(lambda*abs(O1r)));
oldoptions = optimoptions(@fminunc,'MaxIter',9000, 'MaxFunEvals',1000000);
options = optimoptions(@fminunc, oldoptions);
O1r = fminunc(prss, O1r, options);
plot(O1r);
lambda =0.04;
O2r = O2;
prss = @(O2r) (sum((x2' - beta*O2r).^2)/128 + sum(lambda*abs(O2r)));
oldoptions = optimoptions(@fminunc,'MaxIter',9000, 'MaxFunEvals',1000000);
options = optimoptions(@fminunc, oldoptions);
O2r = fminunc(prss, O2r, options);
plot(O2r);
lambda =0.04;
O3r = O3;
prss = @(O3r) (sum((x1' - beta*O3r).^2)/128 + sum(lambda*abs(O3r)));
oldoptions = optimoptions(@fminunc,'MaxIter',9000, 'MaxFunEvals',1000000);
options = optimoptions(@fminunc, oldoptions);
O3r = fminunc(prss, O3r, options);
plot(O3r);
title('Theta')
legend('theta1','theta2','theta3');
xlabel('tau');
ylabel('amplitude');



% signals with noise
n = 0.05*randn(1,5001);
figure;
% Test 1
x1n =  x1+n;
hold on;
plot(t,x1n);
lambda1 = abs(x1n);
% Test 2
x2n =  x2+n;
plot(t,x2n);
lambda2 = abs(x2n);
% Test 3
x3n =  x3+n;
plot(t,x3n);
lambda3 = abs(x3n);
hold off;
title('Original Signals with noise');
xlabel('Time');
ylabel('Amplitude');
legend('x1n','x2n','x3n');

figure;
hold on;
O1n = ps_beta*x1n';
plot(O1n);
O2n = ps_beta*x2n';
plot(O2n);
O3n = ps_beta*x3n';
plot(O3n);
hold off;
title('Unregularized Theta')
legend('theta1','theta2','theta3');
xlabel('tau');
ylabel('amplitude');

% Regularization
figure;
hold on;
lambda =10^5;
O1rn = O1n;
prss = @(O1rn) (sum((x1' - beta*O1rn).^2)/128 + sum(lambda*abs(O1rn)));
oldoptions = optimoptions(@fminunc,'MaxIter',9000, 'MaxFunEvals',1000000);
options = optimoptions(@fminunc, oldoptions);
O1rn = fminunc(prss, O1rn, options);
plot(O1rn);

lambda =10^5;
O2rn = O2n;
prss = @(O2rn) (sum((x2' - beta*O2rn).^2)/128 + sum(lambda*abs(O2rn)));
oldoptions = optimoptions(@fminunc,'MaxIter',9000, 'MaxFunEvals',1000000);
options = optimoptions(@fminunc, oldoptions);
O2rn = fminunc(prss, O2rn, options);
plot(O2rn);
lambda =10^5;
O3rn = O3n;
prss = @(O3rn) (sum((x1' - beta*O3rn).^2)/128 + sum(lambda*abs(O3rn)));
oldoptions = optimoptions(@fminunc,'MaxIter',9000, 'MaxFunEvals',1000000);
options = optimoptions(@fminunc, oldoptions);
O3rn = fminunc(prss, O3rn, options);
plot(O3rn);
title('Theta')
legend('theta3');
xlabel('tau');
ylabel('amplitude');
