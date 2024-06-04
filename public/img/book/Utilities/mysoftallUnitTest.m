clear;

a=[0 0 0 1 1; 1 1 0 0 1];

assert(all([1; 1]==mysoftall(a, 2, 4)));
assert(all([0; 1]==mysoftall(a, 2, 2)));

assert(all([1 1 0 1 1]==mysoftall(a, 1, 1)));
assert(all([0 0 0 0 1]==mysoftall(a, 1, 0)));

