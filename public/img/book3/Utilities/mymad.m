function y = mad(x,dim)
%y = mad(x,dim) Median Absolute Deviation from the Median

if nargin<2, 
  dim = min(find(size(x)~=1));
  if isempty(dim), dim = 1; end
end

tile=ones(1,max(ndims(x),dim));
tile(dim)=size(x,dim);

y=median(abs(x-repmat(median(x,dim),tile)), dim);  % Remove mean
