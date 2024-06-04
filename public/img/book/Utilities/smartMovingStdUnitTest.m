x=[ 1 2 -3;
    3 4  NaN;
    NaN 6  20;
    5 8  -10];

mvstd=smartMovingStd(x, 2);

result=[NaN NaN NaN;
    1 1 0;
    0 1 0;
    0 1 15];


assert(all(mvstd(isfinite(mvstd))==result(isfinite(mvstd))));
assert(all(mvstd(isfinite(result))==result(isfinite(result))));
assert(all(mvstd(isnan(result))));
assert(all(result(isnan(mvstd))));


x=[NaN NaN NaN 1 3 5]';

mvstd=smartMovingStd(x, 2);

result=[NaN NaN NaN 0 1 1]';

assert(all(all(mvstd(isfinite(mvstd))==result(isfinite(mvstd)))));
assert(all(all(mvstd(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvstd(isnan(result))))));
assert(all(all(isnan(result(isnan(mvstd))))));


x=[NaN NaN NaN 1 NaN 3 5]';
mvstd=smartMovingStd(x, 2);

result=[NaN NaN NaN 0 0 0 1]';

assert(all(all(mvstd(isfinite(mvstd))==result(isfinite(mvstd)))));
assert(all(all(mvstd(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvstd(isnan(result))))));
assert(all(all(isnan(result(isnan(mvstd))))));

x=[1 2 3 4 -1 -2 -3 -4 1 2 3 4 -1 -2 -3 -4 1 2 3 4 -1 -2 -3 -4]';
mvavg=smartMovingAvg(x, 6, 4);

assert(all(isnan(mvavg(1:20))));
assert(all(mvavg(21:24)==[0 0 0 0]'));

