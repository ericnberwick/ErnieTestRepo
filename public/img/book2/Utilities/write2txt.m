
clear;

universe='spx';


fprintf(1, 'universe=%s\n', universe);
infile=['d:/Browse2ML/', universe, '_ohlcvol'];
load(infile);



mystocks={'AA', 'KEY', 'JP', 'YUM', 'AN', 'NOC'};

mystocksidx=[];
heading={'DATE:N'};
for s=1:length(mystocks)
    idx=strmatch(mystocks{s}, stocks, 'exact');
    mystocksidx(end+1)=idx;
    heading{end+1}=[char(mystocks{s}) ':N'];
end


cell2txt(num2cell([tday opn(:, mystocksidx)]), heading, 'C:/temp/opn.DTB');
cell2txt(num2cell([tday high(:, mystocksidx)]), heading, 'C:/temp/high.DTB');
cell2txt(num2cell([tday low(:, mystocksidx)]), heading, 'C:/temp/low.DTB');
cell2txt(num2cell([tday cls(:, mystocksidx)]), heading, 'C:/temp/cls.DTB');
