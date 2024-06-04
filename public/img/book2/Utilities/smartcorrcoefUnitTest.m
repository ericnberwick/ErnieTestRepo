x=rand(10,1);
y=rand(10,1);

tmp=corrcoef(x, y);
corr1=tmp(1,2);

corr2=smartcorrcoef(x, y);

assert(approxeq(corr1, corr2));

x(2)=NaN;
y(3)=NaN;

x1=x([1 4:end]);
y2=y([1 4:end]);


tmp=corrcoef(x1, y2);
corr3=tmp(1,2);

corr4=smartcorrcoef(x, y);

assert(approxeq(corr3, corr4));
