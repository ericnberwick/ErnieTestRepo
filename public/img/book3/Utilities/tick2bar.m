function [ tday, hh, mm, barDT, lastPrice, lastPrice2 ] = tick2bar(dt, price, barSizeInMinutes, price2 )
% [ tday, hh, mm, barDT, lastPrice ] = tick2bar(dt, price, barSizeInMinutes )
%  Turn ticks with datetime stamps into bar prices

assert(rem(60, barSizeInMinutes)==0);
assert(length(dt)==length(price));

tday=unique(yyyymmdd(dt));
hh=[0:23];
hh=repmat(reshape(repmat(hh, [60/barSizeInMinutes 1]), [24*60/barSizeInMinutes 1]), [length(tday) 1]);

mm=[0:barSizeInMinutes:59]';
mm=repmat(mm, [24*length(tday) 1]);

tday=reshape(repmat(tday', [24*60/barSizeInMinutes 1]), [length(tday)*24*60/barSizeInMinutes 1]);

barTime=datetime(tday, 'ConvertFrom', 'yyyymmdd', 'TimeZone', dt.TimeZone);
yyyy=year(barTime);
MM=month(barTime);
dd=day(barTime);

barDT=datetime(yyyy, MM, dd, hh, mm, zeros(size(mm)), 'TimeZone', dt.TimeZone);

lastPrice=NaN(size(barDT));
lastPrice2=lastPrice;

for t=2:length(barDT)
    idx=find(dt <= barDT(t) & dt > barDT(t-1));
    if (~isempty(idx))
        lastPrice(t)=price(max(idx));
        if nargin == 4
            lastPrice2(t)=price2(max(idx));
        end
    end
end

idxBad=find(barDT <= dt(1)); % remove bars before start of tick data
tday(idxBad)=[];
hh(idxBad)=[];
mm(idxBad)=[];
barDT(idxBad)=[];
lastPrice(idxBad)=[];
lastPrice2(idxBad)=[];

idxBad=find( barDT >= dt(end));
if (~isempty(idxBad))
    idxBad(1)=[]; % we retain first bar after end of tick data
end

if (~isempty(idxBad))
    tday(idxBad)=[];
    hh(idxBad)=[];
    mm(idxBad)=[];
    barDT(idxBad)=[];
    lastPrice(idxBad)=[];
    lastPrice2(idxBad)=[];
end

end

