function [resid, beta]=mydetrend(y)
% [resid, beta]=mydetrend(y): y = [0:size(y, 1)-1)' ones(size(y, 1),
% 1)]*beta + resid
p=1;

[nobs junk] = size(y);
u = ones(nobs,1);

timep = zeros(nobs,p);
t = 0:nobs-1;
timep = (t');
xmat = [timep u];

xpxi = inv(xmat'*xmat);
beta = xpxi*(xmat'*y);
resid = y - xmat*beta;

