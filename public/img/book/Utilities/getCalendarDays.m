function cday=getCalendarDays(tday)

startdate=tday(1);
enddate=tday(end);

sd=num2str(startdate);
sdnum=datenum(str2num(sd(1:4)), str2num(sd(5:6)), str2num(sd(7:8)));

ed=num2str(enddate);
ednum=datenum(str2num(ed(1:4)), str2num(ed(5:6)), str2num(ed(7:8)));

cday=datestr(sdnum:ednum, 29);

cday=str2num(char(regexprep(cday, '-', '')));