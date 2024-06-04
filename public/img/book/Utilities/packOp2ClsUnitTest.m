clear;

op=[1 1.1; 9 9.1];
cls10=[2 2.1; 10 10.1];
cls11=[3 3.1; 11 11.1];
cls12=[4 4.1; 12 12.1];
cls13=[5 5.1; 13 13.1];
cls14=[6 6.1; 14 14.1];
cls15=[7 7.1; 15 15.1];
cls16=[8 8.1; 16 16.1];

clsHour=packOp2Cls(2, op, cls10, cls11, cls12, cls13, cls14, cls15, cls16);
assert(clsHour(1, 1, :)==op(1, 1));
assert(clsHour(2, 1, :)==op(2, 1));
assert(clsHour(1, 1, end)==cls16(1, 1));
assert(clsHour(2, 1, end)==cls16(2, 1));
assert(clsHour(1, 2, :)==op(1, 2));
assert(clsHour(2, 2, :)==op(2, 2));
assert(clsHour(1, 2, end)==cls16(1, 2));
assert(clsHour(2, 2, end)==cls16(2, 2));