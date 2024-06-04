function [ dt ] = convert2Datetime( yyyymmdd, hhmm )
% [ dt ] = convert2Datetime( yyyymmdd, hhmm )
%   Convert 2 double arrays yyyymmdd and hhmm to a single datetime array

dt1=datetime(yyyymmdd, 'ConvertFrom', 'yyyymmdd');
hhmm=num2str(hhmm);

nCol=size(hhmm, 2);
ndiff=4-nCol;
if (ndiff > 0)
   hhmm=[repmat('0', [size(hhmm, 1) ndiff]), hhmm]; 
end

hh=cellstr(hhmm(:, 1:2));
hh(cellfun('isempty', hh))=deal(cellstr('00'));
mm=cellstr(hhmm(:, 3:4));


dt=datetime(year(dt1), month(dt1), day(dt1), cell2num1(hh),  cell2num1(mm), zeros(size(hhmm, 1), 1));


end

