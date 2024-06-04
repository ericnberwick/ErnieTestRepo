x=[ 1 2 -3;
    3 4  NaN;
    NaN 6  20;
    5 8  -10];

mvavg=smartMovingAvg(x, 2);

result=[NaN NaN NaN;
    2 3 -3;
    3 5 20;
    5 7 5];


assert(all(all(mvavg(isfinite(mvavg))==result(isfinite(mvavg)))));
assert(all(all(mvavg(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvavg(isnan(result))))));
assert(all(all(isnan(result(isnan(mvavg))))));

x=[NaN NaN NaN 1 3 5]';

mvavg=smartMovingAvg(x, 2);

result=[NaN NaN NaN 1 2 4]';

assert(all(all(mvavg(isfinite(mvavg))==result(isfinite(mvavg)))));
assert(all(all(mvavg(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvavg(isnan(result))))));
assert(all(all(isnan(result(isnan(mvavg))))));


x=[NaN NaN NaN 1 NaN 3 5]';
mvavg=smartMovingAvg(x, 2);

result=[NaN NaN NaN 1 1 3 4]';

assert(all(all(mvavg(isfinite(mvavg))==result(isfinite(mvavg)))));
assert(all(all(mvavg(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvavg(isnan(result))))));
assert(all(all(isnan(result(isnan(mvavg))))));

x=[1 2 3 4 1 2 3 4 1 2 3 4]';
mvavg=smartMovingAvg(x, 3, 4);

assert(all(isnan(mvavg(1:8))));
assert(all(mvavg(9:12)==[1 2 3 4]'));

