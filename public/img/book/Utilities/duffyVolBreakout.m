function vol = duffyVolBreakout( hi, lo, cl )
%vol = duffyVolBreakout( hi, lo, cl )
%  (Min ((Highest (High , 3) Of Daily - Lowest (Close , 3) Of Daily) , (Highest (Close , 3) Of Daily - Lowest (Low , 3) Of Daily))) * .5

vol=min(smartMovingMax(hi, 3)-smartMovingMin(cl, 3), smartMovingMax(cl, 3)-smartMovingMin(lo, 3))*0.5;


end

