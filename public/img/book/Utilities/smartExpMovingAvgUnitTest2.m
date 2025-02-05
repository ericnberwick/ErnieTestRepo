clear;





%%%
x=[ 2 -1 3; ...
    5 10 -15]';

mvavg=smartExpMovingAvg(x, 2);

% result=[NaN NaN NaN NaN NaN (6+exp(-1/2)*1-exp(-2/2)*2+exp(-3/2)*3-exp(-4/2)*1+exp(-5/2)*2)/6]';

result=[2 (-1+2*2^(-1/2))/(1+2^(-1/2)) (3-1*2^(-1/2)+2*2^(-2/2))/(1+2^(-1/2)+2^(-2/2)); ...
        5 (10+5*2^(-1/2))/(1+2^(-1/2)) (-15+10*2^(-1/2)+5*2^(-2/2))/(1+2^(-1/2)+2^(-2/2))]';


assert(all(approxeq(mvavg, result, 1e-6)));

x=[ 2 -1 NaN; ...
    5 NaN -15]';

mvavg=smartExpMovingAvg(x, 2);


result=[2 (-1+2*2^(-1/2))/(1+2^(-1/2)) NaN; ...
        5 NaN (-15 +5*2^(-2/2))/(1+2^(-2/2))]';

assert(all(approxeq(mvavg, result, 1e-6)));

x=[ 2 1; ...
    -1 0; ...
    3 -1; ...
    2 3];

mvavg=smartExpMovingAvg(x, 2, 3);

result=[2 1;
    (-1 + 2*2^(-1/2))/(1+2^(-1/2)) (0+1*2^(-1/2))/(1+2^(-1/2));
    (3-1*2^(-1/2)+2*2^(-1))/(1+2^(-1/2)+2^(-1)) (-1+0+1*2^(-1))/(1+2^(-1/2)+2^(-1));
    (2+3*2^(-1/2)-1*2^(-1))/(1+2^(-1/2)+2^(-1)) (3-1*2^(-1/2)+0)/(1+2^(-1/2)+2^(-1))];

assert(all(approxeq(mvavg, result, 1e-6)));

