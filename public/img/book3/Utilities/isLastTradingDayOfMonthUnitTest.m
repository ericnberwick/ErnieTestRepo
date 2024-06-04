clear;


tday=[20060125; 20060126; 20060127; 20060130; 20060131; 20060201];

assert(true==isLastTradingDayOfMonth(20060131, tday));
assert(false==isLastTradingDayOfMonth(20060130, tday));

testdates=[20060131; 20060130; 20060201; 20060202; 20060125];

output=isLastTradingDayOfMonth(testdates, tday);

assert(all(output==[true; false; false; false; false]));

assert(all(isLastTradingDayOfMonth(tday, tday)==[false; false; false; false; true; false]));



tday=[20110829; 20110830; 20110831; 20110901; 20110902];

assert(isLastTradingDayOfMonth(20110831, tday));