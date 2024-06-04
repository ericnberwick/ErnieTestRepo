clear;
load('//dellquad/ETF_data/inputDataOHLCDaily_ETF_20130701', 'tday');

assert(isNearMonthend(20130628, tday, 1)); % On last trading day of month, N==1.
assert(isNearMonthend(20130624, tday, 5));
