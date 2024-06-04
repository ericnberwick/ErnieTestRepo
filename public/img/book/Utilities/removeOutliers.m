function rlagnorm = removeOutliers(rlag)

rlagn=rlag-repmat(smartmean(rlag, 2), [1 size(rlag, 2)]);

rlagabsmvavg=smartMovingAvg(abs(rlagn), 60);

rlagnorm=rlag;
rlagnorm(abs(rlagn./rlagabsmvavg)>3)=NaN;