function [ cday ] = tday2cday( tday )
%[ cday ] = tday2cday( tday )
%   Convert an array of trading days (integers yyyymmdd) to array of calendar days (also integers yyyymmdd) with
%   weekends and holidays inserted. cday is always a Tx1 matrix.

assert(size(tday, 2)==1);

firstDateNum=datenum(num2str(tday(1)), 'yyyymmdd');
lastDateNum =datenum(num2str(tday(end)), 'yyyymmdd');

cday=str2double(cellstr(datestr(firstDateNum:lastDateNum, 'yyyymmdd')));

end

