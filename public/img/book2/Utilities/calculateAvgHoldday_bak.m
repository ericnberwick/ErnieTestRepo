function avgNumHoldDays=calculateAvgHoldday(positionTable)

holdday=zeros(size(positionTable, 1)^2, 1);

i=0;
for m=1:size(positionTable, 2)
    %     if (mod(m, 100)==1)
    %         fprintf(1, 'calculateAvgHoldday: stock %i\n', m);
    %     end
    
    i=i+1;
    if (positionTable(1, m)~=0)
        holdday(i)=1;
    end
    
    for t=2:size(positionTable, 1)
        if (positionTable(t, m).*positionTable(t-1, m)>0)
            holdday(i)=holdday(i)+1;
        elseif (positionTable(t, m)~=0)
            i=i+1;
            holdday(i)=1;
        elseif (holdday(i)~=0)
            i=i+1;
        end
    end
    
end

holdday(holdday==0)=[];
avgNumHoldDays=mean(holdday);
