function mycls=unpackCls(cls)
% mycls=unpackCls(cls)
% unpack size(cls)=[numDays, numStocks, numHours] to
% size(mycls)=[numDays*numHours, numStocks]

mycls=NaN(size(cls, 1)*size(cls, 3), size(cls, 2));

for d=1:size(cls, 1)
    mycls(1+(d-1)*size(cls, 3):d*size(cls, 3), :)=squeeze(cls(d, :, :))';
end