% importing features from data
X = fertility(:,1:9);
% standardizing the data
for i = 1:1:9
    for j = 1:1:100
    Mean = mean(X(:,i));
    X(j,i) = (X(j,i) - Mean)/Mean;
    end
end
% normalizing the data
X = zscore(X); 
% normalizing every column
for i = 1:1:9
    X(:,i) = zscore(X(:,i));
end

% Weiner-Hopf implementation
Xb = horzcat(ones(100,1), X);
Y = fertility(:,10);
Xbi = inv(transpose(Xb)*Xb);
beta = Xbi*Xb'*Y;

% Correlation implementation
YX = horzcat(Y,X);
Cf = corr(YX);
imagesc(Cf)
Co = Cf(2:10,1);
Xaxis = 1:9;
plot(Xaxis, Co, Xaxis, beta(2:10))
xlabel('input')
ylabel('correlation')
legend('correlation', 'weiner-hopf');

% generating ycap column vector
Yf = Xb*beta;
plot(Yf,1,'o');

% generating decision boundary
xb  = -0:0.01:1; 

% Calculating TP, TN, FP, FN, sensitivity & specificity for each decision
% boundary

for j = 1:length(xb)
    TP = 0; TN = 0;
    for i = 1:100
        if Yf(i) < xb(j) && Y(i) == 0
            TP = TP+1;
        end
        if Yf(i) > xb(j) && Y(i) == 1
            TN = TN+1;
        end
    end
    FN = 100-TP;
    FP = 100-TN;
    Sn(j) = TP/(TP + FN);
    Sp(j) = TN/(TN + FP);
    
end

%ROC

plot(1-Sp,Sn)
ylabel('sensitivity')
xlabel('specificity')
