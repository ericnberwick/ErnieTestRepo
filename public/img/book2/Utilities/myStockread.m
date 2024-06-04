function [ColHeader,varargout]=mytextread(filename,varargin);
% 
% COLHEADER = MYSTOCKREAD(FILENAME)
%
% Reads the column headers of files written out by cell2txt.
%
% [ch,field1,field2] = myStockread(filename,{'field1'; 'field2'});
% reads in columns with headings equal to 'field1' and 'field2' and place
% data in field1 and field2.
%
% ch contains column headings.
% NOTE: this function works on the STOCKS.DTB files. It skips the top 2 header lines and the last line in its output.
% It works on both numeric and string fields.


% open file
fid=fopen(filename,'r');

% read first line
str=fgetl(fid);
fclose(fid);

% count number of columns and get column headers
TabIndx = find(str==char(9));
if isempty(TabIndx), % then try comma
  TabIndx = find(str==',');
end,
NCol = length(TabIndx)+1;
ColHeader = cell(NCol,1);
ColHeader{1} = str(1:TabIndx(1)-1);
for k=2:NCol-1,
  ColHeader{k} = str(TabIndx(k-1)+1:TabIndx(k)-1);
end,
ColHeader{NCol} = str(TabIndx(NCol-1)+1:length(str));

if nargout<=1,
  return;
end,

if nargin>1,
  ColToRead = varargin{1};
else,
  ColToRead = ColHeader;
end,

% create the appropriate format string to give to textread
[mc,nc] = size(ColToRead);
if nc>mc,
  ColToRead = ColToRead';
end,
NColToRead = max(size(ColToRead));

InvColHeader = cell(NCol,1);
for k=1:NCol,
  InvColHeader{k} = ColHeader{k}(length(ColHeader{k}):-1:1);
end,

IndxNumFld = strmatch('N:',InvColHeader);
IndxStrFld = strmatch('S:',InvColHeader);
% fields unqualified by N: or S: are assumed to be numeric fields
%IndxNumFld = [IndxNumFld; (setdiff(1:NCol,[IndxNumFld; IndxStrFld]))'];
% fields unqualified by N: or S: are assumed to be string fields
IndxStrFld = [IndxStrFld; (setdiff(1:NCol,[IndxNumFld; IndxStrFld]))'];

FmtStr = '';
OutStr = '';
for k=1:NCol,
  h1 = 0;
  for h=1:NColToRead,
    if isempty(strmatch(ColToRead{h,1}, ColHeader{k}, 'exact'))==0,
      h1 = h;
    end,
  end,
  if h1,
    vname=regexprep(ColToRead{h1,1}, '^_', '');
    vname=regexprep(vname, '^(\d)', 'B$1');
    ColToRead{h1,1}=vname;
    OutStr = [OutStr ColToRead{h1,1} ' '];
    if find(IndxNumFld==k),
      FmtStr = [FmtStr '%f'];
    else,
      FmtStr = [FmtStr '%s'];
    end,
  else,
    FmtStr = [FmtStr '%*s'];
  end,
end,

% call textread
eval(['[' OutStr '] = textread(''' filename ''',''' FmtStr ''',''delimiter'',''\b\t,'',''headerlines'',1);']);

for h=1:NColToRead,

    eval(['tmp = ' ColToRead{h,1} ';']);
  tmp = tmp(2:end-1);
  varargout{h} = str2double(tmp);
  if (any(isnan(varargout{h})))
      varargout{h} = tmp;
  end   
end,
