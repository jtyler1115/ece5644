function [model1, model2, model3, model4, model5, model6,fit1,fit2,fit3,fit4,fit5,fit6] = emalg(data, ind, k)
    fit1=0
    fit2=0
    fit3=0
    fit4=0
    fit5=0
    fit6=0
    for i = 1:k
        test = [];
        train = [];
        for j = 1:length(data)
            if ind(j) == i
                test = [test; data(j,:)];
            else
                train = [train; data(j,:)];
            end
        end
        model1=gmdistribution.fit(test(:,1:2),1,'CovarianceType','diagonal');
        model2=gmdistribution.fit(test(:,1:2),2,'CovarianceType','diagonal');
        model3=gmdistribution.fit(test(:,1:2),3,'CovarianceType','diagonal');
        model4=gmdistribution.fit(test(:,1:2),4,'CovarianceType','diagonal');
        model5=gmdistribution.fit(test(:,1:2),5,'CovarianceType','diagonal');
        model6=gmdistribution.fit(test(:,1:2),6,'CovarianceType','diagonal');
        fit1=fit1+model1.BIC;
        fit2=fit2+model2.BIC;
        fit3=fit3+model3.BIC;
        fit4=fit4+model4.BIC;
        fit5=fit5+model5.BIC;
        fit6=fit6+model6.BIC;
    end
    fit1=fit1/k;
    fit2=fit2/k;
    fit3=fit3/k;
    fit4=fit4/k;
    fit5=fit5/k;
    fit6=fit6/k;
    model1=gmdistribution.fit(data(:,1:2),1,'CovarianceType','diagonal');
    model2=gmdistribution.fit(data(:,1:2),2,'CovarianceType','diagonal');
    model3=gmdistribution.fit(data(:,1:2),3,'CovarianceType','diagonal');
    model4=gmdistribution.fit(data(:,1:2),4,'CovarianceType','diagonal');
    model5=gmdistribution.fit(data(:,1:2),5,'CovarianceType','diagonal');
    model6=gmdistribution.fit(data(:,1:2),6,'CovarianceType','diagonal');
end