function [ strarr ] = numcell2str( numarr )
%[ strarr ] = numcell2str( numarr )
%   Turns a numerical matrix into a cell array of strings

strarr=cellfun(@num2str, num2cell(numarr), 'UniformOutput', false);

end

