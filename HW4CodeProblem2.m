clear;

numSamples = 1000;
class1Mean = [0; 0];
class1Covariance = [1 0;0 1];
class1Prior = .35;
class2Prior = .65;
X1=[];
X2=[];
testX1=[];
testX2=[];
Pred1=[];
Pred2=[];
error = 0;
K=10;
for idx = 1:numSamples
    if rand() < class1Prior
        %class1
        X=randn(1,2)*chol(class1Covariance)+class1Mean;
        X=[X(1,:)];
        X1=[X1;X];
        trueClass=1;
    else
        %class2
        X=[rand()*2*pi-pi,rand()+2];
        X=[X(1,:)];
        X2=[X2;X];
        trueClass=2;
    end
    if rand() < class1Prior
        %class1
        testX=randn(1,2)*chol(class1Covariance)+class1Mean;
        testX=[testX(1,:)];
        testX1=[testX1;testX];
    else
        %class2
        testX=[rand()*2*pi-pi,rand()+2];
        testX=[testX(1,:)];
        testX2=[testX2;testX];
    end
end

[X2(:,1),X2(:,2)]=pol2cart(X2(:,1),X2(:,2));
classes=cell(length([X1;X2]),1);
classes(1:length(X1))={'minus'};
classes(length(X1)+1:length([X1;X2]))={'plus'};
sample.data=[X1;X2];
sample.labels=classes;
gaussianModel=fitcsvm(sample.data,sample.labels);
cvgaussianModel=crossval(gaussianModel);
linearModel=fitclinear(sample.data,sample.labels,'KFold',10);
noklinearModel=fitclinear(sample.data,sample.labels);
%construction of model with error squared

%here we adda third dimension that is r^2
enhancedX1=[X1,X1(:,2).^2];
enhancedX2=[X2,X2(:,2).^2];
[enhancedX2(:,1),enhancedX2(:,2)]=pol2cart(enhancedX2(:,1),enhancedX2(:,2));
enhancedclasses=cell(length([enhancedX1;enhancedX2]),1);
enhancedclasses(1:length(enhancedX1))={'minus'};
enhancedclasses(length(enhancedX1)+1:length([enhancedX1;enhancedX2]))={'plus'};
enhancedsample.data=[enhancedX1;enhancedX2];
enhancedsample.labels=enhancedclasses;
enhancedgaussianModel=fitcsvm(enhancedsample.data,enhancedsample.labels,'BoxConstraint',1);
enhancedcvgaussianModel=crossval(enhancedgaussianModel);
enhancedlinearModel=fitclinear(enhancedsample.data,enhancedsample.labels,'KFold',10);
nokenhancedlinearModel=fitclinear(enhancedsample.data,enhancedsample.labels);


% for ind = 1:.3
%     test=[];
%     train=[];
%     for el = 1:length(indices)
%         if indices(el)==ind
%             test=[test; data(el,:)];
%         else
%             train=[train; data(el,:)];
%         end
%     end
% end

%create test data
testX1=[X1,X1(:,2).^2];
testX2=[X2,X2(:,2).^2];
[testX2(:,1),testX2(:,2)]=pol2cart(testX2(:,1),testX2(:,2));
testclasses=cell(length([testX1;testX2]),1);
testclasses(1:length(testX1))={'minus'};
testclasses(length(testX1)+1:length([testX1;testX2]))={'plus'};
testsample.data=[testX1;testX2];
testsample.labels=testclasses;

%make predictions
koriginalGaussianPredictions=kfoldPredict(cvgaussianModel);
kenhancedGaussianPredictions=kfoldPredict(enhancedcvgaussianModel);
koriginalLinearPredictions=kfoldPredict(linearModel);
kenhancedLinearPredictions=kfoldPredict(enhancedlinearModel);

gaussianError=1-sum(strcmp(kenhancedGaussianPredictions,enhancedsample.labels))/length(enhancedsample.labels);
linearError=1-sum(strcmp(kenhancedLinearPredictions,enhancedsample.labels))/length(enhancedsample.labels);

