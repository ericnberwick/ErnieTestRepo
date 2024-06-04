function [mydates, op, hi, lo, cl, vol]=parseYahooRecentHistoricalPrice(sym)
% [op, hi, lo, cl, vol]=parseYahooRecentHistoricalPrice(sym) 

sym=regexprep(sym, '\.', '-'); % for Yahoo Finance, BF.B is BF-B

histPriceFile =urlread(['http://finance.yahoo.com/q/hp?s=', sym]);

dateFld=regexp(histPriceFile, '<td class="yfnc_tabledata1" nowrap align="right">([\d\w-]+)</td>', 'tokens');
numFld=regexp(histPriceFile, '<td class="yfnc_tabledata1" align="right">([\d\.,]+)</td>', 'tokens');

dateFld=[dateFld{:}]';
numFld=[numFld{:}]';


op=str2double(numFld(1:6:end));
hi=str2double(numFld(2:6:end));
lo=str2double(numFld(3:6:end));
cl=str2double(numFld(4:6:end));
vol=str2double(numFld(5:6:end));
adjCl=str2double(numFld(6:6:end));

op=op.*adjCl./cl;
hi=hi.*adjCl./cl;
lo=lo.*adjCl./cl;
cl=adjCl;


% mydateStr=datestr(datenum(num2str(mydate), 'yyyymmdd'), 'dd-mmm-yy');
% if (strcmp(mydateStr(1), '0'))
%     mydateStr=mydateStr(2:end);
% end

dateFld=cellstr(datestr(datenum(dateFld, 'dd-mmm-yy'), 'yyyymmdd'));

mydates=unique(dateFld); % Remove dividend or split row

assert(6*length(mydates)==length(numFld));

op=op(end:-1:1);
hi=hi(end:-1:1);
lo=lo(end:-1:1);
cl=cl(end:-1:1);
vol=vol(end:-1:1);

