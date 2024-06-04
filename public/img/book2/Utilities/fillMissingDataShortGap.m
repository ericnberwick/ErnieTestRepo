function my_prices=fillMissingDataShortGap(prices, varargin)
%  my_prices=fillMissingDataShortGap(prices) fills missing price with previous
%  day's price, except when the NEXT DAY is the end of price series.
%  my_prices=fillMissingDataShortGap(prices, tday, cday) fills missing prices with previous day's price including non-trading days
%  as specified in cday, except when the NEXT DAY is the end of price series.

my_prices=fillMissingData(prices, varargin{:});

deadStk=find(~isfinite(prices(end, :)));
for s=1:length(deadStk)
    goodDays=find(isfinite(prices(:, deadStk(s))));
    my_prices(min(goodDays(end)+2, end):end, deadStk(s))=NaN;
end    
