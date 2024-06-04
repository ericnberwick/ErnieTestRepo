function [corr_coef, p]=smartcorrcoef(x, y)

badset=find(~isfinite(x) | ~isfinite(y));

x(badset)=[];
y(badset)=[];


if (length(x)>1)
    %     corrcoef=mean((x-mean(x)).*(y-mean(y)))/std(x, 1)/std(y, 1);
    [C, P]=corrcoef(x, y);
    corr_coef=C(1, 2);
    p=P(1, 2);
else
    corr_coef=NaN;
    p=NaN;
end