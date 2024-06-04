x=[ 1 -3; 3 10; -30 1; 2 -10];

c1=wcov(x, 4);

c2=smartwcov(x);

assert(c1==c2);