function my_prices=fillMissingDataBackward(prices)
%  my_prices=fillMissingDataBackward(prices) fills missing price with next
%  day's price

my_prices=prices;
for t=size(my_prices, 1)-1:-1:1
    missData=~isfinite(my_prices(t, :, :));
    my_prices(t, missData)=my_prices(t+1, missData);
end
