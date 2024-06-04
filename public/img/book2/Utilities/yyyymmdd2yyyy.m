function yyyy=yyyymmdd2yyyy(yyyymmdd)
% yyyy=yyyymmdd2yyyy(yyyymmdd) returns a double
yyyy=year(datenum(num2str(yyyymmdd), 'yyyymmdd'));