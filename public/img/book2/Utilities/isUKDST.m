function [ isUKdst ] = isUKDST( tday )
%[ isUKdst ] = isUKDST( tday )
%   Start last Sunday in March, end last Sunday in October. Valid since
%   2007. Test only valid if tday ends before or after Oct of any year.

assert(all(yyyymmdd2yyyy(tday) >= 2007));
assert(yyyymmdd2month(tday(end)) ~= 10);

isUKdst=false(size(tday));

numFutureSundayInMarch=0;
numFutureSundayInOct=0;
for t=length(tday):-1:1
    
%     if (tday(t)==20110327)
%         keyboard;
%     end
    
    myweekday=weekday(yyyymmdd2datenum(tday(t)));
    mymonth=yyyymmdd2month(tday(t));

    if (mymonth > 3 && mymonth < 10)
        isUKdst(t)=true;
        numFutureSundayInMarch=0;
        numFutureSundayInOct=0;
    elseif (mymonth==3 && myweekday==1 && numFutureSundayInMarch < 1)  % Today is last Sunday in March
        numFutureSundayInMarch=numFutureSundayInMarch + 1;
        isUKdst(t)=true;
    elseif (mymonth==3 && myweekday==1 && numFutureSundayInMarch >= 1) 
        numFutureSundayInMarch=numFutureSundayInMarch + 1;
    elseif (mymonth==3 && myweekday~=1 && numFutureSundayInMarch < 1)
        isUKdst(t)=true;
    elseif (mymonth==10 && myweekday==1 && numFutureSundayInOct < 1)
        numFutureSundayInOct=numFutureSundayInOct+1;
    elseif (mymonth==10 && myweekday~=1 && numFutureSundayInOct >= 1)
        isUKdst(t)=true;
    end
end
