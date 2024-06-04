clear;

syms={'AFAM', 'AFN', 'ADAM', 'XRIT', 'SAM', 'SNHY', 'AVCA', 'WOC', 'HF'};

[earnann]=parseEarningsCalendarIntraday(20071105, 20071106, syms);

assert(all(earnann==[0 1 1 1 1 1 0 0 0]));