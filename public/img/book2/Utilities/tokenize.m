function [tokens]=tokenize(str, varargin)
% tokens=tokenize(str, varargin) will generate a cell array of tokens using
% whitespace as delimiter by default, otherwise use varargin{1}

if (nargin==1)
    tok=' ';
end
if (nargin>=2)
    tok=varargin{1};
end


tokens=regexp(str,['([^', tok, ']+)'],'tokens');


if (ischar(str))
    tokens=[tokens{:}];
end % this must be a cell array
    