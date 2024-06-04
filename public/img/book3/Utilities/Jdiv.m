function Jdiv=Jdiv(p, q)
% Jdiv=Jdiv(p, q) calculates J-divergence distance between data vectors p
% and q.

meanP=mean(p);
meanQ=mean(q);

sigmaP=std(p);
sigmaQ=std(q);

Jdiv=0.5*((meanP-meanQ)^2*(1/sigmaP+1/sigmaQ) + sigmaQ/sigmaP + sigmaP/sigmaQ - 2);
