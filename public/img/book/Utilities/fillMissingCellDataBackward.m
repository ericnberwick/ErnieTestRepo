function my_prices=fillMissingCellDataBackward(carray)
%  my_prices=fillMissingCellDataBackward(carray) fills carray element 'NaN' with next
%  cell's content. 

my_prices=carray;
for t=size(my_prices, 1)-1:-1:1
    missData=strcmp(my_prices(t, :, :), 'NaN');
    my_prices(t, missData)=my_prices(t+1, missData);
end
