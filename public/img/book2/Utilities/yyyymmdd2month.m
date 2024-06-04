function m=yyyymmdd2month(yyyymmdd)
% m=yyyymmdd2month(yyyymmdd)
m=month(datenum(num2str(yyyymmdd), 'yyyymmdd'));