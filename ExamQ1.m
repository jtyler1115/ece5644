clear all
close all
%delete (findall(0));

dataset=readmatrix('Q1.csv');
class1=[];
class2=[];
test=[];
train=[];
for pt = 1:length(dataset)
    if dataset(pt,3) < 0
        class1 = [class1; dataset(pt,:)];
    else
        class2 = [class2; dataset(pt,:)];
    end
    if pt <= length(dataset)/10
        test = [test; dataset(pt, :)];
    else
        train = [train; dataset(pt, :)];
    end
end

tree = fitctree(train(:,1:2),train(:,3),'SplitCriterion','gdi','MaxNumSplits',11,'NumBins',50);
predicted = predict(tree,test(:,1:2));

bag = TreeBagger(7,train(:,1:2),train(:,3),'SplitCriterion','gdi','MaxNumSplits',11,'NumBins',50);
bagpredicted = predict(bag,test(:,1:2));

adaboostTemp = templateTree('SplitCriterion','gdi','MaxNumSplits',11);
adaboost = fitensemble(train(:,1:2),train(:,3),'AdaBoostM1',7,adaboostTemp);
boostpredicted = predict(adaboost,test(:,1:2));

view(tree,'Mode','graph');
%view(bag,'Mode','graph');
figure()
conf1 = confusionmat(test(:,3),predicted);
confusionchart(conf1)
title('Single Tree')

figure()
conf2 = confusionmat(num2str(test(:,3)),bagpredicted);
confusionchart(conf2)
title('Bag')

figure()
conf3 = confusionmat(test(:,3),boostpredicted);
confusionchart(conf3)
title('AdaBoost')

figure()
scatter(class1(:,1),class1(:,2),'.','r');
hold on
scatter(class2(:,1),class2(:,2),'x','k');
hold on
title("Full Dataset")

figure()
gscatter(test(:,1),test(:,2),predicted,'rgb');
title("Test Data (Tree Predicted)")

figure()
gscatter(test(:,1),test(:,2),bagpredicted,'grb');
title("Test Data (Bag Predicted)")

figure()
gscatter(test(:,1),test(:,2),boostpredicted,'grb');
title("Test Data (Boost Predicted)")

x = -4:.1:4;
y = -4:.1:4;
grid = [];
for i = x
    for j = y
        grid = [grid; i,j];
    end
end

figure()
gscatter(grid(:,1),grid(:,2),predict(tree,grid),'gb');
hold on
scatter(class1(:,1),class1(:,2),'.','r');
hold on
scatter(class2(:,1),class2(:,2),'x','k');
hold on
title('Classification Tree Prediction');
figure()
gscatter(grid(:,1),grid(:,2),predict(bag,grid),'gb');
hold on
scatter(class1(:,1),class1(:,2),'.','r');
hold on
scatter(class2(:,1),class2(:,2),'x','k');
hold on
title('Bagging Tree Prediction');
figure()
gscatter(grid(:,1),grid(:,2),predict(adaboost,grid),'gb');
hold on
scatter(class1(:,1),class1(:,2),'.','r');
hold on
scatter(class2(:,1),class2(:,2),'x','k');
hold on
title('Adaboost Prediction');