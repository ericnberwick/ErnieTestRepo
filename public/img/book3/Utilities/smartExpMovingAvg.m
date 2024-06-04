function [mvavg] = smartExpMovingAvg(x, T, varargin)
% [mvavg]=movingExpAvg(x, T). create exponential moving average series with halflife=T days. mvavg
% has no NaN in beginning; it uses any and all preceding data for
% computation. Ignore days with NaN. 
% [mvavg]=movingExpAvg(x, T, cutoff) creates EMA, with cutoff days used in the moving average.

assert(0, 'DEFUNCT! Use EMA(x, T) instead!');

assert(T>0);

mvavg=zeros(size(x));

goodDays=isfinite(x);

weights=zeros(size(x));

if (nargin>2)
    numDays=varargin{1};
else
    numDays=size(x,1);
end

for i=0:numDays-1
    w=2^(-i/T)*ones(size(x));      
    xlag=w.*backshift(i, x);
    w(~isfinite(xlag))=0;
    xlag(~isfinite(xlag))=0;
    
    mvavg=mvavg+xlag;
    weights=weights+w;
    
end

mvavg=mvavg ./ weights;

mvavg(~goodDays)=NaN;

