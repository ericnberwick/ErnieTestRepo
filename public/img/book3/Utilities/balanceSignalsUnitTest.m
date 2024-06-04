clear;

R=randn(3, 6)-0.5;
X=sign(R);

Y=balanceSignals(X, R);
assert(all(sum(Y, 2)==0));