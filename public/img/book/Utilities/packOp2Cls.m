function clsHour=packOp2Cls(trainlen, op, cls10, cls11, cls12, cls13, cls14, cls15, cls16)
% pack cls1* to clsHour for last trainlen days.

clsHour=NaN(trainlen, size(cls15, 2), 8);
clsHour(:, :, 1)=op(end-trainlen+1:end, :);
for h=1:7
	eval(['clsHour(:, :, h+1)=cls', num2str(9+h), '(end-trainlen+1:end, :);']);
end
