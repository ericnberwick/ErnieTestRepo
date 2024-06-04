clear;

a=[ 20000101; 20010101; 20020102];
tday=[20010102; 20010103; 20010130; 20010201; 20020101; 20020102; 20020129; 20020130; 20020131; 20020201];

isLastTradingDayOfMonth(a, tday);

output=convert2eom(a, tday);

assert(output(2)==20010130);
assert(output(3)==20020131);
assert(isnan(output(1)));
