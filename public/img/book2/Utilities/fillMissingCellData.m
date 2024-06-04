function my_prices=fillMissingCellData(carray)
%  my_prices=fillMissingCellData(carray) fills carray element 'NaN' with
%  previous cell's content. 

my_prices=carray;
for t=2:size(my_prices, 1)
    missData=strcmp(my_prices(t, :, :), 'NaN');
    my_prices(t, missData)=my_prices(t-1, missData);
end
