clear;

load('//dellquad/ETF_data/inputDataOHLCDaily_20111227', 'stocks', 'tday', 'lo', 'cl');

idx1=strmatch('SPY', stocks, 'exact');

cl=cl(:, [idx1 ]);
lo=lo(:, [idx1 ]);

wvf=WVF(lo, cl, 22);

vix=load('C:/Projects/FX_data/inputData_VIX', 'tday', 'cl');

[foo idx1 idx2]=intersect(tday, vix.tday);
tday=foo;
wvf=wvf(idx1);
vix=vix.cl(idx2);

plot([vix wvf]);
legend('VIX', 'WVF');
