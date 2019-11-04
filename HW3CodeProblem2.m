clear all;
mean1 = [1 1];
cov1 = [3 1;1 .8];
mean2 = [3 3];
cov2 = [2 .5;.5 1];
prior1=.3
prior2=.7
class1=[];
class2=[]
for i = 1:999
    test = rand()
    if test< prior1
        X1=randn(1,2)*chol(cov1)+mean1;
        X1=[X1(1,:) 1];
        class1=[class1; X1];
    else
        X2=randn(1,2)*chol(cov2)+mean2;
        X2=[X2(1,:) 2];
        class2=[class2; X2];
    end
end
figure(1)
scatter(class1(:,1),class1(:,2),'r')
hold on
scatter(class2(:,1),class2(:,2),'g')
title('Generated Data Points')
legend('Class 1','Class 2')

output= [class1(:,1:2);class2(:,1:2)];
outputClasses=[class1(:,3);class2(:,3)];
figure(2)
lda = fitcdiscr(output,outputClasses);

%decisionLine
lda1 = [];
lda2 = [];
errorLDA=0;
for idx = 1:length(output)
    x=output(idx,1)
    y=output(idx,2)
    if y < -(lda.Coeffs(1, 2).Const + lda.Coeffs(1, 2).Linear(1) * x) / lda.Coeffs(1, 2).Linear(2)
        lda1 = [lda1;output(idx,:)];
        if outputClasses(idx)==2
            errorLDA = errorLDA + 1;
        end
    else
        lda2 = [lda2;output(idx,:)];
        if outputClasses(idx)==1
            errorLDA = errorLDA + 1;
        end
    end
end
errorRateLDA = errorLDA/999


scatter(lda1(:,1),lda1(:,2),'b')
hold on
scatter(lda2(:,1),lda2(:,2),'y')

Xlist = get(gca, 'Xlim');%get(gca, 'Xlim'); TODO: change to y axis limits 
Ylist = (lda.Coeffs(1, 2).Linear(2) .* Xlist) / lda.Coeffs(1, 2).Linear(1);
Ylimits = get(gca, 'Ylim')
if Ylist(1) < Ylimits(1) | Ylist(2) > Ylimits(2)
    if Ylist(1) < Ylimits(1)
        Ylist(1) = Ylimits(1);
    end
    if Ylist(2) > Ylimits(2)
        Ylist(2) = Ylimits(2);
    end
    Xlist =  (Ylist-1.8) .* -lda.Coeffs(1, 2).Linear(2)/lda.Coeffs(1,2).Linear(1)% / lda.Coeffs(1, 2).Linear(2);
end
plot(Xlist, Ylist, '-r')
title(['LDA Predictions (error rate = ' num2str(errorRateLDA) ')'])
legend('Predicted Class 1','Predicted Class 2','LDA Line')