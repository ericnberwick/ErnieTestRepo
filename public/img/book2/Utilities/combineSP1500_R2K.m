clear;
sp1500File='C:/Projects/data/SP1500.DTB';
[ch, sp1500]=mytextread(sp1500File, {'Symbol'});

r2kFile='C:/Projects/data/R2K.DTB';
[ch, r2k, foo]=mytextread(r2kFile, {'Symbol', 'FOO'});

additions=setdiff(r2k, sp1500)

cell2txt([cellstr(additions), num2cell(foo(1:length(additions)))], {'Symbol:S', 'FOO:N'}, 'C:/Projects/data/R2Ka.DTB');
