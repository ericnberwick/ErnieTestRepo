function [C,sda,CC,e] = wcov(R,h);
% [C,sda,CC,e]  = wcov(R,h);
%    produces a weighted covariance matrix using a specified half-life
%    also produces standard deviations, correlations and expected values
%    variables:
%          R: matrix of s observations (states) on n variables
%          h: half-life (0 for equal weights)
%          C: n*n covariance matrix 
%        sda: n*1 vector of standard deviations
%         CC: n*n matrix of correlation coefficients
%          e: n*1 vector of expected returns  
%          
%  weight for observation t is 2^(t/h), scaled to sum to 1.0  

%  copyright 1995, William F. Sharpe
%  wfsharpe@leland.stanford.edu
%  this version Nov. 2, 1995

    % if matrix has more rows than columns, transpose it
       if size(R,1) > size(R,2)
           R = R';
       end;
    % get dimensions
        [n,s] = size(R);

    % set up weight vector
      if h == 0
         x = zeros(1,s);
       else
        x = (1:s)/h;
      end;
        w = (2.^x);
        p = w/sum(w);

    % compute expected values
        e = R*p';

    % compute matrix of deviations
        d = R - e*ones(1,s);

    % compute weighted covariances
        C = d*diag(p)*d';

    % compute standard deviations
       sda = sqrt(diag(C));

    % compute correlations (if sda = 0, corr = 0)
       z = sda*sda';
       z = z + (z==0);
       CC = C./z;
    

        