finalGaussian=predict(enhancedgaussianModel,testsample.data);
finalLinear=predict(nokenhancedlinearModel,testsample.data);
finalGaussianError=1-sum(strcmp(finalGaussian,testsample.labels))/length(testsample.labels);
finalLinearError=1-sum(strcmp(finalLinear,testsample.labels))/length(testsample.labels);

figure(1)
scatter(X1(:,1),X1(:,2),'r')
hold on
scatter(X2(:,1),X2(:,2),'g')
title('Generated Data Points')
legend('Class Minus','Class Plus')

figure(2)
scatter3(enhancedX1(:,1),enhancedX1(:,2),enhancedX1(:,3),'r')
hold on
scatter3(enhancedX2(:,1),enhancedX2(:,2),enhancedX2(:,3),'g')
title('Enhanced Data Points')
legend('Class Minus','Class Plus')

%figure(3)
%correct class1
%corrClass1
%correct class2
%corrClass2
%class1 but predict class2
%wrongClass2
%class2 but predict class1

for i = 1:length(testsample.data)
    if strcmp(testsample.labels(i),finalGaussian(i))
        if strcmp(testsample.labels(i),'minus')
            outInd(i,:)=[1, 0, 0, 0];
        else
            outInd(i,:)=[0, 1, 0, 0];
        end
    else
        if strcmp(testsample.labels(i),'minus')
            outInd(i,:)=[0, 0, 1, 0];
        else
            outInd(i,:)=[0, 0, 0, 1];
        end
    end
end
outInd=boolean(outInd);
figure(3)
scatter3(testsample.data(outInd(:,1),1),testsample.data(outInd(:,1),2),testsample.data(outInd(:,1),3),'^','g')
hold on
scatter3(testsample.data(outInd(:,2),1),testsample.data(outInd(:,2),2),testsample.data(outInd(:,2),3),'*','g')
scatter3(testsample.data(outInd(:,3),1),testsample.data(outInd(:,3),2),testsample.data(outInd(:,3),3),'^','r')
hold on
scatter3(testsample.data(outInd(:,4),1),testsample.data(outInd(:,4),2),testsample.data(outInd(:,4),3),'*','r')
hold on
title(['Gaussian Classified Data Points (Probability of Error = ' num2str(finalGaussianError) ')'])
legend('Correct Prediction of Class Minus','Correct Prediction of Class Plus','Incorrect Prediction of Class Plus','Incorrect Prediction of Class Minus')

for i = 1:length(testsample.data)
    if strcmp(testsample.labels(i),finalLinear(i))
        if strcmp(testsample.labels(i),'minus')
            outIndLin(i,:)=[1, 0, 0, 0];
        else
            outIndLin(i,:)=[0, 1, 0, 0];
        end
    else
        if strcmp(testsample.labels(i),'minus')
            outIndLin(i,:)=[0, 0, 1, 0];
        else
            outIndLin(i,:)=[0, 0, 0, 1];
        end
    end
end
outIndLin=boolean(outIndLin);
figure(4)
scatter3(testsample.data(outIndLin(:,1),1),testsample.data(outIndLin(:,1),2),testsample.data(outIndLin(:,1),3),'^','g')
hold on
scatter3(testsample.data(outIndLin(:,2),1),testsample.data(outIndLin(:,2),2),testsample.data(outIndLin(:,2),3),'*','g')
hold on
scatter3(testsample.data(outIndLin(:,3),1),testsample.data(outIndLin(:,3),2),testsample.data(outIndLin(:,3),3),'^','r')
hold on
scatter3(testsample.data(outIndLin(:,4),1),testsample.data(outIndLin(:,4),2),testsample.data(outIndLin(:,4),3),'*','r')
title(['Linear Classified Data Points (Probability of Error = ' num2str(finalLinearError) ')'])
legend('Correct Prediction of Class Minus','Correct Prediction of Class Plus','Incorrect Prediction of Class Plus','Incorrect Prediction of Class Minus')
