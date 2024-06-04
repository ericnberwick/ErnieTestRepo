function [uniquetday clsHour]=packHF2Cls(tday, hhmm, cls)
% pack cls* to clsHour. Allow only 1 symbol.

assert(length(tday)==length(hhmm));
assert(length(tday)==size(cls, 1));

uniquetday=unique(tday);
uniquehhmm=unique(hhmm);
numPeriodPerDay=length(uniquehhmm);
clsHour=NaN(length(uniquetday), 1, numPeriodPerDay);

for h=1:numPeriodPerDay
    idx1=find(hhmm==uniquehhmm(h));
    [foo, idx2, idx3]=intersect(uniquetday, tday(idx1));
    clsHour(idx2, 1, h)=cls(idx1);
end

