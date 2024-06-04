function [mvavg] = movingMedian(x, T)
%  [mvavg] = movingMedian(x, T). create moving median series over T days. mvavg
% has T-1 NaN in beginning.

assert(T>0);

mvavg = zeros(size(x,1)-T+1, size(x, 2));

for t=T:size(x, 1)
    mvavg(t, :)=median(x(t-T+1:t, :), 1);
end



