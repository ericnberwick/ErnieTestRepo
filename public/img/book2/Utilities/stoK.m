function K=stoK(hi, lo, cl, x, y)
% K=stoK(hi, lo, cl, x, y)
% y-day SMA of %K(fast, x-day lookback)

myhi=smartMovingMax(hi, x);
mylo=smartMovingMin(lo, x);

K=smartMovingAvg(100*(cl-mylo)./(myhi-mylo), y);
