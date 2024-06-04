function result=isDayBeforeThirdFriday(daten)
% result=isDayBeforeThirdFriday(daten) returns true if daten (in serial date number)
% is day before third Friday of month.

[y,m,d]=datevec(daten+1);
[y2,m2,d2]=datevec(daten-13);
[y3,m3,d3]=datevec(daten-20);

result=(weekday(daten)==5 & m==m2 & m3 ~= m);
