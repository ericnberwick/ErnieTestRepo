function retval=cell2txt(dta,heading,outfile)
%
% CELL2TXT(DTA,HEADING,OUTFILE)
%
% Writes cell array DTA into a tab-delimited text file 
%
% The path for the text file is specified in OUTFILE.
%
% HEADING should contain heading - data type pairs, e.g.
% HEADING = {'STRINGVARIABLE1:S'; 'NUMERICVARIABLE1:N'; 'STRINGVARIABLE1:S'}
% 
% That is, the heading - data type pair is the heading/variable name followed by
% :N for a numeric column and :S for a string column
%

Nheading = length(heading);
Invheading = cell(Nheading,1);
for k=1:Nheading,
  Invheading{k} = heading{k}(length(heading{k}):-1:1);
end,

IndxNumFld = strmatch('N:',Invheading);
IndxStrFld = strmatch('S:',Invheading);

FormatStr = '';
VarStr = '';
OutDta = cell(Nheading,1);
for k=1:Nheading-1,
  if find(IndxNumFld==k),
    FormatStr = [FormatStr '%.16f\t'];
    %     FormatStr = [FormatStr '%g\t'];
    VarStr = [VarStr ['OutDta{' num2str(k) '}(h),']];
    OutDta{k} = cell2num1({dta{:,k}}, 1)';
  end,
  if find(IndxStrFld==k),
    FormatStr = [FormatStr '%s\t'];
    VarStr = [VarStr ['OutDta{' num2str(k) '}{h},']];
    OutDta{k} = {dta{:,k}}';    
  end,
end,
if find(IndxNumFld==Nheading),
  %FormatStr = [FormatStr '%.9f\r\n'];
  FormatStr = [FormatStr '%g\r\n'];
  VarStr = [VarStr ['OutDta{' num2str(Nheading) '}(h)']];
  OutDta{Nheading} = cell2num1({dta{:,Nheading}}, 1)';
end,
if find(IndxStrFld==Nheading),
  FormatStr = [FormatStr '%s\r\n'];
  VarStr = [VarStr ['OutDta{' num2str(Nheading) '}{h}']];
  OutDta{Nheading} = {dta{:,Nheading}}';
end,

NOutDta = length(OutDta{1});
%OutStr = '';
%for h=1:NOutDta,
%  for k=1:Nheading-1,
%    if find(IndxNumFld==k),
%      OutStr = [OutStr num2str(OutDta{k}(h)) char(9)];
%    else,
%      OutStr = [OutStr OutDta{k}{h} char(9)];
%    end,
%  end,
%  if find(IndxNumFld==Nheading),
%    OutStr = [OutStr num2str(OutDta{k}(h)) char(13) char(10)];
%  else,
%    OutStr = [OutStr OutDta{k}(h)  char(13) char(10)];
%  end,
%end,

fid = fopen(outfile,'w');
for k=1:Nheading-1,
  fprintf(fid,'%s\t',heading{k});
end,
fprintf(fid,'%s\r\n',heading{Nheading});

for h=1:NOutDta,
  eval(['fprintf(fid,''' FormatStr ''',' VarStr ');']);
end,
fclose(fid);

retval = NOutDta;
