function [ HH, MM, SS ] = IBTime2HHMMSS( IBTime, isEDT )
%[ HH, MM, SS ] = IBTime2HHMMSS( IBTime, isEDT )
% IBTime is a long integer specifying the number of seconds since 1/1/1970 GMT
% [HH, MM, SS] is in EST if isEDT==false, or EDT if
% isEDT==true


if (isEDT)
    x=rem(IBTime, 60*60*24)/60/60-4;
else
    x=rem(IBTime, 60*60*24)/60/60-5;
end

HH=floor(x);
MM=floor((x-HH)*60);
SS=round((x-HH-MM/60)*60*60);

end

