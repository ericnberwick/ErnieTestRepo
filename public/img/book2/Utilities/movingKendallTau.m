function c=movingKendallTau(x, y, T)
%  c=movingKendallTau(x, y, T)
% calculate Kendall Tau (correlation of sign) between x and y for T data. Expect T-1
% NaN in the beginning of the series



assert(size(x, 1) >= size(x, 2), 'x must be column vector.');
assert(size(x, 1) == size(y, 1), 'y must be column vector of same length as x.');

c=NaN(size(x, 1), 1);
for t=T:size(x, 1)
    c(t)=corr(x(t-T+1:t, 1), y(t-T+1:t, 1), 'type', 'Kendall');
end

