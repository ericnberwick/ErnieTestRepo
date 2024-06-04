function [mvavg] = smartMovingMedian(x, T)
%  [mvavg] = smartMovingMedian(x, T). create moving median series over T days. mvavg
% has T-1 NaN in beginning.

assert(T>0);

mvavg = NaN(size(x,1)-T+1, size(x, 2));

for t=T:size(x, 1)
    mvavg(t, :)=smartmedian(x(t-T+1:t, :), 1);
end



