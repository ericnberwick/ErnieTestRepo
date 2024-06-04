clear;


load('D:/Projects/sectorModel_prod/inputData4');
cls=cls15;


startdate=19970102; % date when performance measurement should start
enddate=20031218;


startdateIdx=find(tday==startdate);
enddateIdx=find(tday==enddate);
cls=cls(1:enddateIdx, :);

sd=num2str(startdate);
sdnum=datenum(str2num(sd(1:4)), str2num(sd(5:6)), str2num(sd(7:8)));

ed=num2str(enddate);
ednum=datenum(str2num(ed(1:4)), str2num(ed(5:6)), str2num(ed(7:8)));

cday=datestr(sdnum:ednum, 29);

cday=str2num(char(regexprep(cellstr(cday), '-', '')));

my_cls=fillMissingData(cls, tday, cday);


cls=NaN*zeros(size(cls15, 1), size(cls15, 2), 3);

cls(:, :, 1)=cls10;
cls(:, :, 2)=cls11;
cls(:, :, 3)=cls12;

my_cls=fillMissingData(cls);
