clear all;
close all;

train=readmatrix('Q2train.csv');
test=readmatrix('Q2test.csv');
[seq,cvparam] = function1(.15,.15,0,train);

output=zeros(length(seq)*2-1,3);
for i=1:length(output)
    if rem(i,2)==1
        output(i,:)=seq((i+1)/2,:);
    end
end
for i=1:length(output)
    if rem(i,2)==0
        output(i,:)=(output(i-1,:)+output(i+1,:))/2
    end
end
figure()
svect=.1:.1:10;
kvect=.1:.1:10;
S=[];
K=[];
Z=[];
% for i=1:length(svect)
%     for j=1:length(svect)
%         [testSeq,testParam]=function1(svect(i),kvect(j),0,test);
%         Z(i,j)=testParam;
%     end
% end
% contour(Z);
% [M,I]=min(Z);

%S=.2,K=.2

% T=2;
% K=1;
% S=1;
% A=[1 T (T^2)/2;0 1 T;0 0 1];
% B = [0;0;0];
% G = [1; 1; 1;];
% C =[1 0 0];
% D = [0 0 0;0 0 0];
% 
figure()
plot(train(:,2),train(:,3),'-x')
figure()
plot(train(:,2),train(:,3),'x')
hold on
plot(test(:,2),test(:,3),'x')
hold on
plot(seq(:,2),seq(:,3),'-x')
xlabel('b(t)')
ylabel('h(t)')
legend('training data','testing data','filtered data')
title('All data with filter')
% 
% Plant = ss(A,[B G],C,0,-1,'inputname',{'u' 'w'},'outputname','y');
% 
% Q = K; %omega
% R = S;
% [kalmf,L,P,M] = kalman(Plant,Q,R);
% 
% a=A;
% b=[B B 0*B];
% c=[C; C];
% d=[0 0 0;0 0 1];
% %P=ss(a,b,c,d);
% sys = parallel(P,kalmf,1,1,[],[]);
% SimModel = feedback(sys,1,4,2,1);   % Close loop around input #4 and output #2
% SimModel = SimModel([1 3],[1 2 3]); % Delete yv from I/O list
% 
% figure()
% t=train(:,1);
% u1=train(:,2);
% n = length(t);
% rng default
% w1 = sqrt(Q)*randn(n,1);
% v1 = sqrt(R)*randn(n,1);
% [out1,x1] = lsim(SimModel,[w1,v1,u1]);
% 
% y1 = out1(:,1);   % true response
% ye1 = out1(:,2);  % filtered response
% yv1 = y1 + v1;     % measured response
% %Compare the true and filtered responses graphically.
% 
% subplot(211), plot(t,y1,'--',t,ye1,'-'), 
% xlabel('No. of samples'), ylabel('Output')
% title('Kalman filter response')
% subplot(212), plot(t,y1-yv1,'-.',t,y1-ye1,'-'),
% xlabel('No. of samples'), ylabel('Error')
% 
% figure()
% u2=train(:,3);
% n = length(t);
% rng default
% w2 = sqrt(Q)*randn(n,1);
% v2 = sqrt(R)*randn(n,1);
% [out2,x2] = lsim(SimModel,[w2,v2,u2]);
% 
% y2 = out2(:,1);   % true response
% ye2 = out2(:,2);  % filtered response
% yv2 = y2 + v2;     % measured response
% %Compare the true and filtered responses graphically.
% 
% subplot(211), plot(t,y2,'--',t,ye2,'-'), 
% xlabel('No. of samples'), ylabel('Output')
% title('Kalman filter response')
% subplot(212), plot(t,y2-yv2,'-.',t,y2-ye2,'-'),
% xlabel('No. of samples'), ylabel('Error')
