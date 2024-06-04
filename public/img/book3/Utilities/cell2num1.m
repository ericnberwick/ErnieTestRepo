function out=cell2num1(x,varargin)
% CELL2NUM1(X)
% Converts cell array to numeric array.
% All nulls, strings, NaNs, empties are replaced by zeros.
%
% CELL2NUM1(X,flag)
% If flag is 0, then behavior is same as CELL2NUM1(X).
%
% If flag is 1, then NaNs remain as NaNs while non-numeric and empty
% strings are converted to zeros.
%

if nargin>1,
  flag = varargin{1};
else,
  flag = 0;
end,

[m n] = size(x);

out = zeros(size(x));
for t=1:m*n,
  if isempty(x{t}),
    out(t) = 0;
  else,
    if isnumeric(x{t})|islogical(x{t}),
      if isnan(x{t}),
        if flag==0,
          out(t) = 0;
        else,
          out(t) = x{t};
        end,
      else,
        out(t) = x{t};
      end, 
    else,
      if isnumeric(str2num(x{t})) & isempty(str2num(x{t}))==0,
        out(t) = str2num(x{t});
      else,
        out(t) = 0;
      end,
    end,  
  end,
end,