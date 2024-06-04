clear;

startdate=1997010200;
enddate=  2004080999;

stocks={'SPY'};

for s=1:length(stocks)
    fprintf(1, '%s %i\n', char(stocks(s)), s);
    [ch, tf, price, volume]=mytextread(['D:/Browse2ML/', char(stocks(s)), '.DTB'], {'TF'; 'LAST_R'; 'VOLUME_S'});
    
     
    outrange=find(tf < startdate | tf >enddate);
    tf(outrange)=[];
    price(outrange)=[];
    volume(outrange)=[];
    dates=int2str(tf);

    assert(tf(1)==startdate & tf(end)==enddate);
    
    if (s==1)
        tday=unique(str2num(dates(:, 1:8)));
        opn=repmat(NaN, [length(tday) length(stocks)]);
        high=repmat(NaN, size(opn));
        low=repmat(NaN, size(opn));
        cls=repmat(NaN, size(opn));
        vol=repmat(NaN, size(opn));
    end

    t10=strmatch('10', dates(:, 9:10), 'exact');
    t11=strmatch('11', dates(:, 9:10), 'exact');
    t12=strmatch('12', dates(:, 9:10), 'exact');
    t13=strmatch('13', dates(:, 9:10), 'exact');
    t14=strmatch('14', dates(:, 9:10), 'exact');
    t15=strmatch('15', dates(:, 9:10), 'exact');
    
    opn(:, s)=price(t10);
    cls(:, s)=price(t15);
    
    high(:, s)=max([price(t10) price(t11) price(t12) price(t13) price(t14) price(t15)], [], 2);
    low(:, s)=min([price(t10) price(t11) price(t12) price(t13) price(t14) price(t15)], [], 2);

    vol(:, s)=smartsum([volume(t10) volume(t11) volume(t12) volume(t13) volume(t14) volume(t15)], 2);
    

    assert(any(isfinite(opn(:, s))));
    assert(any(isfinite(high(:, s))));
    assert(any(isfinite(low(:, s))));
    assert(any(isfinite(cls(:, s))));
    assert(any(isfinite(vol(:, s))));
    assert(any(vol(:, s)~=0));
end

save D:/Browse2ML/spy_ohlcvol stocks tday opn high low cls vol;