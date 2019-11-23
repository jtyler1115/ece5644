function[seq,cvparam] = function1(S, K, x0,data);
    
    data=[0 0 0;data];
    T=2;
    %K=1;
    %S=1;
    A=[1 T (T^2)/2;0 1 T;0 0 1];
    B = [0;0;0];
    G = [1; 1; 1;];
    C =[1 0 0];
    D = [0 0 0;0 0 0];

    %figure()
    plot(data(:,2),data(:,3),'-x')
    title('All Data')
    xlabel('b(t)')
    ylabel('h(t)')
    Plant = ss(A,[B G],C,0,1,'inputname',{'u' 'w'},'outputname','y');

    Q = K; %omega
    R = S;
    [kalmf,L,P,M] = kalman(Plant,Q,R);

    a=A;
    b=[B B 0*B];
    c=[C; C];
    d=[0 0 0;0 0 1];
    %P=ss(a,b,c,d);
    sys = parallel(P,kalmf,1,1,[],[]);
    SimModel = feedback(sys,1,4,2,1);   % Close loop around input #4 and output #2
    SimModel = SimModel([1 3],[1 2 3]); % Delete yv from I/O list

    figure()
    t=data(:,1);
    u1=data(:,2);
    n = length(t);
    rng default
    w1 = sqrt(Q)*randn(n,1);
    v1 = sqrt(R)*randn(n,1);
    [out1,x1] = lsim(SimModel,[w1,v1,u1]);

    y1 = out1(:,1);   % true response
    ye1 = out1(:,2);  % filtered response
    yv1 = y1 + v1;     % measured response
    %Compare the true and filtered responses graphically.

    subplot(211), plot(t,y1,'--',t,ye1,'-'),
    xlabel('No. of samples'), ylabel('Output')
    title('Kalman filter response')
    subplot(212), plot(t,y1-yv1,'-.',t,y1-ye1,'-'),
    xlabel('No. of samples'), ylabel('Error')

    figure()
    u2=data(:,3);
    n = length(t);
    rng default
    w2 = sqrt(Q)*randn(n,1);
    v2 = sqrt(R)*randn(n,1);
    [out2,x2] = lsim(SimModel,[w2,v2,u2]);

    y2 = out2(:,1);   % true response
    ye2 = out2(:,2);  % filtered response
    yv2 = y2 + v2;     % measured response
    %Compare the true and filtered responses graphically.

    subplot(211), plot(t,y2,'--',t,ye2,'-'),
    xlabel('No. of samples'), ylabel('Output')
    title('Kalman filter response')
    subplot(212), plot(t,y2-yv2,'-.',t,y2-ye2,'-'),
    xlabel('No. of samples'), ylabel('Error')
    
    
    seq=[t ye1 ye2];
    sum=0;
    for i=1:length(t)
        sum=sum+(abs(ye1(i)-data(i,2))+abs(ye2(i)-data(i,3)))^2;
    end
    cvparam=sum/length(t);
end