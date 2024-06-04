clear;

endOfBarHHMM=[1558; 1559; 1600; 1601];
startOfBarHHMM=[1557; 1558; 1559; 1600];


assert(all(shiftHHMM(endOfBarHHMM)==startOfBarHHMM));
