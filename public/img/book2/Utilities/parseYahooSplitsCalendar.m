function splits=parseYahooSplitsCalendar(exDate,  allsyms)
% splits=parseYahooSplitsCalendar(exDate,  allsyms)
% splits=1 if no splits, 2 if 2:1 splits.
% allsyms is list of all stocks
% symbols within universe
% size(splits)=size(allsyms)
% Note the input symbols must conform to format: i.e. BF-B or BF.B ->
% BFB

allsyms=regexprep(allsyms, '\.', '-'); % for finance.yahoo.com, BF.B is BF-B

splits=ones(size(allsyms));

splitsFile=urlread(['http://biz.yahoo.com/c/s.html']);

patternExDate='<td align=center>(\w\w\w \d\d)</td><td>';
exDates=regexp(splitsFile, patternExDate, 'tokens');
exDates=[exDates{:}];

myExDate=datestr(datenum(num2str(exDate), 'yyyymmdd'), 'mmm dd');

idx=find(strcmp(exDates, myExDate));

if (~isempty(idx))
    patternSym='<td align=center>([\D]+)</a></td><td align=center>[Y|N]</td>';
    %     patternSym='<td align=center>([\w]+)</a></td><td align=center>[Y|N]</td>';
    syms=regexp(splitsFile, patternSym, 'tokens');
    syms=[syms{:}];
    
    %     syms=regexp(syms, '(\w+)</a>', 'tokens');
    %     syms=[syms];
    
    assert(length(exDates)==length(syms));
    
    patternSplitsNewShr='<td align=center>[Y|N]</td><td align=center>(\d+)-\d+';
    patternSplitsOldShr='<td align=center>[Y|N]</td><td align=center>\d+-(\d+)';
    
    newShr=regexp(splitsFile, patternSplitsNewShr, 'tokens');
    oldShr=regexp(splitsFile, patternSplitsOldShr, 'tokens');
    
    newShr=[newShr{:}];
    oldShr=[oldShr{:}];
    
    splitsA=str2double(cellstr(newShr))./str2double(cellstr(oldShr));
       
    assert(length(syms)==length(splitsA));

    for i=1:length(idx)
    
        mysym=char(syms(idx(i)));
        mysym1=regexp(mysym, '(\w+)$', 'tokens');
        mysym1=[mysym1{:}];
        
        splits(strcmp(mysym1, allsyms))=splitsA(idx(i));
                  
    end
else
    splits=ones(size(allsyms));
end
