function corr=smartMovingCorrcoef(x, y, T)
%  corr=smartMovingCorrcoef(x, y, T)
% calculate correlation coefficient between x and y for T data. Expect T-1
% NaN in the beginning of the series

assert(size(x, 1) >= size(x, 2), 'x must be column vector.');
assert(size(x, 1) == size(y, 1), 'y must be column vector of same length as x.');

corr=NaN*ones(size(x, 1), 1);

badset=find(~isfinite(x(1:T)) | ~isfinite(y(1:T)));

xtemp=x(1:T);
ytemp=y(1:T);

xtemp(badset)=[];
ytemp(badset)=[];

if (length(xtemp)>1)
    N=length(xtemp);
    sumX=sum(xtemp);
    sumY=sum(ytemp);
    sumXY=sum(xtemp.*ytemp);
    sumXX=sum(xtemp.*xtemp);
    sumYY=sum(ytemp.*ytemp);
    corr(T)=(sumXY-sumX*sumY/N)/sqrt((sumXX-sumX^2/N)*(sumYY-sumY^2/N));
else
    N=0;
    sumX=0;
    sumY=0;
    sumXY=0;
    sumXX=0;
    sumYY=0;
    corr(T)=NaN;
end

for t=T+1:length(corr)
    if (isfinite(x(t-T)) & isfinite(y(t-T)))
        sumXY=sumXY-x(t-T)*y(t-T);
        sumXX=sumXX-x(t-T)^2;
        sumYY=sumYY-y(t-T)^2;
        sumX=sumX-x(t-T);
        sumY=sumY-y(t-T);
        N=N-1;
    end
    
    if (isfinite(x(t)) & isfinite(y(t)))
        sumXY=sumXY+x(t)*y(t);
        sumXX=sumXX+x(t)^2;
        sumYY=sumYY+y(t)^2;
        sumX=sumX+x(t);
        sumY=sumY+y(t);
        N=N+1;
    end
    
    if (N>1 & sumXX~=sumX*sumX/N & sumYY~=sumY*sumY/N)
        corr(t)=(sumXY-sumX*sumY/N)/sqrt((sumXX-sumX^2/N)*(sumYY-sumY^2/N));
    else
        corr(t)=NaN;
    end

end