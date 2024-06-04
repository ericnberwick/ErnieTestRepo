clear;
rng(1);
x=randi(100, 10, 3);

md0=smartMovingMad(x, 4);

x(3, 1)=NaN;
x(4:6, 2)=NaN;

md=smartMovingMad(x, 4);

assert(all(all(isnan(md(1:3, :)))));

assert(md(4, 1)==smartmad(x(1:4, 1)));
assert(md(5, 1)==smartmad(x(2:5, 1)));
assert(md(6, 1)==smartmad(x(3:6, 1)));
assert(md(7, 1)==smartmad(x(4:7, 1)));
assert(md(8, 1)==smartmad(x(5:8, 1)));
assert(md(9, 1)==smartmad(x(6:9, 1)));
assert(md(10, 1)==smartmad(x(7:10, 1)));

assert(md(4, 2)==smartmad(x(1:4, 2)));
assert(md(5, 2)==smartmad(x(2:5, 2)));
assert(md(6, 2)==smartmad(x(3:6, 2)));
assert(md(7, 2)==smartmad(x(4:7, 2)));
assert(md(8, 2)==smartmad(x(5:8, 2)));
assert(md(9, 2)==smartmad(x(6:9, 2)));
assert(md(10, 2)==smartmad(x(7:10, 2)));