clear;

longs= [0 1 0 0 0 0 1 0 0 0 ]';
shorts=[1 0 1 0 1 0 0 0 0 0 ]';

pos=holdNdaysUnlessOppositeSignal(longs, shorts, 3);

assert(all(pos==[-1 1 -1 -1 -1 -1 1 1 1 0]'));