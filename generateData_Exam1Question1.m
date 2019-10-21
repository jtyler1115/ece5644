m(:,1) = [-1;0]; Sigma(:,:,1) = 0.1*[10 -4;-4,5]; % mean and covariance of data pdf conditioned on label 3
m(:,2) = [1;0]; Sigma(:,:,2) = 0.1*[5 0;0,2]; % mean and covariance of data pdf conditioned on label 2
m(:,3) = [0;1]; Sigma(:,:,3) = 0.1*eye(2); % mean and covariance of data pdf conditioned on label 1
classPriors = [0.15,0.35,0.5]; thr = [0,cumsum(classPriors)];
N = 10000; u = rand(1,N); L = zeros(1,N); x = zeros(2,N);
figure(1),clf, colorList = 'rbg';
for l = 1:3
    indices = find(thr(l)<=u & u<thr(l+1)); % if u happens to be precisely 1, that sample will get omitted - needs to be fixed
    L(1,indices) = l*ones(1,length(indices));
    x(:,indices) = mvnrnd(m(:,l),Sigma(:,:,l),length(indices))';
    figure(1), plot(x(1,indices),x(2,indices),'.','MarkerFaceColor',colorList(l)); axis equal, hold on,
    labels(:,indices)=l;
    length(indices)
end

idx = 1
for val = x
    prob1 = mvnpdf(val,m(:,1),Sigma(:,:,1));
    prob2 = mvnpdf(val,m(:,2),Sigma(:,:,2));
    prob3 = mvnpdf(val,m(:,3),Sigma(:,:,3));
    if (prob1/prob2)>(classPriors(1)/classPriors(2))
        predict = 1;
        if (prob3/prob1)>(classPriors(3)/classPriors(1))
            predict = 3;
        end
    else
        predict = 2;
        if (prob3/prob2)>(classPriors(3)/classPriors(2))
            predict = 3;
        end
    end
    pred(:,idx)=predict;
    idx = idx + 1;
end

x(3,:)=labels;
x(4,:)=pred;

figure(2)
colorList2 = 'ybg'
conf=zeros(3,3);
idx = 0
for entry = x
    if entry(4) == 1
        scatter(entry(1),entry(2),colorList2(entry(3)),'.')
        hold on;
    end
    if entry(4) == 2
        scatter(entry(1),entry(2),colorList2(entry(3)),'*')
        hold on;
    end
    if entry(4) == 3
        scatter(entry(1),entry(2),colorList2(entry(3)),'^')
        hold on;
    end
    if entry(4) ~= entry(3)
        conf(entry(4),entry(3))=conf(entry(4),entry(3)) + 1;
    end
    idx = idx + 1
end
figure
totalWrong = sum(conf,'all');
percentError = totalWrong/N;