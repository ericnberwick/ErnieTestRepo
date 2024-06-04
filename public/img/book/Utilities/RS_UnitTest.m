clear;

cls=[10; 11; 13; 12; 15];

myRS3=[NaN; NaN; Inf; (1+2+0)/(0+0+1); (2+0+3)/(0+1+0)];

RS=RS(cls, 3);

assert(all(myRS3(4:end)==RS(4:end)));