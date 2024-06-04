clear;
randn('seed', 1);

R=randn(3, 6)-0.5;
X=sign(R);

Y=balanceSignalsSoft(X, R, 0);
assert(all(sum(Y, 2)==0));

Y=balanceSignalsSoft(X, R, 0.2);
% assert(all(abs(sum(Y, 2)./sum(abs(Y), 2))<=0.2));
