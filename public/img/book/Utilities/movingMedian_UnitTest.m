% function [mvavg] = movingMedian(x, T)
% %  [mvavg] = movingMedian(x, T). create moving median series over T days. mvavg
% % has T-1 NaN in beginning.
% 
% assert(T>0);
% 
% mvavg = zeros(size(x,1)-T+1, size(x, 2));
% 
% for t=T:size(x, 1)
%     mvavg(t, :)=median(x(t-T+1:t, :), 1);
% end



clear;

x=[1 2 2 3 3 3 4]';

x_mm=[2 2.5 3 3]';
x_mmm=movingMedian(x, 4);

assert(all(x_mm==x_mmm(4:end, :)));
