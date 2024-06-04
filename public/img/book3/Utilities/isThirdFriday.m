function result=isThirdFriday(daten)
% result=isThirdFriday(daten) returns true if daten (in serial date number)
% is third Friday of month.

[y,m,d]=datevec(daten);
[y2,m2,d2]=datevec(daten-14);
[y3,m3,d3]=datevec(daten-21);

result=(weekday(daten)==6 & m==m2 & m3 ~= m);
