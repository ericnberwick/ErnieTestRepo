function [ yyyymmdd ] = getTodayDate(  )
%[ yyyymmdd ] = getTodayDate(  )
%   output is double

yyyymmdd=str2double(datestr(datenum(date), 'yyyymmdd'));


end

