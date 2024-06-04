clear;

tday=[20160712:20160714]';

dt=datetime(tday, 'ConvertFrom', 'yyyymmdd');
dt=[dt; datetime(2016, 7, 14, 13, 4, 2)];
    
[mytday, myhh, mymm, myDT, myLast]=tick2bar(dt, 1:length(dt), 15);


assert(all(mytday==yyyymmdd(myDT)));
assert(all(myhh==hour(myDT)));
assert(all(mymm==minute(myDT)));

idx=find(mytday==20160714 & myhh==13 & mymm==0);
assert(isnan(myLast(idx)));
idx=find(mytday==20160714 & myhh==13 & mymm==15);
assert(myLast(idx)==4);

[mytday, myhh, mymm, myDT, myLast, myLast2]=tick2bar(dt, 1:length(dt), 15,  length(dt):-1:1);

assert(all(mytday==yyyymmdd(myDT)));
assert(all(myhh==hour(myDT)));
assert(all(mymm==minute(myDT)));

idx=find(mytday==20160714 & myhh==13 & mymm==0);
assert(isnan(myLast(idx)));
assert(isnan(myLast2(idx)));

idx=find(mytday==20160714 & myhh==13 & mymm==15);
assert(myLast(idx)==4);
assert(myLast2(idx)==1);

dt=[datetime(2016, 7, 14, 13, 4, 2); datetime(2016, 8, 15, 13, 4, 2)];
[mytday, myhh, mymm, myDT, myLast]=tick2bar(dt, 1:2, 15);
assert(isfinite(myLast(1)));
assert(isfinite(myLast(end)));


assert(length(unique(dt))==length(dt));