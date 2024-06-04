function mydatenum=tday2datenum(tday)
% mydatenum=tday2datenum(tday)

tday=num2str(tday);

mydatenum=datenum(str2num(tday(:, 1:4)), str2num(tday(:, 5:6)), str2num(tday(:, 7:8)));

