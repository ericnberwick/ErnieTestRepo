clear;

syms={'LEND', 'ABD', 'ATG', 'ALY', 'WSC', 'IBM', 'PMD', 'RGCO', 'CTAC', 'WTS', 'WMS', 'ADAM', 'WRS', 'BTI', 'TKS', 'TFSM', 'WXS', 'WYNN'};

[earnann]=parseEarningsCalendar(20060502, 20060503, syms);

assert(all(earnann==[0     1     1     0     0     0     0     0     1     1     1     1     1 0     0     0     0     0]));