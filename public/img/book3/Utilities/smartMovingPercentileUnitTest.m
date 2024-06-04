clear;

X=[1 4 4 2 3]';

x1=prctile(X(1:4), 10);
x2=prctile(X(2:5), 10);

mp=smartMovingPercentile(X, 4, 10)

assert(approxeq([x1; x2], mp(4:5)));

Y=[X X];

mp2=smartMovingPercentile(Y, 4, 10);

assert(all(mp(4:end)==mp2(4:end,1)) && all(mp(4:end)==mp2(4:end,2)));

Z=[NaN 4 4 2 3]';

mp3=smartMovingPercentile(Z, 4, 10);
assert(mp3(end)==mp(end));

mp4=smartMovingPercentile(X, 4, 25);
assert(mp4(4)==2 && mp4(5)==2);

mp5=smartMovingPercentile(X, 4, 75);
assert(mp5(4)==4 && mp5(5)==4);
