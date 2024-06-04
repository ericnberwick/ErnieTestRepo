function [ numWkDays ] = numWeekdaysTill( startDate, endDate )
%[ numWkDays ] = numWeekdaysTill( startDate, endDate )
% Calculate the number of weekdays between startDate (integer: yyyymmdd) and endDate.
% For e.g. if startDate is 20120712 and endDate is 20120713, numWkDays=1.

startDateNum=datenum(num2str(startDate), 'yyyymmdd');
endDateNum=datenum(num2str(endDate), 'yyyymmdd');

assert(startDateNum <= endDateNum, 'startDate must be <= endDate');

if (startDateNum==endDateNum)
    numWkDays=0;
else
    wkdays=weekday(startDateNum+1:endDateNum);
    numWkDays=length(find(wkdays~=1 & wkdays~=7));
end

end

