function isLastTradingDayOfMonth=isLastTradingDayOfMonth(yyyymmdd, tday)
% isLastTradingDayOfMonth=isLastTradingDayOfMonth(yyyymmdd, tday)
% Test if yyyymmdd is last trading day of month. Works only for 1 yyyymmdd.


% isLastTradingDayOfMonth=isNearMonthend(yyyymmdd, tday, 1);

isLastTradingDayOfMonth=false(length(yyyymmdd), 1);
for t=1:length(yyyymmdd)
    
    idx=find(tday==yyyymmdd(t));
    if (idx < length(tday))
        monthToday=month(datestr(datenum(num2str(yyyymmdd(t)), 'yyyymmdd')));
        monthTmr=month(datestr(datenum(num2str(tday(idx+1)), 'yyyymmdd')));
    
        isLastTradingDayOfMonth(t)=monthTmr > monthToday;
    end
end