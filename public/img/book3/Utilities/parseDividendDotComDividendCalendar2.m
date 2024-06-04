%function [syms dividends]=parseDividendDotComDividendCalendar2(exDate)
% [syms dividends]=parseDividendDotComDividendCalendar2(exDate)

% This version returns all symbols that have ex dates.
% dividends=0 if no dividend, otherwise equals to $ per share.
% size(dividends)=size(allsyms)
% Note the output symbols  conform to dividend.com format: i.e. BF-B 
assert(0, 'Format does not work with .php!');
clear;

dividends=[];
syms=[];

dividendsFile=urlread('http://www.dividend.com/ex-dividend-dates.php');
% dividendsFile=urlread('file:///C:/Projects/reversal_data/dividendDotCom20130710.txt'); % DEBUG ONLY!!!
% dividendsFile=urlread('file:///C:/Projects/reversal_data/dividendDotCom20130711.txt'); % DEBUG ONLY!!!

patternExDate='<td>\s*(\d+/\d+)\s*</td>\s*<td>\s*\d+/\d+\s*</td>';
exDates=regexp(dividendsFile, patternExDate, 'tokens');
exDates=[exDates{:}];

patternDiv='<td>\s*\d+/\d+\s*</td>\s*<td>\s*\d+/\d+\s*</td>\s*<td>\s*([\.\d]+)\s*</td>';
dividends=regexp(dividendsFile, patternDiv, 'tokens');
dividends=[dividends{:}];

% myExDate=[num2str(str2double(datestr(datenum(num2str(exDate), 'yyyymmdd'), 'mm'))) '/' num2str(str2double(datestr(datenum(num2str(exDate), 'yyyymmdd'), 'dd')))];

if (~isempty(exDates))

    assert(length(unique(exDates))==1); % All displayed dividends ex dates should be the same

    patternSym='>([\w-]+)</a>';
    syms=regexp(dividendsFile, patternSym, 'tokens');
    syms=[syms{:}];
        
    if (length(syms)==length(exDates)-1)
        exDates(1)=[]; % Sometimes a "C-C" symbol appeared at first line which does not get parsed
        dividends(1)=[];
    end
    
    assert(length(exDates)==length(syms));
    assert(length(exDates)==length(dividends));
    

end

save(['C:/Projects/prod_data/dividends_', exDates(1)], 'syms', 'dividends');