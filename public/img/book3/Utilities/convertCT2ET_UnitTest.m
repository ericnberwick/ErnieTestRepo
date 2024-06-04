tdayCT=[20130111 20130111 20130112 20130113]';
hhmmCT=[0 2259 2300 2301]';

[tdayET hhmmET]=convertCT2ET( tdayCT, hhmmCT );

assert(tdayET(1)==20130111);
assert(tdayET(2)==20130111);
assert(tdayET(3)==20130113);
assert(tdayET(4)==20130114);

assert(hhmmET(1)==100);
assert(hhmmET(2)==2359);
assert(hhmmET(3)==0);
assert(hhmmET(4)==1);

