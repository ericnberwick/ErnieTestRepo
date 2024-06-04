function isNearMonthend=isNearMonthend(yyyymmdd, tday, N)
% isNearMonthend=isNearMonthend(yyyymmdd, tday, N) true if N or fewer business days
% before next month

isNearMonthend=false(length(yyyymmdd), 1);

ind=findperm(tday, yyyymmdd);
yyyymmdd(ind==0)=[];
ind(ind==0)=[];

yyyymmdd(ind+N > length(tday))=[];
ind(ind+N > length(tday))=[];


% assert(yyyymmdd > 0);
isNearMonthend(yyyymmdd2month(yyyymmdd)~=yyyymmdd2month(tday(ind+N)))=true;

