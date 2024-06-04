function [ myCCI ] = smartMovingCCI( hi, lo, cl, lookback )
%[ myCCI ] = CCI( hi, lo, cl, lookback )

TP=(hi+lo+cl)/3;

ma=smartMovingAvg(TP, lookback);

meanDev=smartMovingAvg(abs(TP-ma), lookback);

myCCI=(TP-ma)./(0.015*meanDev);


end

