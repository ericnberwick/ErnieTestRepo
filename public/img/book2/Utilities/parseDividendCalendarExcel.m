function [ dividends ] = parseDividendCalendarExcel( exDate,  allsyms )
%[ dividends ] = parseDividendCalendarExcel( exDate,  allsyms )
% Use .csv as input file.
% dividends=0 if no dividend, otherwise equals to $ per share.
% allsyms is list of all stocks symbols within universe
% size(dividends)=size(allsyms)
% Note the input symbols must conform to format: i.e.BF.B ->
% BF-B

allsyms=regexprep(allsyms, '\.', '-'); % for dividend.com, BF.B is BF-B

dividends=[];

% [num txt]=xlsread(['C:/Projects/reversal_data/dividends', num2str(exDate)]);
[num txt]=xlsread(['C:/Projects/prod_data/dividend', num2str(exDate), '.csv']);
symsA=deblank(txt(2:end, 1));
divA=num(:, 8);
exDates=txt(2:end, 6);

assert(length(symsA)==length(divA));
assert(all(exDate==str2double(cellstr(datestr(datenum(exDates, 'mm/dd/yyyy'), 'yyyymmdd')))));


if (length(symsA) > 0)

	dividends=zeros(size(allsyms));

	[symWithDiv, iA, iB]=intersect(symsA, allsyms);

	dividends(iB)=divA(iA);
	
	dividends(~isfinite(dividends))=0;

end

end

