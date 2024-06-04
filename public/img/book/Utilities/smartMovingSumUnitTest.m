x=[ 1 2 -3;
    3 4  NaN;
    NaN 6  20;
    5 8  -10];

mvavg=smartMovingSum(x, 2);

result=[NaN NaN NaN;
    4 6 -3;
    3 10 20;
    5 14 10];
  