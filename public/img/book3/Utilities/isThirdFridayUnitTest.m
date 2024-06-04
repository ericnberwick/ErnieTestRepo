clear;

daten1=datenum('17-Sep-2004');
assert(isThirdFriday(daten1));

daten2=datenum('3-Sep-2004');
assert(~isThirdFriday(daten2));

daten3=datenum('10-Sep-2004');
assert(~isThirdFriday(daten3));

daten4=datenum('24-Sep-2004');
assert(~isThirdFriday(daten4));

daten5=datenum('16-Sep-2004');
assert(~isThirdFriday(daten5));

assert(all([true; false; false; false; false]==isThirdFriday([daten1; daten2; daten3; daten4; daten5])));

mydate=20000121;
assert(isThirdFriday(tday2datenum(mydate)));

mydate=20061215;
assert(isThirdFriday(tday2datenum(mydate)));
