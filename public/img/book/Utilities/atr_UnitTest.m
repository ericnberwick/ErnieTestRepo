clear;

op=[10; 11; 12];
hi=[11; 12; 13];
lo=[9; 10; 11];
cl=[10; 12; 11];

atr=atr(2,  hi, lo, cl);
my_atr=[2];

assert(all(my_atr(end, :)==atr(end, :)));