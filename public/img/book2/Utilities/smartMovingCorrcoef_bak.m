function corr=smartMovingCorrcoef(x, y, T)
% calculate correlation coefficient between x and y for T data. Expect T-1
% NaN in the beginning of the series

corr=NaN*ones(size(x, 1), 1);

for t=T:length(corr)
    corr(t)=smartcorrcoef(x(t-T+1:t), y(t-T+1:t));
end