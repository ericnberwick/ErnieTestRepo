function atr=movingAtr(days, op, hi, lo, cl)
%  atr=atr(days, op, hi, lo, cl)=Moving Average True Range.

dayrange=max(max(hi-lo, hi-backshift(1, cl)), backshift(1, cl)-lo);
atr=smartMovingAvg(dayrange, days);

