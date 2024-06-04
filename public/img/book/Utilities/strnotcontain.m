function idx=strnotcontain(str, cellarr)
% idx=strnotcontain(str, cellarr) : find indices of cellarr which do NOT contain
% the string str. E.g. str='_', cellarr={'A', 'B_1', 'B_2', 'C'}, idx=[1; 4]

idx=find(cellfun('isempty', regexp(cellarr, str)));
