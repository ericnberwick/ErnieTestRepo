function earningsOrGuidance=checkEarningsOrGuidance(prevDate, todayDate, stocks)

% Exclude earnings or guidance stocks
[earnings]=parseEarningsCalendar(prevDate, todayDate, stocks);
% [earnings]=parseYahooEarningsCalendar3(amcDate, bmoDate, stocks);
[earnings2]=parseEarningsCalendarFromEarningsDotCom(prevDate, todayDate, stocks);

earnings=logical(earnings);
earnings2=logical(earnings2);

earningsWhispersOnly=setdiff(stocks(earnings), stocks(earnings2));
for s=1:length(earningsWhispersOnly)
    fprintf(1, '*** %s is in earningsWhispers only\n', char(earningsWhispersOnly(s)));
end
earningsDotComOnly=setdiff(stocks(earnings2), stocks(earnings));
for s=1:length(earningsDotComOnly)
    fprintf(1, '*** %s is in earnings.com only\n', char(earningsDotComOnly(s)));
end

earnings=earnings2 | earnings; % Trust earnings.com over earningsWhispers.com!

[guidance]=parseGuidance3(prevDate, todayDate, stocks);

assert(length(earnings)==length(stocks));
assert(length(guidance)==length(stocks));

earningsOrGuidance=earnings~=0 | guidance~=0;
