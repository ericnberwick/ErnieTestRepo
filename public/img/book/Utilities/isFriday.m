function result=isFriday(daten)
% result=isFriday(daten) returns true if daten (in serial date number)
% is Friday.

[y,m,d]=datevec(daten);

result=(weekday(daten)==6);
