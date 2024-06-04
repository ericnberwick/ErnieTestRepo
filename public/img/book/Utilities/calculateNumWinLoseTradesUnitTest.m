clear;

positions=[0 1   1   0   -1  1]';

cumret=   [0 0.1 0.2 0.3 0.3 0.2]';


[numWin numLose]=calculateNumWinLoseTrades(positions, cumret);

assert(numWin==1);
assert(numLose==1);

