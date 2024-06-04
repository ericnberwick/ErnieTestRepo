function clsHour=packCls(trainlen, cls10, cls11, cls12, cls13, cls14, cls15, cls16)
% pack cls1* to clsHour for last trainlen days.

clsHour=NaN(trainlen, size(cls15, 2), 7);
for h=1:7
	eval(['clsHour(:, :, h)=cls', num2str(9+h), '(end-trainlen+1:end, :);']);
end
