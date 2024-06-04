function [ frontContract ] = getFrontContract( rollDay, Nmonth )
% [ frontContract ] = getFrontContract( rollDay, Nmonth )
%   Find front contract symbol, assuming it rolls on or just after rollDay
%   of month, and contract expires Nmonth before contract month
%   E.g. for CL, rolls on 12th of month, and expires Nmonth=1 before
%   contract months, use getFrontContract(12, 1). Nmonth can only be 0 or
%   1.

assert(Nmonth==0 || Nmonth==1, 'Nmonth can only be 0 or 1' );

monthsSym={'F', 'G', 'H', 'J', 'K', 'M', 'N', 'Q', 'U', 'V', 'X', 'Z'};

currYYYY=datestr(now, 'yyyy');
currMM=str2double(datestr(now, 'mm'));
currDD=str2double(datestr(now, 'dd'));

%% This is specific to CL, because it expires one month before contract
% month

if (Nmonth==1)
    if (currDD < rollDay)
        if (currMM < 12)
            frontContract=[monthsSym{currMM+1}, currYYYY(end)];
        else
            nextYYYY=char(str2double(currYYYY)+1);
            frontContract=[monthsSym{1}, nextYYYY(end)];
        end
    else
        if (currMM < 11)
            frontContract=[monthsSym{currMM+2}, currYYYY(end)];
        else
            nextYYYY=char(str2double(currYYYY)+1);
            frontContract=[monthsSym{rem(currMM+2, 12)}, nextYYYY(end)];
        end
    end
else
    if (currDD < rollDay)
        frontContract=[monthsSym{currMM}, currYYYY(end)];
    else
        if (currMM < 12)
            frontContract=[monthsSym{currMM+1}, currYYYY(end)];
        else
            nextYYYY=char(str2double(currYYYY)+1);
            frontContract=[monthsSym{1}, nextYYYY(end)];
        end
    end
end
end

