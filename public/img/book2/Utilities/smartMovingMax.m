function [mvmax] = smartMovingMax(x, T)
% [mvmax]=movingMax(x, T). create moving maximum series over T days. mvavg
% has T-1 NaN in beginning. Ignore over days with NaN.

mvmax = smartMovingMin(-x, T);

mvmax = -mvmax;