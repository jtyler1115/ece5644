
% cluster = [mu ; cov];
p1 = .3;
p2 = .1;
p3 = .2;
p4 = .4;
cov1 = [0.1 0;0 0.1];
cov2 = [0.2 0;0 0.2];
cov3 = [0.1 0;0 0.2];
cov4 = [0.2 0;0 0.1];
mu1 = [1 1];
mu2 = [5 5];
mu3 = [5 1];
mu4 = [1 5];
set10=[];
set100=[];
set1000=[];
set10000=[];
p = [.2 .3 .1 .4];
for i = 1:10
    test = rand();
    if test< p1
        X=mvnrnd(mu1,cov1);
        X=[X(1,:) 1];
    elseif test < p1+p2
        X=mvnrnd(mu2,cov2);
        X=[X(1,:) 2];
    elseif test < p1+p2+p3
        X=mvnrnd(mu3,cov3)
        X=[X(1,:) 3];
    elseif test < p1+p2+p3+p4
        X=mvnrnd(mu4,cov4);
        X=[X(1,:) 4];
    end
    set10=[set10;X];
end
for i = 1:100
    test = rand();
    if test< p1
        X=randn(1,2)*chol(cov1)+mu1;
        X=[X(1,:) 1];
    elseif test < p1+p2
        X=randn(1,2)*chol(cov1)+mu2;
        X=[X(1,:) 2];
    elseif test < p1+p2+p3
        X=randn(1,2)*chol(cov1)+mu3;
        X=[X(1,:) 3];
    elseif test < p1+p2+p3+p4
        X=randn(1,2)*chol(cov1)+mu4;
        X=[X(1,:) 4];
    end
    set100=[set100;X];
end
for i = 1:1000
    test = rand();
    if test< p1
        X=randn(1,2)*chol(cov1)+mu1;
        X=[X(1,:) 1];
    elseif test < p1+p2
        X=randn(1,2)*chol(cov1)+mu2;
        X=[X(1,:) 2];
    elseif test < p1+p2+p3
        X=randn(1,2)*chol(cov1)+mu3;
        X=[X(1,:) 3];
    elseif test < p1+p2+p3+p4
        X=randn(1,2)*chol(cov1)+mu4;
        X=[X(1,:) 4];
    end
    set1000=[set1000;X];
end
for i = 1:10000
    test = rand();
    if test< p1
        X=randn(1,2)*chol(cov1)+mu1;
        X=[X(1,:) 1];
    elseif test < p1+p2
        X=randn(1,2)*chol(cov1)+mu2;
        X=[X(1,:) 2];
    elseif test < p1+p2+p3
        X=randn(1,2)*chol(cov1)+mu3;
        X=[X(1,:) 3];
    elseif test < p1+p2+p3+p4
        X=randn(1,2)*chol(cov1)+mu4;
        X=[X(1,:) 4];
    end
    set10000=[set10000;X];
end

k = 10;
indices10 = randperm(10); %ensures that there is at least one piece of data in each set
indices100 = crossvalind('Kfold',set100(:,1),k);
indices1000 = crossvalind('Kfold',set1000(:,1),k);
indices10000 = crossvalind('Kfold',set10000(:,1),k);
%scatter(set10(:,1),set10(:,2));

%work with set10
% [model1, model2, model3, model4, model5, model6,fit1,fit2,fit3,fit4,fit5,fit6]=emalg(set10,indices10,k);
% choice=min([fit1,fit2,fit3,fit4,fit5,fit6])
% j=1;
% for criteria=[fit1,fit2,fit3,fit4,fit5,fit6]
%     if criteria==choice
%         set10choicenum=j
%     end
%     j=j+1;
% end
% figure(1)
% 
% subplot(2,3,1)
% fsurf(@(x,y)reshape(pdf(model1,[x(:),y(:)]),size(x)),[-10 10])
% title(['1-Component Model (BIC = ' num2str(fit1) ')'])
% subplot(2,3,2)
% fsurf(@(x,y)reshape(pdf(model2,[x(:),y(:)]),size(x)),[-10 10])
% title(['2-Component Model (BIC = ' num2str(fit2) ')'])
% subplot(2,3,3)
% fsurf(@(x,y)reshape(pdf(model3,[x(:),y(:)]),size(x)),[-10 10])
% title(['3-Component Model (BIC = ' num2str(fit3) ')'])
% subplot(2,3,4)
% fsurf(@(x,y)reshape(pdf(model4,[x(:),y(:)]),size(x)),[-10 10])
% title(['4-Component Model (BIC = ' num2str(fit4) ')'])
% subplot(2,3,5)
% fsurf(@(x,y)reshape(pdf(model5,[x(:),y(:)]),size(x)),[-10 10])
% title(['5-Component Model (BIC = ' num2str(fit5) ')'])
% subplot(2,3,6)
% fsurf(@(x,y)reshape(pdf(model6,[x(:),y(:)]),size(x)),[-10 10])
% title(['6-Component Model (BIC = ' num2str(fit6) ')'])

