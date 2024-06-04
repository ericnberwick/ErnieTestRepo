function y = smartwcov(x)
% y=SMARTWCOV(x)    Weighted covariance n of finite elements, with
% half-life = size(x, 1).
% Rows of observations, columns of variables
%   Same as COV except that it ignores NaN and Inf instead of 
%   propagating them
%
%   Normalizes by N, not N-1

s=size(x, 1);
h=s;
b=(1:s)/h;
w=2.^b;
p=repmat(w'/smartsum(w), [1 size(x, 2)]);

xc=x-repmat(smartsum(x.*p,1), [s 1]);  % Remove mean

y=xc'*diag(p(:, 1))*xc;
