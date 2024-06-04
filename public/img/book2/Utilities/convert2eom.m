function eomYYYYMMDD=convert2eom(yyyymmdd, tday)
% eomYYYYMMDD=convert2eom(yyyymmdd, tday), assume tday is trade days,
% convert the array of yyyymmdd into the last day of the month.

eomYYYYMMDD=NaN(length(yyyymmdd), 1);

tday_yyyymm=yyyymmdd2month(tday);
tday_yyyymm=num2str(tday);
tday_yyyymm=str2double(cellstr(tday_yyyymm(:, 1:6)));

myyyyymm=num2str(yyyymmdd);
myyyyymm=str2double(cellstr(myyyyymm(:, 1:6)));

tday_yyyymm(~isLastTradingDayOfMonth(tday, tday))=NaN;

[foo, idxA, idxB]=intersect(tday_yyyymm, myyyyymm);

eomYYYYMMDD(idxB)=tday(idxA);




