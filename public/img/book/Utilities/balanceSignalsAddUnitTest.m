clear;
randn('state', 0);

R=randn(3, 6)-0.5;
X=sign(R);
X(abs(R)<1)=0;

Y=balanceSignalsAdd(X, R);
assert(all(sum(Y, 2)==0));