clear;

daten1=datenum('16-Sep-2004');
assert(isDayBeforeThirdFriday(daten1));

daten2=datenum('1-Sep-2004');
assert(~isDayBeforeThirdFriday(daten2));

daten3=datenum('9-Sep-2004');
assert(~isDayBeforeThirdFriday(daten3));

daten4=datenum('23-Sep-2004');
assert(~isDayBeforeThirdFriday(daten4));

daten5=datenum('15-Sep-2004');
assert(~isDayBeforeThirdFriday(daten5));

assert(all([true; false; false; false; false]==isDayBeforeThirdFriday([daten1; daten2; daten3; daten4; daten5])));

mydate=20000120;
assert(isDayBeforeThirdFriday(tday2datenum(mydate)));