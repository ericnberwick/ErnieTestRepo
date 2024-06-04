function [ datetimeInET ] = utc2et( datetimeInUTC )
% [ datetimeInET ] = utc2et( datetimeInUTC )
%   Output is datetime in ET, with automatic adjustment for EST.
%  E.g. 
%  This also works if input is a vector of datetimes.

datetimeInET=datetime(datetimeInUTC, 'TimeZone', 'America/New_York');

end

