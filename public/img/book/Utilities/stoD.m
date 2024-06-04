function D=stoD(hi, lo, cl, x, y, z)
% D=stoD(hi, lo, cl, x, y, z)
% z-day SMA of %K(x, y)

D=smartMovingAvg(stoK(hi, lo, cl, x, y), z);
