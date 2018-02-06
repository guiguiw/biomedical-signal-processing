clc;
clear all;
Y = ones(25,1);
%Random signals with 25 samples
X1 = 0.5.*randn(25,1) + 1
X2 = 0.5.*randn(25,1) + 2
%plot consisting of X1 & X2
plot(X1,Y,'o',X2,Y,'+');
hold on;
%threshold
xb = 1.5;
Xb = [xb,xb];
Yb = [0,2];
plot(Xb,Yb);
xlabel('Features')
ylabel('Y')
%Initialization
TP = 0; TN = 0;
%Calculation of TP, TN, FP, FN
for i = 1:25
    if X1(i) < xb
        TP = TP+1;
    end
    if X2(i) > xb
        TN = TN+1;
    end
end
FN = 25-TP;
FP = 25-TN;
%Calculating sensitivity and specificity
Sn = TP/(TP + FN);
Sp = TN/(TN + FP);
plot