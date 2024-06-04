function [ dt, cl, varargout ] = matchBars( dt1, cl1, dt2, cl2, varargin )
% [ dt, cl ] = matchBars( dt1, cl1, dt2, cl2 )
% [ dt, cl, bid, ask ] = matchBars( dt1, cl1, dt2, cl2, bid1, ask1, bid2, ask2 )
%  dt1 and dt2 are datetimes arrays, with overlap but not identical, cl1
%  and cl2 are price arrays. Output dt is the union of dt1 and dt2. Missing
%  prices are fill-forwarded.

dt=union(dt1, dt2);

[~, idx1, idxA1]=intersect(dt1, dt);
[~, idx2, idxA2]=intersect(dt2, dt);

cl=NaN(size(dt, 1), 2);
cl(idxA1, 1)=cl1(idx1);
cl(idxA2, 2)=cl2(idx2);

cl=fillMissingData(cl);

if (nargin == 8)
    bid1=varargin{1};
    ask1=varargin{2};
    bid2=varargin{3};
    ask2=varargin{4};
    
    bid=NaN(size(cl));
    bid(idxA1, 1)=bid1(idx1);
    bid(idxA2, 2)=bid2(idx2);
        
    varargout{1}=fillMissingData(bid);
    
    ask=NaN(size(cl));
    ask(idxA1, 1)=ask1(idx1);
    ask(idxA2, 2)=ask2(idx2);
    
    varargout{2}=fillMissingData(ask);
    
    
end


end