%work with set100
% [model1, model2, model3, model4, model5, model6,fit1,fit2,fit3,fit4,fit5,fit6]=emalg(set100,indices100,k);
% choice=min([fit1,fit2,fit3,fit4,fit5,fit6])
% j=1;
% for criteria=[fit1,fit2,fit3,fit4,fit5,fit6]
%     if criteria==choice
%         set100choicenum=j
%     end
%     j=j+1;
% end
% figure(2)
% 
% subplot(2,3,1)
% fsurf(@(x,y)reshape(pdf(model1,[x(:),y(:)]),size(x)),[-10 10])
% title(['1-Component Model (BIC = ' num2str(fit1) ')'])
% subplot(2,3,2)
% fsurf(@(x,y)reshape(pdf(model2,[x(:),y(:)]),size(x)),[-10 10])
% title(['2-Component Model (BIC = ' num2str(fit2) ')'])
% subplot(2,3,3)
% fsurf(@(x,y)reshape(pdf(model3,[x(:),y(:)]),size(x)),[-10 10])
% title(['3-Component Model (BIC = ' num2str(fit3) ')'])
% subplot(2,3,4)
% fsurf(@(x,y)reshape(pdf(model4,[x(:),y(:)]),size(x)),[-10 10])
% title(['4-Component Model (BIC = ' num2str(fit4) ')'])
% subplot(2,3,5)
% fsurf(@(x,y)reshape(pdf(model5,[x(:),y(:)]),size(x)),[-10 10])
% title(['5-Component Model (BIC = ' num2str(fit5) ')'])
% subplot(2,3,6)
% fsurf(@(x,y)reshape(pdf(model6,[x(:),y(:)]),size(x)),[-10 10])
% title(['6-Component Model (BIC = ' num2str(fit6) ')'])
% %work with set1000
[model1, model2, model3, model4, model5, model6,fit1,fit2,fit3,fit4,fit5,fit6]=emalg(set1000,indices1000,k);
choice=min([fit1,fit2,fit3,fit4,fit5,fit6])
j=1;
for criteria=[fit1,fit2,fit3,fit4,fit5,fit6]
    if criteria==choice
        set1000choicenum=j
    end
    j=j+1;
end
figure(3)

subplot(2,3,1)
fsurf(@(x,y)reshape(pdf(model1,[x(:),y(:)]),size(x)),[-10 10])
title(['1-Component Model (BIC = ' num2str(fit1) ')'])
subplot(2,3,2)
fsurf(@(x,y)reshape(pdf(model2,[x(:),y(:)]),size(x)),[-10 10])
title(['2-Component Model (BIC = ' num2str(fit2) ')'])
subplot(2,3,3)
fsurf(@(x,y)reshape(pdf(model3,[x(:),y(:)]),size(x)),[-10 10])
title(['3-Component Model (BIC = ' num2str(fit3) ')'])
subplot(2,3,4)
fsurf(@(x,y)reshape(pdf(model4,[x(:),y(:)]),size(x)),[-10 10])
title(['4-Component Model (BIC = ' num2str(fit4) ')'])
subplot(2,3,5)
fsurf(@(x,y)reshape(pdf(model5,[x(:),y(:)]),size(x)),[-10 10])
title(['5-Component Model (BIC = ' num2str(fit5) ')'])
subplot(2,3,6)
fsurf(@(x,y)reshape(pdf(model6,[x(:),y(:)]),size(x)),[-10 10])
title(['6-Component Model (BIC = ' num2str(fit6) ')'])
% 
% %work with set10000
[model1, model2, model3, model4, model5, model6,fit1,fit2,fit3,fit4,fit5,fit6]=emalg(set10000,indices10000,k);
choice=min([fit1,fit2,fit3,fit4,fit5,fit6])
j=1;
for criteria=[fit1,fit2,fit3,fit4,fit5,fit6]
    if criteria==choice
        set10000choicenum=j
    end
    j=j+1;
end
figure(4)

subplot(2,3,1)
fsurf(@(x,y)reshape(pdf(model1,[x(:),y(:)]),size(x)),[-10 10])
title(['1-Component Model (BIC = ' num2str(fit1) ')'])
subplot(2,3,2)
fsurf(@(x,y)reshape(pdf(model2,[x(:),y(:)]),size(x)),[-10 10])
title(['2-Component Model (BIC = ' num2str(fit2) ')'])
subplot(2,3,3)
fsurf(@(x,y)reshape(pdf(model3,[x(:),y(:)]),size(x)),[-10 10])
title(['3-Component Model (BIC = ' num2str(fit3) ')'])
subplot(2,3,4)
fsurf(@(x,y)reshape(pdf(model4,[x(:),y(:)]),size(x)),[-10 10])
title(['4-Component Model (BIC = ' num2str(fit4) ')'])
subplot(2,3,5)
fsurf(@(x,y)reshape(pdf(model5,[x(:),y(:)]),size(x)),[-10 10])
title(['5-Component Model (BIC = ' num2str(fit5) ')'])
subplot(2,3,6)
fsurf(@(x,y)reshape(pdf(model6,[x(:),y(:)]),size(x)),[-10 10])
title(['6-Component Model (BIC = ' num2str(fit6) ')'])



