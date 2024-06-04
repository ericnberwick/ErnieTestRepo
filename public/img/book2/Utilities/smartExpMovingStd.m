function [mvstd]=smartExpMovingStd(x, T)
% [mvstd]=smartExpMovingStd(x, T): computes smartMovingStd of x with
% exponentially decreasing weights with halflife T. It uses any and all
% data so there is no NaN in the beginning of data.

v=(x-smartExpMovingAvg(x, T)).^2;

avgv=smartExpMovingAvg(v, T);

mvstd=sqrt(avgv);