clear;

x=rand(2, 3, 4);

y=backshift(1, x);

assert(all(all(all(y(2, :, :)==x(1, :, :)))));

x=rand(4, 6);

y=backshift(2, x);

assert(all(all(y(3:4, :)==x(1:2, :))));
