clear;

X=[1 -3 4 10;
   4  2 -2 1;
   2  2  0 -4];

% mymvmax=[NaN NaN NaN NaN;
%          4  2  4 10;
%          4   2  0 1];
     
mymvmax=[1 -3 4 10;
         4  2  4 10;
         4   2  0 1];
     
mvmax=smartMovingMax(X, 2);

assert(all(all((mymvmax==mvmax))));
