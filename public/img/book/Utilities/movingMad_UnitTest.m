% function sd=movingMad(x, T, varargin)
% % calculate Mad of x over T days. Expect T-1
% % NaN in the beginning of the series
% % [mvstd]=movingMad(x, lookback, period) creates moving mad of lookback
% % periods. I.e. data is sampled every period.
% 
% 
% sd=NaN*ones(size(x));
% 
% if (nargin == 2)
%     for t=T:size(x, 1)
%         sd(t, :)=mad(x(t-T+1:t, :));
%     end
% else
%     period=varargin{1};
%     for t=T*period:size(x, 1)
%         sd(t, :)=mad(x(t-T*period+1:t, :));
%     end
% end 

clear;

x=[1 2 2 3 3 3 4]';
x_mad=[0.5 0.5 0 0]';
x_mmad=movingMad(x, 4);

assert(all(x_mad==x_mmad(4:end)));