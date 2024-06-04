[stk, date, o, h, l, c, v] = textread(['C:\data_james\dia_qqq_spy_ohlcvol.dat'],'%s%s%f%f%f%f%f'); 

stocks=unique(stk);
