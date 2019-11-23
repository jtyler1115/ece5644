%generate v distributed on sigma = .2
clear all
close all

sigma = .2;
gamma = 10^(-3)

output=[];
dataOut=[];
for b=-4:4
    result=[];
    for i=1:100
        gamma=10^b
        wtrue = [3,2,-1,2]';
        ylist=[];
        xlist=[];
        N=10;
        for i = 1:N
            v = normrnd(0,sigma^2);
            x=(rand*2)-1;
            X=[x^3, x^2, x, 0];
            y=X*wtrue + v;
            ylist(i)=y;
            xlist(i)=x;
        end

        ylist=ylist;
        xlist=xlist;
        data=[xlist',ylist'];

        map=inv(X'*X+(sigma^2/gamma^2)*eye(4))*(X'*ylist);
        map=[mean(map(1,:)),mean(map(2,:)),mean(map(3,:)),mean(map(4,:))];
        diff=(wtrue(1)-map(1))^2+(wtrue(2)-map(2))^2+(wtrue(3)-map(3))^2+(wtrue(4)-map(4))
        result=[result, diff];
    end
    avgResult=mean(result);
    output=[output;b, avgResult];
    dataOut=[dataOut;result];
end
dataOut=[[-4:4]' dataOut];
dataFinal=[dataOut(:,1),dataOut(:,2),dataOut(:,26),dataOut(:,51),dataOut(:,76),dataOut(:,100)];
index=[1,2,3,4,5];
figure()
scatter(repelem(dataFinal(1,1),5),dataFinal(1,2:length(dataFinal(1,:))),'y')
hold on
scatter(repelem(dataFinal(2,1),5),dataFinal(2,2:length(dataFinal(1,:))),'m')
hold on
scatter(repelem(dataFinal(3,1),5),dataFinal(3,2:length(dataFinal(1,:))),'c')
hold on
scatter(repelem(dataFinal(4,1),5),dataFinal(4,2:length(dataFinal(1,:))),'r')
hold on
scatter(repelem(dataFinal(5,1),5),dataFinal(5,2:length(dataFinal(1,:))),'g')
hold on
scatter(repelem(dataFinal(6,1),5),dataFinal(6,2:length(dataFinal(1,:))),'b')
hold on
scatter(repelem(dataFinal(7,1),5),dataFinal(7,2:length(dataFinal(1,:))),'w')
hold on
scatter(repelem(dataFinal(8,1),5),dataFinal(8,2:length(dataFinal(1,:))),'k')
hold on
scatter(repelem(dataFinal(9,1),5),dataFinal(9,2:length(dataFinal(1,:))),'y')

xlabel('values of b such that gamma = 10^b');
ylabel('MSE quartiles');
title('MSE of Map Predictor');