function splits=parseSplitsCalendar(payableDate,  allsyms)
% splits=parseSplitsCalendar(payableDate, allsyms) 
% splits=1 if no splits, 2 if 2:1 splits.
% payableDate is one day
% before exDate. allsyms is list of all stocks
% symbols within universe
% size(splits)=size(allsyms)
% Note the input symbols must conform to format: i.e. BF-B or BF.B ->
% BFB

allsyms=regexprep(allsyms, '\.', ''); % for earnings.com, BF.B is BFB

splits=[];

splitsFile=urlread(['http://earnings.com/split.asp?date=', num2str(payableDate), '&client=cb']);

% patternSym='finance.yahoo.com/q\?s=[\w-%\.=&]*">([\w-\.]+)</a>';
% patternSym='<a\s+href="http://finance.yahoo.com/q\?s=[\w%\.=&]*">([\w-\.]+)</a>';
% patternSym='<a href="http://finance.yahoo.com/q\?s=.+">([\w-\.]+)</a>';
% patternTime='<small>([\w:\s]+)</small>';


patternSym='<a\s+href="company.asp\?ticker=([\w\._/-]+)&coid';
patternSplit='<td align="center">([\d\.-]+)\s+</td>';

symA=regexp(splitsFile, patternSym , 'tokens');
splitA=regexp(splitsFile, patternSplit, 'tokens');

symsA=[symA{:}];
splitsA=[splitA{:}];

% assert(payableDate==20111128);
% splitsA(4)=[];


if (~isempty(splitsA))
    oldShr=regexp(splitsA, '([\d\.]+)-\d+', 'tokens');
    newShr=regexp(splitsA, '\d+-(\d+)', 'tokens');

    oldShr=[oldShr{:}];
    newShr=[newShr{:}];

    oldShr=char([oldShr{:}]);
    newShr=char([newShr{:}]);

    splitsA=str2double(cellstr(oldShr))./str2double(cellstr(newShr));

    assert(length(symsA)==length(splitsA));

    splits=ones(size(allsyms));

    [symWithSplits, iA, iB]=intersect(symsA, allsyms);

    splits(iB)=splitsA(iA);
else
    splits=ones(size(allsyms));
end
