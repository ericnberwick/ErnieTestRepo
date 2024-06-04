clear;
x=zeros(10, 2);
x(:, 1)=(1:10)';
x(:, 2)=-0.5*(1:10)'+rand(10, 1);
y=0.5*(10:10:100)'+5*rand(10, 1);

c=ones(10, 1);

res=my_ols(y, [c x]);
res.beta(1);
res.beta(2:end);

assert(approxeq(y, [c x]*res.beta, 4));

% plot(y, '.g');
% hold on;
% plot(res.yhat, '*r');
% hold off;
% test identity weights

w=ones(10, 1);
res1=my_ols(y, [c x], w);
assert(approxeq(res1.beta, res.beta));

% test weights
x=[1:10 5 5 5 5 5 5 5 5 5 5]';
y=[rand(10, 1)' 4 4 4 4 4 4 4 4 4 4]';
c=ones(20, 1);

res1=my_ols(y, [c x]);

x=x(1:11);
y=y(1:11);
w=[ones(10, 1)' 10]';

c=ones(11,1);

res2=my_ols(y, [c x], w);

assert(approxeq(res1.beta, res2.beta));

% test  weights
x=[1:10 5 5 5 5 5 5 5 5 5 5]';
y=[rand(10, 1)' 4 4 4 4 4 4 4 4 4 4]';
c=ones(20, 1);

res1=my_ols(y, [c x]);

x=x(1:11);
y=y(1:11);
w=[ones(10, 1)' 10]';

c=ones(11,1);

res2=my_ols(y, [c x], w);

assert(approxeq(res1.beta, res2.beta));

% test  weights with different values

x=[1:10 5 5 5 5 5 5 5 3 3 3]';
y=[rand(10, 1)' 4 4 4 4 4 4 4 -2 -2 -2]';
c=ones(20, 1);

res1=my_ols(y, [c x]);

x=x([1:11 20]);
y=y([1:11 20]);
w=[ones(10, 1)' 7 3]';

c=ones(12,1);

res2=my_ols(y, [c x], w);

assert(approxeq(res1.beta, res2.beta));

% check timing
x=randn(1000, 1);
y=randn(1000, 1);
c=ones(1000, 1);

t=cputime;
my_ols(y, [c x]);
cputime-t

w=ones(1000, 1);

t=cputime;
my_ols(y, [c x], w);
cputime-t