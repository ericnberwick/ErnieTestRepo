% convert text file of indices data to .mat files
clear;
infile='c:/data_james/dia_qqq_spy_ohlcvol.dat';
[stocks, tday, opn, high, low, cls, vol]=textread(infile, '%s%s%f%f%f%f%f');

diarange=strmatch('DIA', stocks, 'exact');
qqqrange=strmatch('QQQ', stocks, 'exact');
spyrange=strmatch('SPY', stocks, 'exact');

qqqtday=tday(qqqrange);
qqqopn=opn(qqqrange);
qqqcls=cls(qqqrange);
qqqhigh=high(qqqrange);
qqqlow=low(qqqrange);
qqqvol=vol(qqqrange);

save 'C:/data_james/qqq_ohlcvol' qqqtday qqqopn qqqhigh qqqlow qqqcls qqqvol;

diatday=tday(diarange);
diaopn=opn(diarange);
diacls=cls(diarange);
diahigh=high(diarange);
dialow=low(diarange);
diavol=vol(diarange);

save 'C:/data_james/dia_ohlcvol' diatday diaopn diahigh dialow diacls diavol;

spytday=tday(spyrange);
spyopn=opn(spyrange);
spycls=cls(spyrange);
spyhigh=high(spyrange);
spylow=low(spyrange);
spyvol=vol(spyrange);

save 'C:/data_james/spy_ohlcvol' spytday spyopn spyhigh spylow spycls spyvol;
