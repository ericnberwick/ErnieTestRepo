clear;

x=[ 2 1  1; ...
    3 NaN 3; ...
    0 -1  NaN; ...
    1 NaN -3];

wm=smartwmean(x, 2);

result=[sum([1 0*2^(-1/2) 3*2^(-2/2) 2*2^(-3/2)])/sum([1 2^(-1/2) 2^(-2/2) 2^(-3/2)]) ...
        sum([-1*2^(-1/2) 1*2^(-3/2)])/sum([2^(-1/2) 2^(-3/2)]) ...
        sum([-3 3*2^(-2/2) 1*2^(-3/2)])/sum([1  2^(-2/2) 2^(-3/2)])];

assert(all(approxeq(wm, result, 1e-6)));

result2=smartExpMovingAvg(x, 2);

assert(all(approxeq(wm, result2(end, :), 1e-6)));