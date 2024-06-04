function [ tdayET, hhmmET ] = convertCT2ET( tdayCT, hhmmCT )
%[ tdayET, hhmmET ] = convertCT2ET( tdayCT, hhmmCT )
%   Convert time and date in CT to ET

hhmmET=hhmmCT+100;
idx=hhmmET>2359;
hhmmET(idx)=hhmmET(idx)-2400;
tdayET=tdayCT;
tdayET(idx)=str2double(cellstr(datestr(datenum(num2str(tdayET(idx)), 'yyyymmdd')+1, 'yyyymmdd')));

end

