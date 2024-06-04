x=[ 1 2;
    3 4;
    NaN 6;
    5 8];

mvcorr=smartMovingCorrcoef(x(:,1), x(:,2), 3);

result=[NaN;
        NaN;
        1;
        1];


assert(all(all(mvcorr(isfinite(mvcorr))==result(isfinite(mvcorr)))));
assert(all(all(mvcorr(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvcorr(isnan(result))))));
assert(all(all(isnan(result(isnan(mvcorr))))));

x=[NaN NaN NaN 1 3 5]';
y=[1 1 1 1 1 2]';
mvcorr=smartMovingCorrcoef(x, y, 2);

result=[NaN NaN NaN NaN NaN 1]';

assert(all(all(mvcorr(isfinite(mvcorr))==result(isfinite(mvcorr)))));
assert(all(all(mvcorr(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvcorr(isnan(result))))));
assert(all(all(isnan(result(isnan(mvcorr))))));


x=[NaN NaN NaN 1 NaN 3 5]';
y=[NaN NaN NaN 2 3 1 3]';
mvcorr=smartMovingCorrcoef(x,y, 3);

result=[NaN NaN NaN NaN NaN -1 1]';

assert(all(all(mvcorr(isfinite(mvcorr))==result(isfinite(mvcorr)))));
assert(all(all(mvcorr(isfinite(result))==result(isfinite(result)))));
assert(all(all(isnan(mvcorr(isnan(result))))));
assert(all(all(isnan(result(isnan(mvcorr))))));

