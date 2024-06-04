function y = smartmad(x,dim)
%y = mad(x,dim) Median Absolute Deviation from the Median
% Apply to first non-singleton dimension if dim not specified.

if nargin<2, 
  dim = min(find(size(x)~=1));
  if isempty(dim), dim = 1; end
end

tile=ones(1,max(ndims(x),dim));
tile(dim)=size(x,dim);

y=smartmedian(abs(x-repmat(smartmedian(x,dim),tile)), dim);  % Remove median
