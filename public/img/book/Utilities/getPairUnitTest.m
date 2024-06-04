pairs=getPair(1, 1);
assert(pairs==[1 1]);

pairs=getPair(1, 2);
assert(pairs(1, :)==[1 1] & pairs(2, :)==[1 2]);

pairs=getPair(2, 1);
assert(pairs(1, :)==[1 1] & pairs(2, :)==[2 1]);

pairs=getPair(2, 2);
assert(pairs(1, :)==[1 1] & pairs(2, :)==[1 2] & pairs(3, :)==[2 1] & pairs(4, :)==[2 2]);

