clear;

assert(929==convertHHMMClose2Open( 930 ));
assert(1900==convertHHMMClose2Open(1901));
assert(1859==convertHHMMClose2Open(1900));
assert(2359==convertHHMMClose2Open(0));
assert(0==convertHHMMClose2Open(1));
