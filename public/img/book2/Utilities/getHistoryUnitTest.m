clear;
stock='MSFT';
fromday='09/01/2001';
today='10/01/2001';
property='close';
source='matlab';

[days, cls]=getHistory(stock, fromday, today, property, source);