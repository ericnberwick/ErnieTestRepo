n=10000;
np=n/10;
y=rand(n,1);

tic;
smartMovingPercentile(y, 1000, 10);
toc;

% tic;
% x=sort(y);
% x(np)
% toc;
