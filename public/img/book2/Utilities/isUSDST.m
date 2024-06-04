function [ isUSdst ] = isUSDST( tday )
%[ isUSdst ] = isUSDST( tday )
%   Start second Sunday in March, end first Sunday in November. Valid since
%   2007. Test only valid if tday starts before or after March of any year.

assert(all(yyyymmdd2yyyy(tday) >= 2007));
assert(yyyymmdd2month(tday(1)) ~= 3);

isUSdst=false(size(tday));

numPastSundayInMarch=0;
numPastSundayInNov=0;
for t=1:length(tday)
    
    myweekday=weekday(yyyymmdd2datenum(tday(t)));
    mymonth=yyyymmdd2month(tday(t));

    
    if (mymonth > 3 && mymonth < 11)
        isUSdst(t)=true;
        numPastSundayInMarch=0;
        numPastSundayInNov=0;
    elseif (mymonth==3 && myweekday==1 && numPastSundayInMarch < 1)
        numPastSundayInMarch=numPastSundayInMarch + 1;
    elseif (mymonth==3 && myweekday==1 && numPastSundayInMarch >= 1) % Today is second Sunday in March
        isUSdst(t)=true;
        numPastSundayInMarch=numPastSundayInMarch + 1;
    elseif (mymonth==3 && myweekday~=1 && numPastSundayInMarch >= 2)
        isUSdst(t)=true;
    elseif (mymonth==11 && myweekday==1 && numPastSundayInNov < 1)
        numPastSundayInNov=numPastSundayInNov+1;
    elseif (mymonth==11 && myweekday~=1 && numPastSundayInNov < 1)
        isUSdst(t)=true;
    end
end
