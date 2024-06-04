function [mvavg] = smartExpMovingAvg(x, T)
% [mvavg]=movingExpAvg(x, T). create exponential moving average series over T days. mvavg
% has T-1 NaN in beginning. Ignore over days with NaN. The exponent is exp(-x/T). The average cutoff
% at 3*T.

assert(T>0);

mvavg=zeros(size(x));

goodDays=isfinite(x);

xx=x;
xx(~goodDays)=0;

numGoodDays=zeros(size(x));

for i=0:3*T-1
    mvavg=mvavg+exp(-i/T)*backshift(i, xx);
    numGoodDays=numGoodDays+isfinite(backshift(i, x));
end

nonzeroDays=numGoodDays>0;
mvavg(nonzeroDays)=mvavg(nonzeroDays) ./ numGoodDays(nonzeroDays);
mvavg(~nonzeroDays)=NaN;


