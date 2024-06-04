x=rand(100, 2);

assert(approxeq(cov(x, 1), smartcov(x), 1e-9));

x(1, 1)=NaN;


sc=smartcov(x);

assert(approxeq(sc(2, 2), cov(x(:, 2), 1), 1e-9));
assert(approxeq(sc(1, 1), cov(x(2:end, 1), 1), 1e-9));
assert(sc(1, 2)==sc(2, 1));

c=cov(x(2:end, :), 1);
assert(approxeq(sc(1, 2), c(1, 2), 1e-9));