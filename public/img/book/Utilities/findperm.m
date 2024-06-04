function ind=findperm(A, B)
% ind=findperm(A, B) find permutation ind such that A(ind)=B. 

ind=zeros(size(B));

if (iscell(B))
    if (length(A)==length(B) && all(strcmp(A, B)))
        ind=1:length(A);
        return;
    end
    
    for s=1:length(B)
        tmp=strmatch(B(s), A, 'exact');
        if (~isempty(tmp))
            ind(s)=tmp(1);
        end
    end
else
    if (length(A)==length(B) && all(A==B))
        ind=1:length(A);
        return;
    end

    for s=1:length(B)
        tmp=find(B(s)==A);
        if (~isempty(tmp))
            ind(s)=tmp(1);
        end
    end
end
