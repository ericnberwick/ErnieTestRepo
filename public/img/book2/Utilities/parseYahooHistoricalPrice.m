function [op, hi, lo, cl, vol, avgvol]=parseYahooHistoricalPrice(sym, mydate)
% [op, hi, lo, cl, vol, avgvol]=parseYahooHistoricalPrice(sym, mydate) mydate is
% YYYYMMDD

sym=regexprep(sym, '\.', '-'); % for Yahoo Finance, BF.B is BF-B

histPriceFile =urlread(['http://finance.yahoo.com/q/hp?s=', sym]);

%                              <td class="yfnc_tabledata1" nowrap align="right">1-Mar-06</td>
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

dateFld=unique(dateFld); % Remove dividend or split row
dateFld=dateFld(end:-1:1);

assert(6*length(dateFld)==length(numFld));

it=strmatch(num2str(mydate), dateFld, 'exact');

assert(~isempty(it));

op=op(it);
hi=hi(it);
lo=lo(it);
cl=cl(it);
avgvol=smartmean(vol);
vol=vol(it);

