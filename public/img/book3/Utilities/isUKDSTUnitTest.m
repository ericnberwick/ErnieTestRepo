clear;

load('C:/Projects/FX_data/inputData_EURUSD', 'tday');

tday=unique(tday);

isukdst=isUKDST(tday);

i20110325=find(tday==20110325);
assert(~any(isukdst(i20110325)));
i20110327=find(tday==20110327);
assert(any(isukdst(i20110327)));
i20101101=find(tday==20101101);
assert(~any(isukdst(i20101101)));
i20101031=find(tday==20101031);
assert(~any(isukdst(i20101031)));
i20101029=find(tday==20101029);
assert(all(isukdst(i20101029)));
i20100326=find(tday==20100326);
assert(~any(isukdst(i20100326)));
i20100328=find(tday==20100328);
assert(all(isukdst(i20100328)));
i20100329=find(tday==20100329);
assert(all(isukdst(i20100329)));