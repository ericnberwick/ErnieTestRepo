clear;

exDate=20110114;
stocks={'A', 'WST', 'ZEP'};

divs=parseDividendCalendarExcel(exDate, stocks);

assert(divs(1)==0);
assert(divs(2)==0.17);
assert(divs(3)==0.04);