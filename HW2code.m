clear;

numSamples = 400;
class1Mean = [0;0];
class2Mean = [3;3];
class1Covariance = [1 0;0 1];
class2Covariance = [1 0;0 1];
class1Prior = .05;
class2Prior = .95;
X1=[];
X2=[];
Pred1=[];
Pred2=[];
error = 0;
for idx = 1:numSamples
    if rand() < class1Prior
        X=randn(1,2)*chol(class1Covariance)+class1Mean;
        X=X(1,:);
        X1=[X1;X];
        trueClass=1;
    else
        %class2
        X=randn(1,2)*chol(class2Covariance)+class2Mean;
        X=X(1,:);
        X2=[X2;X];
        trueClass=2
    end
    
    decision1 = class1Prior*mvnpdf(X',class1Mean,class1Covariance);
    decision2 = class2Prior*mvnpdf(X',class2Mean,class2Covariance);
    if decision1 > decision2
        Pred1=[Pred1;X];
        if trueClass==2
            error = error + 1;
        end
    else
        Pred2=[Pred2;X];
        if trueClass==1
            error = error + 1;
        end
    end
end

errorRateMAP = error/numSamples

figure(1)
scatter(X1(:,1),X1(:,2),'r')
hold on
scatter(X2(:,1),X2(:,2),'g')
title('Generated Data Points')
legend('Class 1','Class 2')

figure(2)
scatter(Pred1(:,1),Pred1(:,2),'b')
hold on
scatter(Pred2(:,1),Pred2(:,2),'y')
title(['MAP Predictions (error rate = ' num2str(errorRateMAP) ')'])
legend('Predicted Class 1','Predicted Class 2')

output = [X1;X2];
outputClasses = ones([400,1])
for idx = 1:length(X2)
    outputClasses(401-idx)=2;
end
%test1 = output(:,1)'
%test2 = output(:,2)'
%lda = fitcdiscr(output(:,1)',output(:,2)');
figure(3)
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
errorRateLDA = errorLDA/numSamples


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
    Xlist = Ylist .* lda.Coeffs(1,2).Linear(1) / lda.Coeffs(1, 2).Linear(2);
end
plot(Xlist, Ylist, '-r')
title(['LDA Predictions (error rate = ' num2str(errorRateLDA) ')'])
legend('Predicted Class 1','Predicted Class 2','LDA Line')