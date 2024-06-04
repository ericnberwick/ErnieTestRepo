function cday=prevTradingDay(cday, tday)
% mytday=prevTradingDay(cday, tday) gives previous trading day before
% calendar day cday. Both in/output are integers YYYYMMDD.

while isempty(find(cday==tday))
	cday=str2num(datestr(datenum(num2str(cday), 'yyyymmdd')-1, 'yyyymmdd'));
end
