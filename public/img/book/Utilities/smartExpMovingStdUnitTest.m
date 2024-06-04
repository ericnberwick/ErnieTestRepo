clear;

x=[ 2 -1 3; ...
    5 10 -15]';

mvavg=smartExpMovingAvg(x, 2);

result=[2 (-1+2*2^(-1/2))/(1+2^(-1/2)) (3-1*2^(-1/2)+2*2^(-2/2))/(1+2^(-1/2)+2^(-2/2)); ...
        5 (10+5*2^(-1/2))/(1+2^(-1/2)) (-15+10*2^(-1/2)+5*2^(-2/2))/(1+2^(-1/2)+2^(-2/2))]';


v=(x-result).^2;

result1=sqrt(smartExpMovingAvg(v, 2));

mvstd=smartExpMovingStd(x, 2);

assert(all(approxeq(mvstd, result1, 1e-6)));

x=[ 2 -1 NaN; ...
    5 NaN -15]';

mvavg=smartExpMovingAvg(x, 2);


result=[2 (-1+2*2^(-1/2))/(1+2^(-1/2)) NaN; ...
        5 NaN (-15 +5*2^(-2/2))/(1+2^(-2/2))]';


v=(x-result).^2;

result1=sqrt(smartExpMovingAvg(v, 2));

mvstd=smartExpMovingStd(x, 2);

assert(all(approxeq(mvstd, result1, 1e-6)));
