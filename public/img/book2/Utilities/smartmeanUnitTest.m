X=[1 2 3 NaN; 1 2 3 4];

assert(all(smartmean(X)==[1 2 3 4]));

X(2, 4)=NaN;
Y=smartmean(X);

assert(isnan(Y(1, 4)));

Y=smartmean(X', 2);

assert(isnan(Y(4, 1)));

