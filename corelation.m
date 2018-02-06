% % Fertility dataset
Xf = fertility(:,1:9);
Yf = fertility(:,10);
YXf = horzcat(Yf,Xf);
Cf = corr(YXf);
imagesc(Cf)
Co = Cf(: , 10)
Xaxis = 1:10
plot(Xaxis, Co)
xlabel('input')
ylabel('correlation')

%dataset
Xd = ass1(:,2:8);
Yd = ass1(:,9);
YXd = horzcat(Yd,Xd);
Cd = corr(YXd);
imagesc(Cd)
Co = Cd(: , 8)
Xaxis = 1:8
plot(Xaxis, Co)

xlabel('input')
ylabel('correlation')