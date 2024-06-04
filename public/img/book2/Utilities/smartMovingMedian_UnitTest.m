clear;
rng(1);
x=randi(100, 10, 3);

md0=smartMovingMedian(x, 4);

x(3, 1)=NaN;
x(4:6, 2)=NaN;

md=smartMovingMedian(x, 4);

assert(all(all(isnan(md(1:3, :)))));
% assert(all(md(4:end, 1)==[42 31 15 17 17 27 37.5]'));
% assert(all(md(4:end, 2)==[42 45 21 42 49 42 31]'));
% assert(all(md(4:end, 3)==md0(4:end, 3)));

assert(md(4, 1)==smartmedian(x(1:4, 1)));
assert(md(5, 1)==smartmedian(x(2:5, 1)));
assert(md(6, 1)==smartmedian(x(3:6, 1)));
assert(md(7, 1)==smartmedian(x(4:7, 1)));
assert(md(8, 1)==smartmedian(x(5:8, 1)));
assert(md(9, 1)==smartmedian(x(6:9, 1)));
assert(md(10, 1)==smartmedian(x(7:10, 1)));

assert(md(4, 2)==smartmedian(x(1:4, 2)));
assert(md(5, 2)==smartmedian(x(2:5, 2)));
assert(md(6, 2)==smartmedian(x(3:6, 2)));
assert(md(7, 2)==smartmedian(x(4:7, 2)));
assert(md(8, 2)==smartmedian(x(5:8, 2)));
assert(md(9, 2)==smartmedian(x(6:9, 2)));
assert(md(10, 2)==smartmedian(x(7:10, 2)));