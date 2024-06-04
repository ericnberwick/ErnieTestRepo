function sdate=yyyymmdd2datenum(dt)

ytmp = floor(dt(:,1)/10000);
mtmp = floor((dt(:,1) - ytmp*10000)/100);
dtmp = dt(:,1) - ytmp*10000 - mtmp*100;
dt(:,1) = datenum(ytmp,mtmp,dtmp);
sdate = dt;