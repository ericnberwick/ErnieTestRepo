clear;

x=rand(2, 3, 4);

y=fwdshift(1, x);

assert(all(all(all(x(2, :, :)==y(1, :, :)))));

x=rand(4, 6);

y=fwdshift(2, x);

assert(all(all(x(3:4, :)==y(1:2, :))));
