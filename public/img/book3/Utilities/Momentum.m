function [ mom ] = Momentum( cl, nBar )
% [ mom ] = Momentum( cl, nBar )
%   Momentum is the difference between two prices (data points) separated
%   by a number of bars.

mom=cl-backshift(nBar, cl);

