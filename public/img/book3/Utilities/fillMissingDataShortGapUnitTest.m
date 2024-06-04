clear;


load('D:/Projects/sectorModel_prod/inputData4');
cls=cls15;

stkGap=500;
stkGone=649;

my_cls=fillMissingDataShortGap(cls);

assert(all(isfinite(my_cls(:, stkGap))));

assert(all(isfinite(my_cls(343:948, stkGone))));
assert(all(~isfinite(my_cls(949:end, stkGone))));