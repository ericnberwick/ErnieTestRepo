clear;

op=[10; 11; 12];
hi=[11; 12; 13];
lo=[9; 10; 11];
cl=[10; 12; 11];

atr=movingAtr(2, op, hi, lo, cl);
my_atr=[NaN; NaN; 2];

assert(all(my_atr(end, :)==atr(end, :)));