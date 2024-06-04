clear;

load('C:/Projects/FX_data/inputData_EURUSD', 'tday');

tday=unique(tday);

isusdst=isUSDST(tday);

i20110311=find(tday==20110311);
assert(~any(isusdst(i20110311)));
i20110313=find(tday==20110313);
assert(all(isusdst(i20110313)));
i20101107=find(tday==20101107);
assert(~any(isusdst(i20101107)));
i20101108=find(tday==20101108);
assert(~any(isusdst(i20101108)));
i20101105=find(tday==20101105);
assert(all(isusdst(i20101105)));
i20100315=find(tday==20100315);
assert(all(isusdst(i20100315)));
i20100314=find(tday==20100314);
assert(all(isusdst(i20100314)));
i20100312=find(tday==20100312);
assert(~any(isusdst(i20100312)));