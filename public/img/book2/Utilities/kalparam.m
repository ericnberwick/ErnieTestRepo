function [Yhat ]=kalparam(Y,X,delta)
%% Select speed of adaptive updates to regression coefficients

%     delta = 0.7;
    
%% Derive Kalman filter estimates of regression coefficients

    % Find the size of the input matrix, where each column is a different
    % variable and each row is a new observation in the enxt period
    [T,K] = size(X);
    
    % Initialise algorithm
    t = 0;
    
    P = zeros(K,K);
    Beta = zeros(K,1);
    
    mu = (1-delta)/delta;
    Vomega = 1/mu*diag(ones(K,1));
    Vepsilon = 1;  
    
    Yhat = NaN(T,1);

    % Perform iterations
    while t < T
    
        t = t+1;
        
        Yhat(t) = X(t,:)*Beta;
        
        e = Y(t) - Yhat(t);
        R = P + Vomega;
        Q = X(t,:)*R*X(t,:)' + Vepsilon;
        K = R*X(t,:)'/Q;
        P = R - Q*K*K';
 
        Beta = Beta + K*e;

    end
    
%% End of program

% plot(Y)
% hold on
% plot(Yhat,'g')
end