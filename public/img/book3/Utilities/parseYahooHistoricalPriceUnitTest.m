clear;

[op, hi, lo, cl, vol, avgvol]=parseYahooHistoricalPrice('IBM', 20060725);

assert(op==75.99);
assert(hi==76.41);
assert(lo==75.31);
assert(cl==75.89);
assert(vol==5580300);
assert(round(avgvol)==6216535);
