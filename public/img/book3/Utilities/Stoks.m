function [ myStoks ] = Stoks(  op, hi, lo, maLookback, initAlpha, maxAlpha )
%[ myStoks ] = Stoks( op, hi, lo, initAlpha, maxAlpha )
%   Joe Duffy's Trend Definer

myStoks=(EMA(op, maLookback)+parabolic(hi, lo, initAlpha, maxAlpha))/2;


end

