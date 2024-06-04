function cday=nextTradingDay(cday, tday)
% mytday=nextTradingDay(cday, tday) gives next trading day following
% calendar day cday. Both in/output are integers YYYYMMDD.

while isempty(find(cday==tday))
	cday=str2num(datestr(datenum(num2str(cday), 'yyyymmdd')+1, 'yyyymmdd'));
end
