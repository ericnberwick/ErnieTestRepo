function result=isBeforeHoliday(yyyymmdd, tday)
% result=isBeforeHoliday(yyyymmdd, tday) returns true if tday is before a
% weekend or holiday

i=find(yyyymmdd==tday);
j=find(yyyymmdd+1==tday);

result=isempty(j) & rem(str2double(datestr(datenum(num2str(yyyymmdd), 'yyyymmdd')+1, 'yyyymmdd')), 100)~=1;
