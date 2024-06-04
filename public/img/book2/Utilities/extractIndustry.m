clear;

[ch, allstocks, industries]=mytextread('D:/Browse2ML/INDUSTRIES.txt', {'SYMBOL'; 'INDNAME'});

load D:/Browse2ML/spx_sector;

industry=sector;
industry(:, 2)='';

for s=1:size(sector, 1)
    idx=strmatch(sector(s, 1), allstocks, 'exact');
    assert(length(idx)>=1, [char(sector(s, 1)) ' does not have industry???']);
    assert(length(idx)==1, [char(sector(s, 1)) ' have more than 1 industry???']);

    industry(s, 2)=industries(idx);
end



sector=industry; % change to old name


save D:/Browse2ML/spx_industry sector;
