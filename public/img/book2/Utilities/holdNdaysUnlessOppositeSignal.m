function [ pos ] = holdNdaysUnlessOppositeSignal( longSignal, shortSignal, N )
% [ pos ] = holdNdaysUnlessOppositeSignal( longSignal, shortSignal, N )
% longSignal and shortSignal can have values 0 (false) or 1 (true) only.
%  This function generates the position matrix based on long and short
%  signals. Each new entry will hold for N days, unless the opposite signal
%  is initiated. 

assert(all(all(size(longSignal)==size(shortSignal))));
assert(all(all(longSignal==0  | longSignal==1)));
assert(all(all(shortSignal==0 | shortSignal==1)));

longSignal=logical(longSignal);
shortSignal=logical(shortSignal);

pos=NaN(size(longSignal));
pos(longSignal)=1;
pos(shortSignal)=-1;

for d=1:N-1
    myLongSignal=backshift(d, longSignal);
    myLongSignal(isnan(myLongSignal))=false;
    pos(myLongSignal & isnan(pos) )=1;
    
    myShortSignal=backshift(d, shortSignal);
    myShortSignal(isnan(myShortSignal))=false;
    pos(myShortSignal & isnan(pos))=-1;
end

pos(isnan(pos))=0;

end

