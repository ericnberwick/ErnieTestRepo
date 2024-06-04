function dividends=parseDividendDotComDividendCalendar(exDate,  allsyms)
% dividends=parseDividendDotComDividendCalendar(exDate,  allsyms)

% dividends=0 if no dividend, otherwise equals to $ per share.
% allsyms is list of all stocks symbols within universe
% size(dividends)=size(allsyms)
% Note the input symbols must conform to dividend.com format: i.e. BF.B  ->
% BF-B 


allsyms=regexprep(allsyms, '\.', '\-'); % for  dividend.com, BF.B is BF-B

dividends=zeros(size(allsyms));

% dividendsFile=urlread('http://www.dividend.com/ex-dividend-dates.php');
dividendsFile=urlread('file:///C:/Projects/reversal_data/dividendDotCom20130710.txt'); % DEBUG ONLY!!!

patternExDate='<td>\s*(\d+/\d+)\s*</td>\s*<td>\s*\d+/\d+\s*</td>';
exDates=regexp(dividendsFile, patternExDate, 'tokens');
exDates=[exDates{:}];

patternDiv='<td>\s*\d+/\d+\s*</td>\s*<td>\s*\d+/\d+\s*</td>\s*<td>\s*([\.\d]+)\s*</td>';
myDiv=regexp(dividendsFile, patternDiv, 'tokens');
myDiv=[myDiv{:}];

myExDate=[num2str(str2double(datestr(datenum(num2str(exDate), 'yyyymmdd'), 'mm'))) '/' num2str(str2double(datestr(datenum(num2str(exDate), 'yyyymmdd'), 'dd')))];

if (~isempty(exDates))

    assert(all(strcmp(myExDate, exDates))); % All displayed dividends ex dates should match today's date

    patternSym='>([\w-]+)</a>';
    syms=regexp(dividendsFile, patternSym, 'tokens');
    syms=[syms{:}];
        
    if (length(syms)==length(exDates)-1)
        exDates(1)=[]; % Sometimes a "C-C" symbol appeared at first line which does not get parsed
        myDiv(1)=[];
    end
    
    assert(length(exDates)==length(syms));
    assert(length(exDates)==length(myDiv));
    
    [foo iA iB]=intersect(allsyms, syms);
    dividends(iA)=str2double(myDiv(iB));
 
end
