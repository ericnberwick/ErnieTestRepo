function [mvstd]=smartwtd(x, T)
% [mvstd]=smartwstd(x, T): computes smartstd of x with
% exponentially decreasing weights with halflife T. 

v=(x-smartExpMovingAvg(x, T)).^2;

avgv=smartwmean(v, T);

mvstd=sqrt(avgv);

mvstd(~isfinite(x(end, :)))=NaN;