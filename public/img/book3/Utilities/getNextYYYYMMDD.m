function [ yyyy, mm, dd ] = getNextYYYYMMDD
%[ yyyy, mm, dd ] = getNextYYYYMMDD
%   Get the yyyy, mm, dd of the next calendar date

yyyy=str2double(datestr(floor(now)+1, 'yyyy'));
mm=str2double(datestr(floor(now)+1, 'mm'));
dd=str2double(datestr(floor(now)+1, 'dd'));
end

