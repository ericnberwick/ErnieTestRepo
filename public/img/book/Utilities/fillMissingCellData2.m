function my_prices=fillMissingCellData2(carray)
%  my_prices=fillMissingCellData(carray) fills empty carray element with
%  previous cell's content. 

my_prices=carray;
for t=2:size(my_prices, 1)
    missData=find(cellfun('isempty', my_prices(t, :, :)));
    my_prices(t, missData)=my_prices(t-1, missData);
end
