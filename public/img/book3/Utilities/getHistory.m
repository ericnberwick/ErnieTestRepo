function [day, data]=getHistory(stock, fromday, today, property, source)

assert(today>=fromday);
fromdayNum=datenum(fromday);
todayNum=datenum(today);

switch source
    case 'matlab'
        load 'D:/data_james/ndx_ohlcvol';
        dayNum=datenum(tday);
        
        dayidx=find(dayNum>=fromdayNum & dayNum<=todayNum);
        day=datestr(dayNum(dayidx));
        
        stkidx=strmatch(stock, stocks, 'exact');
        
        switch property
            case 'open'
                data=opn(dayidx, stkidx);
            case 'high'
                data=high(dayidx, stkidx);
            case 'low'
                data=low(dayidx, stkidx);
            case 'close'
                data=cls(dayidx, stkidx);
            case 'volume'
                data=vol(dayidx, stkidx);
        end
        
end