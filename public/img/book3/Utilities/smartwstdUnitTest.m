clear;

x=[ 2 1  1; ...
    3 NaN 3; ...
    0 -1  NaN; ...
    1 NaN -3];

wstd=smartwstd(x, 2);

result2=smartExpMovingStd(x, 2);

assert(all(approxeq(wstd, result2(end, :), 1e-6)));