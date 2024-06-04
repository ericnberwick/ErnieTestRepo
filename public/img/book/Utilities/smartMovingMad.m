function sd=movingMad(x, T, varargin)
% calculate Mad of x over T days. Expect T-1
% NaN in the beginning of the series
% [mvstd]=movingMad(x, lookback, period) creates moving mad of lookback
% periods. I.e. data is sampled every period.


sd=NaN(size(x));

if (nargin == 2)
    for t=T:size(x, 1)       
        sd(t, :)=smartmad(x(t-T+1:t, :));
    end
else
    period=varargin{1};
    for t=T*period:size(x, 1)
        sd(t, :)=smartmad(x(t-T*period+1:t, :));
    end
end 
