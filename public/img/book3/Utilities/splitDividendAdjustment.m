function [op hi lo cl vol]=splitDividendAdjustment(prevDate, todayDate, stocks, op, hi, lo, cl, vol)

% Split-adjust
splits=parseSplitsCalendar(prevDate, stocks);
if (~isempty(splits))
    op=op./repmat(splits', [size(op, 1) 1]);
    hi=hi./repmat(splits', [size(hi, 1) 1]);
    lo=lo./repmat(splits', [size(lo, 1) 1]);
    cl=cl./repmat(splits', [size(cl, 1) 1]);
    vol=vol.*repmat(splits', [size(vol, 1) 1]);
end

% Dividend-adjust
dividends=parseDividendCalendar(todayDate, stocks);
if (~isempty(dividends))
    op=op-repmat(dividends', [size(op, 1) 1]);
    hi=hi-repmat(dividends', [size(hi, 1) 1]);
    lo=lo-repmat(dividends', [size(lo, 1) 1]);
    cl=cl-repmat(dividends', [size(cl, 1) 1]);
end