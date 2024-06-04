function [ intarr ] = datenumOnMat( strarr, f )
% [ intarr ] = datenumOnMat( strarr, f )
%   applies datenum to each of strarr element assuming f format

intarr=NaN(size(strarr));
for c=1:size(strarr, 2)
    intarr(:, c)=datenum(strarr(:, c), f);
end


end

