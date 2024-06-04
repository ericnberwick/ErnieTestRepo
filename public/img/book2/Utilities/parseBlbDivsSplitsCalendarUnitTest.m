clear;

prevDate=20100106;
exDate=20100107;
load(['\\dellquad\reversal_data\inputDataOHLCdaily_', num2str(prevDate)], 'stocks');
[divs splits]=parseBlbDivsSplitsCalendar(stocks, exDate, ['\\dellquad/reversal_data/DivsSplits', num2str(prevDate), '_FOO']);

% assert(all(divs==0));
% assert(all(splits==1));

assert(divs(206)==0.18  && divs(726)==0.05 && divs(850)==0.49 && divs(2129)==0.05);

assert(splits(4)==1.5  && splits(22)==2 );

[dividends_SPY splits_SPY]=parseBlbDivsSplitsCalendar({'SPY'}, exDate, ['\\dellquad/reversal_data/DivsSplits', num2str(prevDate), '_FOO']);

assert(dividends_SPY==0.2);