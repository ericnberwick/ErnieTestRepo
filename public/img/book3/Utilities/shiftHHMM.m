function startOfBarHHMM=shiftHHMM(endOfBarHHMM)
% startOfBarHHMM=shiftHHMM(endOfBarHHMM)
%   Shifts 1600 to 1559

startOfBarHHMM=endOfBarHHMM-1;
isOnHour=rem(endOfBarHHMM, 100)==0;
startOfBarHHMM(isOnHour)=startOfBarHHMM(isOnHour)-40;

end

