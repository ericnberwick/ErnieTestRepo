function [ totCumRet ] = portfolioCumRet( w, x )
% [ totCumRet ] = portfolioCumRet( w, x )
%   Compute total compounded cumulative return of a portfolio with price
%   relatives x and capital weights w. x and w have dimensions TxS.
%   x(t, s)=Price(t, s)/Price(t-1, s) 

dailyret=smartsum(backshift(1, w).*x, 2)-1;
dailyret(~isfinite(dailyret))=0;
totCumRet=prod(1+dailyret)-1;

end

