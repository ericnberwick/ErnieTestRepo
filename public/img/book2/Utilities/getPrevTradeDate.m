function [ yyyymmdd ] = getPrevTradeDate( )
%[ yyyymmdd ] = prevTradeDate( )
%   Find previous trade date. I.e. if today is Tue-Sat, gives previous
%   day's yyyymmdd. If today is Sun-Mon, gives previous Friday's yyyymmdd.

if (weekday(date)==1) % Sunday
    yyyymmdd=str2double(datestr(datenum(date)-2, 'yyyymmdd'));
elseif (weekday(date)==2) % Monday
    yyyymmdd=str2double(datestr(datenum(date)-3, 'yyyymmdd'));
else
    yyyymmdd=str2double(datestr(datenum(date)-1, 'yyyymmdd'));
end

end

