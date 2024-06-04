function sd=smartMovingStd(x, T)
% calculate standard deviation of x over T days. Expect T-1
% NaN in the beginning of the series
% This version is inefficient.

sd=NaN*ones(size(x));

for t=T:length(x)
   sd(t, :)=smartstd(x(t-T+1:t, :));
end