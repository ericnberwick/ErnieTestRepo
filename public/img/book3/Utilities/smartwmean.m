function wmean=smartwmean(x, T)
% wmean=smartwmean(x, tau): computes smart exponentially weighted mean with
% halflife T. I.e. x=[x1 x2 x3]', wmean=x3+x2*2^(-1/T)+x1*2^(-2/T)

assert(T>0);

goodDays=isfinite(x);
numGoodDays=sum(goodDays, 1);

weights=repmat(2.^(-[size(x, 1)-1:-1:0]'/T), [1 size(x, 2)]);
weights(~goodDays)=NaN;

wmean=smartsum(x.*weights, 1)./smartsum(weights, 1);
