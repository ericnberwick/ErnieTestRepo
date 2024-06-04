function idx=strcontain(str, cellarr)
% idx=strcontain(str, cellarr) : find indices of cellarr which contain
% the string str. E.g. str='_', cellarr={'A', 'B_1', 'B_2', 'C'}, idx=[2; 3]

idx=find(~cellfun('isempty', regexp(cellarr, str)));
