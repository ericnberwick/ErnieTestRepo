function [outputdatenum] = unixtime2datenum(inputtime) 
% input:
% a vertical vector with unix timestamps in seconds
% output:
% Matlab datenum

% unixtime is seconds since 1.1.1970
% matlabtime is days after 1.1.000

offset=datenum('1.1.1970', 'mm.dd.yyyy');
outputdatenum=offset+inputtime/60/60/24;

