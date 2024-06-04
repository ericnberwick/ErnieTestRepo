clear;

universe='spx';
infile=['c:/data_james/', universe, '_ohlcvol_bak'];
load(infile);

startIdx=strmatch('09/11/01', tday);
endIdx=strmatch('09/14/01', tday);

j=[startIdx:endIdx];

tday(j)=[];
open(j,:)=[];
high(j,:)=[];
low(j,:)=[];
cls(j,:)=[];
vol(j,:)=[];


% get rid of zero prices due to IPO day

zerodays=open==0|high==0|low==0|cls==0|vol==0;

open(zerodays)=NaN;
high(zerodays)=NaN;
low(zerodays)=NaN;
cls(zerodays)=NaN;
vol(zerodays)=NaN;

opn=open; % change name
save(['C:/data_james/', universe, '_ohlcvol'], 'stocks', 'tday', 'opn', 'high', 'low', 'cls', 'vol'); 
