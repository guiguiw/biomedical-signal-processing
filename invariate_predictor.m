clc;
clear all;
Y = ones(25,1);
% Random signals with 25 samples
X1 = 0.5.*randn(25,1) + 1;
X2 = 0.5.*randn(25,1) + 2;
%varying decision boundary
xb  = -1:0.2:5; 
%Calculating TP, TN, FP, FN, sensitivity & specificity for each decision
%boundary
for j = 1:length(xb)
    TP = 0; TN = 0;
    for i = 1:25
        if X1(i) < xb(j)
            TP = TP+1;
        end
        if X2(i) > xb(j)
            TN = TN+1;
        end
    end
    FN = 25-TP;
    FP = 25-TN;
    Sn(j) = TP/(TP + FN);
    Sp(j) = TN/(TN + FP);
    
end
%ROC
plot(1-Sp,Sn)
ylabel('sensitivity')
xlabel('specificity')


    




