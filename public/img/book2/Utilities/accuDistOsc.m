function [ ado ] = accuDistOsc( op, hi, lo, cl )
% [ ado ] = accuDistOsc( op, hi, lo, cl )
%   CLV=((cl-lo)-(hi-cl))./(hi-lo);
%   ado = smartcumsum(CLV);

CLV=((cl-lo)-(hi-cl))./(hi-lo);
ado = smartcumsum(CLV);
