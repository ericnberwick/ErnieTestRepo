function [mvmin] = smartMovingMin(x, T)
% [mvmin]=movingMin(x, T). create moving minimum series over T days. mvavg
% has T-1 NaN in beginning. Ignore over days with NaN.

assert(T>0);

mvmin = NaN*zeros(size(x));

% for t=T:size(x, 1)
%     mvmin(t, :) = min(x(t-T+1:t, :), [], 1);
% end

for t=1:size(x, 1)
    mvmin(t, :) = min(x(max(t-T+1, 1):t, :), [], 1);
end

