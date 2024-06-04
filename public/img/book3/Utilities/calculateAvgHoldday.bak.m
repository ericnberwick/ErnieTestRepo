function avgNumHoldDays=calculateAvgHoldday(positionTable)

holdday=[];
for m=1:size(positionTable, 2)
    if (mod(m, 100)==1)
        fprintf(1, 'calculateAvgHoldday: stock %i\n', m);
    end
    
    holdday(end+1)=0;
    if (positionTable(1, m)~=0)
        holdday(end)=1;
    end
    
    for t=2:size(positionTable, 1)
        if (positionTable(t, m).*positionTable(t-1, m)>0)
            holdday(end)=holdday(end)+1;
        elseif (positionTable(t, m)~=0)
            holdday(end+1)=1;
        elseif (holdday(end)~=0)
            holdday(end+1)=0;
        end
    end
    
end

holdday=holdday(holdday~=0);
avgNumHoldDays=mean(holdday);
