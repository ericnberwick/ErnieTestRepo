function [divs splits]=parseBlbDivsSplitsCalendar(mysyms, exDate, file)
% [divs splits]=parseBlbDivSplitsCalendar(mysyms, exDate, file)
% divs=0 if no dividends, otherwise it is the dollar per share
% splits=1 if no splits, 2 if 2:1 splits.
% mysyms is list of all stocks
% size(splits)=size(mysyms)
% Note the input symbols must have no - or .

divs=zeros(size(mysyms));
splits=ones(size(mysyms));

[num txt]=xlsread(file);

allSyms=txt(2:end, 1);

[foo idxMy idxAll]=intersect(mysyms, allSyms);

divExDate=str2double(cellstr(datestr(datenum(regexprep(txt(2:end, 2),  '12:00:00 AM', '01/01/1900')), 'yyyymmdd')));

allDivs=num(:, 1);
allDivs(divExDate~=exDate)=0;

divs(idxMy)=allDivs(idxAll);

splitsExDate=str2double(cellstr(datestr(datenum(regexprep(txt(2:end, 4),  '12:00:00 AM', '01/01/1900')), 'yyyymmdd')));

allSplits=num(:, 3);
allSplits(splitsExDate~=exDate)=1;

splits(idxMy)=allSplits(idxAll);

