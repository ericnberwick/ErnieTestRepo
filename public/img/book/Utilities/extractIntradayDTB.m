clear;

startdate=1997010200;
enddate=2003063099;

[ch, stocks, sectors]=mytextread('D:/Browse2ML/spdrs20030529.txt', {'STOCK'; 'SECTOR'});

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
    
    %     opn(:, s)=price(t10);
    %     cls(:, s)=price(t15);
    %     
    %     high(:, s)=max([price(t10) price(t11) price(t12) price(t13) price(t14) price(t15)], [], 2);
    %     low(:, s)=min([price(t10) price(t11) price(t12) price(t13) price(t14) price(t15)], [], 2);
    % 
    %     vol(:, s)=smartsum([volume(t10) volume(t11) volume(t12) volume(t13) volume(t14) volume(t15)], 2);
    
    p10(:, s)=price(t10);
    p11(:, s)=price(t11);
    p12(:, s)=price(t12);
    p13(:, s)=price(t13);
    p14(:, s)=price(t14);
    p15(:, s)=price(t15);

    v10(:, s)=volume(t10);
    v11(:, s)=volume(t11);
    v12(:, s)=volume(t12);
    v13(:, s)=volume(t13);
    v14(:, s)=volume(t14);
    v15(:, s)=volume(t15);

    assert(any(isfinite(v10(:, s))));
    assert(any(isfinite(v11(:, s))));
    assert(any(isfinite(v12(:, s))));
    assert(any(isfinite(v13(:, s))));
    assert(any(isfinite(v14(:, s))));
    assert(any(isfinite(v15(:, s))));
    
    assert(any(v10(:, s)~=0));
    assert(any(v11(:, s)~=0));
    assert(any(v12(:, s)~=0));
    assert(any(v13(:, s)~=0));
    assert(any(v14(:, s)~=0));
    assert(any(v15(:, s)~=0));
end

save D:/Browse2ML/spx_intraday stocks tday p10 p11 p12 p13 p14 p15 v10 v11 v12 v13 v14 v15;