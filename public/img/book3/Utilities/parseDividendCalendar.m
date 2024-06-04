function dividends=parseDividendCalendar(exDate,  allsyms)
% dividends=parseDividendCalendar(exDate, allsyms)
% dividends=0 if no dividend, otherwise equals to $ per share.
% allsyms is list of all stocks symbols within universe
% size(dividends)=size(allsyms)
% Note the input symbols must conform to format: i.e. BF-B or BF.B ->
% BFB

allsyms=regexprep(allsyms, '\.', ''); % for earnings.com, BF.B is BFB

dividends=[];

dividendFile=urlread(['http://earnings.com/dividend.asp?date=', num2str(exDate), '&client=cb']);

% patternSym='<a\s+href="company.asp\?ticker=([\*\w\._/-]+)&coid';
patternSymSpace='<a\s+href="company.asp\?ticker=([\*\w\._/- ]+)&coid';
% patternDivPercent='<td align="center">([\d\.]+)%</td>';
patternDiv='<td align="center">(\$([\d\.]+)|([\d\.]+)%)</td>';

% symA=regexp(dividendFile, patternSym , 'tokens');
symASpace=regexp(dividendFile, patternSymSpace , 'tokens');
divA=regexp(dividendFile, patternDiv, 'tokens');

symsA=[symASpace{:}];
divA=[divA{:}];


% foo=strmatch( 'TD%20P_RG.TO',symsA, 'exact');
% symsA(foo(1))=[];
% divA(foo(1)+1)=[];

% foo=strmatch( '$1.500',divA, 'exact');
% divA(17)=[];


assert(length(symsA)==length(divA));

if (length(symsA) > 0)

	idxPercent=strcontain('%', divA);

	% We ignore all dividends in percentage form
	symsA(idxPercent)=[];
	divA(idxPercent)=[];

	divA=regexprep(divA, '\$', '');
	divA=str2num(char(divA));
	% %
	% ii=strmatch('LOTZF.OTC', symsA, 'exact');
	% symsA(ii(2))=[];
	% ii=strmatch('LTOTY.PK', symsA, 'exact');
	% symsA(ii(1))=[];
	% ii=strmatch('RLTQK.OTC', symsA, 'exact');
	% symsA(ii(2))=[];

	% divAnew=divA(1:ii-1);
	% divAnew(end+1)=2.135;
	% divAnew=[divAnew; divA(ii:end)];
	% divA=divAnew;

	% symsA(strmatch('NFBP.PK', symsA, 'exact'))=[];
	% symsA(strmatch('CBCO', symsA, 'exact'))=[];
	% ii=strmatch('PLC_UN.V', symsA, 'exact');
	% symsA(ii(1))=[];


	% %
	% ii=strmatch('ACNB', symsA, 'exact');
	% symsA(ii(2))=[];
	% ii=strmatch('FREWF.PK', symsA, 'exact');
	% symsA(ii(2))=[];
	% ii=strmatch('SYXTY.PK', symsA, 'exact');
	% symsA(ii(2))=[];
	% ii=strmatch('DLKKF.PK', symsA, 'exact');
	% symsA(ii(1))=[];
	%
	% ii=strmatch('YMMTY.PK', symsA, 'exact');
	% symsA(ii(1))=[];
	% ii=strmatch('YMMUF.PK', symsA, 'exact');
	% symsA(ii(1))=[];

	% divA(ii(1))=[];
	% symsA(strmatch('AROW', symsA, 'exact'))=[];
	% symsA(strmatch('CNBZ', symsA, 'exact'))=[];
	% symsA(strmatch('MSL', symsA, 'exact'))=[];
	% symsA(strmatch('NRIM', symsA, 'exact'))=[];


	% ii=strmatch('SPIL', symsA, 'exact');
	% symsA(ii([2:4]))=[];
	% divA(ii(2))=[];
	% ii=strmatch('TTH', symsA, 'exact');
	% symsA(ii(1:2))=[];
	% divA(ii(1:2))=[];
	% ii=strmatch('WMH', symsA, 'exact');
	% symsA(ii(1:3))=[];
	% divA(ii(1:3))=[];
	% ii=strmatch('n/a', symsA, 'exact');
	% symsA(ii(1:6))=[];
	% divA(ii(1:6))=[];

	% divA(2)=[];

	assert(length(symsA)==length(divA));

	dividends=zeros(size(allsyms));

	[symWithDiv, iA, iB]=intersect(symsA, allsyms);

	dividends(iB)=divA(iA);

end