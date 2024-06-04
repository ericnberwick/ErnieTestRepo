function [ yyyymmdd ] = getTomorrowDate( )
%[ yyyymmdd ] = getTomorrowDate( )
%   Find next trade date. I.e. if today is Mon-Thu, gives next
%   day's yyyymmdd. If today is Fri-Sat, gives next Monday's yyyymmdd.

if (weekday(date)==6) % Friday
    yyyymmdd=str2double(datestr(datenum(date)+3, 'yyyymmdd'));
elseif (weekday(date)==7) % Saturday
    yyyymmdd=str2double(datestr(datenum(date)+2, 'yyyymmdd'));
else
    yyyymmdd=str2double(datestr(datenum(date)+1, 'yyyymmdd'));
end

end

