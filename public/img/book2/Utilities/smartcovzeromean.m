function y = smartcov(x)
%SMARTCOV    Covariance n of finite elements.
% Rows of observations, columns of variables
%   Same as COV except that it ignores NaN and Inf instead of 
%   propagating them
%
%   Normalizes by N, not N-1


xc=x; 

for m=1:size(x, 2)
    for n=m:size(x, 2)
        %         fprintf(1, '%i %i\n', m, n);
        y(m, n)=smartmean(xc(:, m).*xc(:, n));
        y(n, m)=y(m, n);
    end
end