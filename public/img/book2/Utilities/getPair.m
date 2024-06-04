function pair=getPair(n, m)
% pair=getPair(n, m) generates pairs (i, j) where i<=n, j<=m
pair=NaN*zeros(n*m, 2);
k=1;
for i=1:n
    for j=1:m
        pair(k, :)=[i j];
        k=k+1;
    end
end