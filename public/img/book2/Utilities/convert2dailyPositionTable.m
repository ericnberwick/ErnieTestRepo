function [positions]=convert2dailyPositionTable(tradeDates, tradeSides, numHoldingDays)

% Similar to convert2dailyPositionLS, output relative (tradeDates only)
% positions
% we take original trade file as
% input, and allow long and short trade to overlap, cancelling each other's
% position during the overlap

assert(length(tradeDates)==length(tradeSides));

positions=zeros(length(tradeDates),1);
positionsL=zeros(length(tradeDates),1);
positionsS=zeros(length(tradeDates),1);
        
for i=1:length(tradeDates)
    if (tradeSides(i)>0)
        for j=i:min(i+numHoldingDays-1, length(tradeDates))
            positionsL(j)=1;
        end
    elseif (tradeSides(i)<0)
        for j=i:min(i+numHoldingDays-1, length(tradeDates))
            positionsS(j)=-1;
        end
    end
end
    
positions=positionsL+positionsS;

