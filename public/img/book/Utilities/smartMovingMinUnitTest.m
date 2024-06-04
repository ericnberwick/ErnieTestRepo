clear;

X=[1 -3 4 10;
   4  2 -2 1;
   2  2  0 -4];

mymvmin=[1  -3   4 10;
         1  -3  -2 1;
         2   2  -2 -4];
     
mvmin=smartMovingMin(X, 2);

assert(all(all(mymvmin==mvmin)));
