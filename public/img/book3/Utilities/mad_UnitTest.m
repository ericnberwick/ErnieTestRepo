% function y = mad(x,dim)
% %y = mad(x,dim) Median Absolute Deviation from the Median
% 
% if nargin<2, 
%   dim = min(find(size(x)~=1));
%   if isempty(dim), dim = 1; end
% end
% 
% tile=ones(1,max(ndims(x),dim));
% tile(dim)=size(x,dim);
% 
% y=median(abs(x-repmat(median(x,dim),tile)), dim);  % Remove mean

clear;

x=[1 2 2 3 3 3 4];
x_mad=1;

assert(x_mad==mad(x, 1));

x=[1 2 2 3 3 3 4; 1 2 2 3 3 3 4]';
x_mad=[1 1];

assert(all(x_mad==mad(x, 1)));