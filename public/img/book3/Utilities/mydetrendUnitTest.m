clear;

dy=randn(10, 1);
y=cumsum(dy);

[res, b]=mydetrend(y);

assert(approxeq(y , [ (0:size(y, 1)-1)' ones(size(y, 1), 1)]* b + res));

ytrain=(1:100)';
ytest=(101:120)';

[res, b]=mydetrend(ytrain);

assert(approxeq(ytest-[(100:119)' ones(20, 1)]*b, 0));

