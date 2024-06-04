function [symWithEarnAnn]=parseYahooEarningsCalendar2(amcDate, bmoDate, allsyms)
% symWithEarnAnn=parseYahooEarningsCalendar(amcDate, bmoDate, allsyms) amc=after
% market close, bmo=before market opens. allsyms is list of all stocks
% symbols within universe
% Note the output symbols conform to inputData format: i.e. BF-B or BF.B ->
% BFB

syms=[];
amcFile=[];
bmoFile=[];

try
    amcFile =urlread(['http://biz.yahoo.com/research/earncal/', num2str(amcDate), '.html']);
catch
    amcFile=[];
    fprintf(1, 'Missing %i\n', amcDate);
end

try
    bmoFile =urlread(['http://biz.yahoo.com/research/earncal/', num2str(bmoDate), '.html']);
catch
    bmoFile=[];
    fprintf(1, 'Missing %i\n', bmoDate);
end

patternSym='finance.yahoo.com/q\?s=[\w%-\.=&]*">([\w-\.]+)</a>';
% patternSym='finance.yahoo.com/q\?s=[\w%\.=&]*">([\w-\.]+)</a>';

% patternSym='<a\s+href="http://finance.yahoo.com/q\?s=[\w%\.=&]*">([\w-\.]+)</a>';
% patternSym='<a href="http://finance.yahoo.com/q\?s=.+">([\w-\.]+)</a>';
patternTime='<small>([\w:\s]+)</small>';

if (~isempty(amcFile))
    
    symA=regexp(amcFile, patternSym , 'tokens');
    timeA=regexp(amcFile, patternTime, 'tokens');
    
    symA=[symA{:}];
    timeA=[timeA{:}];
    
    % if (amcDate==20100816) % No earnings on 20100816
    %     symA={};
    %     timeA=[];
    % end
    
    assert(length(symA)==length(timeA));
    idxA=strmatch('After Market Close', timeA);
    syms=symA(idxA)';
    
    idxHasHHMM=find(~cellfun('isempty', strfind(timeA, ':')));
    if (~isempty(idxHasHHMM))
        assert(all(~cellfun('isempty', strfind(timeA(idxHasHHMM), 'ET'))), 'Some HH:MM do not have ET');
                
        mytimes=char(timeA(idxHasHHMM)');
        
        mytimes(:, end-2:end)=[];
        mytimes=str2double(cellstr(datestr(datenum(cellstr(mytimes)), 'HHMM')));
        idxAfterCls=find(mytimes >= 1600);
        if (~isempty(idxAfterCls))
            syms=[syms; symA(idxHasHHMM(idxAfterCls))'];
        end
    end
end

if (~isempty(bmoFile))
    
    symB=regexp(bmoFile, patternSym, 'tokens');
    timeB=regexp(bmoFile, patternTime, 'tokens');
    
    symB=[symB{:}];
    timeB=[timeB{:}];
    
    % if (bmoDate==20100816)
    %     symB={};
    %     timeB=[];
    % end
    
    assert(length(symB)==length(timeB));
    
    idxB=strmatch('Before Market Open', timeB);
    syms=[syms; symB(idxB)'];
    
    idxHasHHMM=find(~cellfun('isempty', strfind(timeB, ':')));
    if (~isempty(idxHasHHMM))
        assert(all(~cellfun('isempty', strfind(timeB(idxHasHHMM), 'ET'))), 'Some HH:MM do not have ET');
                
        mytimes=char(timeB(idxHasHHMM)');
        
        mytimes(:, end-2:end)=[];
        mytimes=str2double(cellstr(datestr(datenum(cellstr(mytimes)), 'HHMM')));
        idxBeforeOpn=find(mytimes <= 930);
        if (~isempty(idxBeforeOpn))
            syms=[syms; symB(idxHasHHMM(idxBeforeOpn))'];
        end
    end

end

if (~isempty(syms))
    syms=regexprep(syms, '-', ''); % for Yahoo Finance, BF.B is BF-B
end

symWithEarnAnn=intersect(syms, allsyms);

