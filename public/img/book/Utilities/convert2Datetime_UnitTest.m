clear;

yyyymmdd=[20010101 20010202 20020303 20030404]';
hhmm=[10 1201 1 101]';

dt=convert2Datetime(yyyymmdd, hhmm);

assert(all(year(dt)==[2001 2001 2002 2003]'));
assert(all(month(dt)==[1 2 3 4]'));
assert(all(day(dt)==[1 2 3 4]'));
assert(all(hour(dt)==[0 12 0 1]'));
assert(all(minute(dt)==[10 1 1 1]'));
assert(all(second(dt)==[0 0 0 0]'));

yyyymmdd=20100101;
hhmm=0;

dt=convert2Datetime(yyyymmdd, hhmm);
assert(year(dt)==2010);
assert(hour(dt)==0);
assert(minute(dt)==0);
assert(second(dt)==0);

hhmm=1;
dt=convert2Datetime(yyyymmdd, hhmm);
assert(hour(dt)==0);
assert(minute(dt)==1);
assert(second(dt)==0);

hhmm=10;
dt=convert2Datetime(yyyymmdd, hhmm);
assert(hour(dt)==0);
assert(minute(dt)==10);
assert(second(dt)==0);

hhmm=100;
dt=convert2Datetime(yyyymmdd, hhmm);
assert(hour(dt)==1);
assert(minute(dt)==0);
assert(second(dt)==0);

hhmm=1000;
dt=convert2Datetime(yyyymmdd, hhmm);
assert(hour(dt)==10);
assert(minute(dt)==0);
assert(second(dt)==0);

hhmm=101;
dt=convert2Datetime(yyyymmdd, hhmm);
assert(hour(dt)==1);
assert(minute(dt)==1);
assert(second(dt)==0);

hhmm=111;
dt=convert2Datetime(yyyymmdd, hhmm);
assert(hour(dt)==1);
assert(minute(dt)==11);
assert(second(dt)==0);
