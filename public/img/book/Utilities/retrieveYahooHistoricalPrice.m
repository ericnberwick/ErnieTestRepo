clear;

univFile='C:/Projects/data/SP1500.DTB';

outputFile='C:/Projects/data/inputDataSP1500';

[ch, stocks]=mytextread(univFile, {'Symbol'});

op=NaN(252, length(stocks));
hi=NaN(252, length(stocks));
lo=NaN(252, length(stocks));
cl=NaN(252, length(stocks));
vol=NaN(252, length(stocks));

for s=1:length(stocks)
    stk=stocks{s};
    

    [mydates, myop, myhi, mylo, mycls, myvol]=parseYahooRecentHistoricalPrice(stk);


    if (s==1)
        op=NaN(length(mydates), length(stocks));
        hi=NaN(length(mydates), length(stocks));
        lo=NaN(length(mydates), length(stocks));
        cl=NaN(length(mydates), length(stocks));
        vol=NaN(length(mydates), length(stocks));
        
        tday=mydates;
    end

    [foo, idxA, idxB]=intersect(mydates, tday);
    op(idxB, s)=myop(idxA);
    hi(idxB, s)=myhi(idxA);
    lo(idxB, s)=mylo(idxA);
    cl(idxB, s)=mycls(idxA);
    vol(idxB, s)=myvol(idxA);

    
end

save(outputFile,  'tday', 'stocks', 'op', 'hi', 'lo', 'cl', 'vol');
