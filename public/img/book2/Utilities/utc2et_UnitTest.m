clear;

utc=datetime(2009, 2, 6, 0, 1, 15.878, 'TimeZone', 'UTC');
% et=utc2et(utc);

datetimeInET=datetime(utc, 'TimeZone', 'America/New_York');

assert(strcmp('2009', datestr(datetimeInET, 'yyyy')));
assert(strcmp('02', datestr(datetimeInET, 'mm')));
assert(strcmp('05', datestr(datetimeInET, 'dd')));
assert(strcmp('19', datestr(datetimeInET, 'HH'))); % EST is 5 hours behind UTC
assert(strcmp('01', datestr(datetimeInET, 'MM')));
assert(strcmp('15', datestr(datetimeInET, 'SS')));
assert(strcmp('878', datestr(datetimeInET, 'FFF')));


utc=datetime(2009, 6, 6, 0, 1, 15.878, 'TimeZone', 'UTC');
% et=utc2et(utc);

datetimeInET=datetime(utc, 'TimeZone', 'America/New_York');

assert(strcmp('2009', datestr(datetimeInET, 'yyyy')));
assert(strcmp('06', datestr(datetimeInET, 'mm')));
assert(strcmp('05', datestr(datetimeInET, 'dd')));
assert(strcmp('20', datestr(datetimeInET, 'HH'))); % EDT is 4 hours behind UTC
assert(strcmp('01', datestr(datetimeInET, 'MM')));
assert(strcmp('15', datestr(datetimeInET, 'SS')));
assert(strcmp('878', datestr(datetimeInET, 'FFF')));

