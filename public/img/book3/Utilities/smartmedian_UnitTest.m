clear;

x=rand(3, 5)

assert(all(smartmedian(x)==smartmedian(x, 1)));
assert(all(smartmedian(x, 2)==smartmedian(x')'));

x(2, 4)=NaN;
x(1, 3)=NaN

assert(all(smartmedian(x)==smartmedian(x, 1)));
assert(all(smartmedian(x, 2)==smartmedian(x')'));

% 
% 
% function y = smartmedian( x,dim)
% % y = smartmedian( x,dim)
% 
% assert(ndims(x) <= 2);   % Only implemented case
% 
% if nargin<2, 
%   dim = min(find(size(x)~=1));
%   if isempty(dim), dim = 1; end
% end
% 
% 
% 
% goodData=~isnan(x);
% 
% 
% if (dim==1)
%     y=NaN(1, size(x, 2));
% 
%     for c=1:size(x, 2)
%         y(1, c)=median(x(goodData(:, c), c));
%     end
% else
%     y=NaN(size(x, 1), 1);
% 
%     for r=1:size(x, 1)
%         y(r, 1)=median(x(r, goodData(r, :)));
%     end
% end
% 
% end
% 
