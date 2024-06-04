function [positions]=convert2dailyPositionTable_aggr(tradeSides, numHoldingDays)

% Similar to convert2dailyPositionLS, output relative (tradeDates only)
% positions
% we take original trade file as
% input, and allow long and short trade to overlap, cancelling each other's
% position during the overlap


positions=zeros(size(tradeSides));
positionsL=zeros(size(tradeSides));
positionsS=zeros(size(tradeSides));
        
for i=1:length(tradeSides)
    if (tradeSides(i)>0)
        for j=i:min(i+numHoldingDays-1, length(tradeSides))
            positionsL(j)=1;
        end
    elseif (tradeSides(i)<0)
        for j=i:min(i+numHoldingDays-1, length(tradeSides))
            positionsS(j)=-1;
        end
    end
end
    
positions=positionsL+positionsS;

