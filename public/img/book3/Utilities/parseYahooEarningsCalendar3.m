function earnings=parseYahooEarningsCalendar3(amcDate, bmoDate, allsyms)
% earnings=parseYahooEarningsCalendar3(amcDate, bmoDate, allsyms) amc=after
% market close, bmo=before market opens. allsyms is list of all stocks
% symbols within universe
% size(earnings)=size(allsyms)
% Note the output symbols conform to inputData format: i.e. BF-B or BF.B ->
% BFB

amcFile =urlread(['http://biz.yahoo.com/research/earncal/', num2str(amcDate), '.html']);
bmoFile =urlread(['http://biz.yahoo.com/research/earncal/', num2str(bmoDate), '.html']);

patternSym='finance.yahoo.com/q\?s=[\w-%\.=&]*">([\w-\.]+)</a>';
% patternSym='<a\s+href="http://finance.yahoo.com/q\?s=[\w%\.=&]*">([\w-\.]+)</a>';
% patternSym='<a href="http://finance.yahoo.com/q\?s=.+">([\w-\.]+)</a>';
patternTime='<small>([\w:\s]+)</small>';

symA=regexp(amcFile, patternSym , 'tokens');
timeA=regexp(amcFile, patternTime, 'tokens');

symA=[symA{:}];
timeA=[timeA{:}];

earnings=zeros(size(allsyms));

if (amcDate==20000703) % No earnings on 20000703
    symA={};
    timeA=[];
end

assert(length(symA)==length(timeA));
idxA=strmatch('After Market Close', timeA);
syms=symA(idxA)';

symB=regexp(bmoFile, patternSym, 'tokens');
timeB=regexp(bmoFile, patternTime, 'tokens');

symB=[symB{:}];
timeB=[timeB{:}];

if (bmoDate==20000703)
    symB={};
    timeB=[];
end

assert(length(symB)==length(timeB));

idxB=strmatch('Before Market Open', timeB);
syms=[syms; symB(idxB)'];

if (~isempty(syms))
    syms=regexprep(syms, '-', ''); % for Yahoo Finance, BF.B is BF-B
end

[symWithEarnAnn, iA, iB]=intersect(syms, allsyms);

earnings(iB)=1;

