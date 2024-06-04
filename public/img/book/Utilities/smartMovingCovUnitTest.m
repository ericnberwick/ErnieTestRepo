x=[ 1 2;
    3 4;
    NaN 6;
    5 8];

mvcov=smartMovingCov(x(:,1), x(:,2), 3);

result=[NaN;
        NaN;
        1;
        2];


assert(all(all(mvcov(isfinite(mvcov))==result(isfinite(mvcov)))));
assert(all(all(mvcov(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvcov(isnan(result))))));
assert(all(all(isnan(result(isnan(mvcov))))));

x=[NaN NaN NaN 1 3 5]';
y=[1 1 1 1 1 2]';
mvcov=smartMovingCov(x, y, 2);

result=[NaN NaN NaN NaN 0 0.5]';

assert(all(all(mvcov(isfinite(mvcov))==result(isfinite(mvcov)))));
assert(all(all(mvcov(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvcov(isnan(result))))));
assert(all(all(isnan(result(isnan(mvcov))))));


x=[NaN NaN NaN 1 NaN 3 5]';
y=[NaN NaN NaN 2 3 1 3]';
mvcov=smartMovingCov(x,y, 3);

result=[NaN NaN NaN NaN NaN -0.5 1]';

assert(all(all(mvcov(isfinite(mvcov))==result(isfinite(mvcov)))));
assert(all(all(mvcov(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvcov(isnan(result))))));
assert(all(all(isnan(result(isnan(mvcov))))));


x=[1 2 3 -4 5]';

mvcov=smartMovingCov(x, x, 2);

mvstd=smartMovingStd(x, 2);

assert(mvcov == mvstd.^2);

