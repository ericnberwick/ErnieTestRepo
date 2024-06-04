function [pair]=getOffDiagPair(n)
% pair=getOffDiagPair(n) generates pairs (i, j) where i<j<=n

pair=NaN*zeros(n*(n-1)/2, 2);

k=1;
for i=1:n
    for j=i+1:n
        pair(k, :)=[i j];
        k=k+1;
    end
end