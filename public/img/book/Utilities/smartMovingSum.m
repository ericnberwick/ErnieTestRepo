function [mvavg] = smartMovingSum(x, T)
% [mvsum]=smartMovingSum(x, T). create moving sum series over T days. mvsum
% has T-1 NaN in beginning. Ignore over days with NaN.

assert(T>0);

mvavg=zeros(size(x));

goodDays=isfinite(x);

xx=x;
xx(~goodDays)=0;

numGoodDays=zeros(size(x));

for i=0:T-1
    mvavg=mvavg+backshift(i, xx);
    numGoodDays=numGoodDays+isfinite(backshift(i, x));
end

nonzeroDays=numGoodDays>0;
mvavg(nonzeroDays)=mvavg(nonzeroDays);
mvavg(~nonzeroDays)=NaN;


