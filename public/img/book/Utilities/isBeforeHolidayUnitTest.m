clear;

% load('C:/Projects/reversal_data/inputData_NDX', 'tday');
% 
% assert(~isBeforeHoliday(20060228, tday));
% assert(~isBeforeHoliday(20060301, tday));
% assert(isBeforeHoliday(20060113, tday));
% 
% clear;

load('C:/Projects/Splits_data/inputData_R1K_unadj', 'tday');

assert(isBeforeHoliday(20080620, tday));
assert(~isBeforeHoliday(20080625, tday));
assert(~isBeforeHoliday(20080624, tday));
assert(~isBeforeHoliday(20080623, tday));
