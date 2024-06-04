function [mvprct] = smartMovingPercentile(x, T, n)
% [mvprct]=smartMovingPercentile(x, T). create moving nth-percentile series
% over T days. mvprct
% has T-1 NaN in beginning. Ignore over days with NaN.
% This differs from prctile because it returns the closest actual value in
% x, not interpolated value. E.g. prctile((1:5)', 25)=1.75, but
% smartMovingPercentile((1:5)', 5, 25)=[NaN ... 1]

assert(T>0);
m=min(T, round(0.01*n*T));
m=max(1, m);

mvprct = NaN*zeros(size(x));

for t=T:size(x, 1)
    y=x(t-T+1:t, :);
    y=sort(y);
    mvprct(t, :)=y(m, :);
    
    isbad=~isfinite(y);
    if (any(any(isbad)))
        badcol=any(isbad, 1);
        for c=1:length(badcol)
            myy=y(:, badcol);
            myy(~isfinite(myy))=[];
            myT=length(myy);
            
            mym=min(myT, round(0.01*n*myT));
            mym=max(1, mym);
            
            myprct(t, badcol) = y(mym, badcol);
        end
    end
end

