%Problem 2

clear;

syms x;
a1 = 0;
b1 = 1;
a2 = 1;
b2 = 2;
f1 = log((1/(2*b1))*exp(-abs(x-a1)/b1));
f2 = log((1/(2*b2))*exp(-abs(x-a2)/b2));
figure(1)
fplot(f1 - f2)
title('Log-likelihood of p(x)')
xlabel('x')
ylabel('l(x)')
annotation('textbox',[.3 .15 .5 .1],'String','This plot shows the likelihood of different x values occuring on a logarithmic scale','EdgeColor','none')

%Problem 4
u1 = 0;
sig1 = 1;
u2 = 1;
sig2 = 2;
x = [-6:.1:6];
c1 = normpdf(x,u1,sig1);
c2 = normpdf(x,u2,sig2);
decision = sqrt(sig2) * exp(((-(x.^2))./2) + (x-u2.^2)./(2.*sig2));
prior = .5; %since priors are equal, prior = 1/number of classes
scalefactor = c1*.5 + c2*.5;
post1 = (c1 * .5)./scalefactor;
post2 = (c2 * .5)./scalefactor;
errorRate = 0;
for i = [1:length(x)]
    if decision(i)>1
        errorRate = errorRate + c2(i)*.1;
    else
        errorRate = errorRate + c1(i)*.1;
    end
end
figure(2)
plot(x,c1,x,c2,x,post1,x,post2,x,decision)
title('Question 3 Plot')
xlabel('x')
ylabel('Probability')
legend('Class 1', 'Class 2', 'Class 1 Posterior', 'Class 2 Posterior','Decision Rule')
annotation('textbox',[.15 .3 .25 .3],'String','We know that when the decision rule is greater than 1, we should decide class 1. In all other situations, we decide class 2.','EdgeColor','none')