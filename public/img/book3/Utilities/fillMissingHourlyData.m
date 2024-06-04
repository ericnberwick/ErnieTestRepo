function my_prices=fillMissingHourlyData(prices)
%  my_prices=fillMissingHourlyData(prices) fills missing price with previous
%  day's price


my_prices=prices;

if (ndims(prices)==3) % (day, stock, hour)

	for h=2:size(prices, 3)
		missData=~isfinite(my_prices(1, :, h));
		my_prices(1, missData, h)=my_prices(1, missData, h-1);
	end

	for d=2:size(my_prices, 1)
		missData1=~isfinite(my_prices(d, :, 1));
		my_prices(d, missData1, 1)=my_prices(d-1, missData1, end);

		for h=2:size(prices, 3)
			missData=~isfinite(my_prices(d, :, h));
			my_prices(d, missData, h)=my_prices(d, missData, h-1);
		end
	end

elseif (ndims(prices)==2) % (day, hour)
	
	for h=2:size(prices, 2)
		if (~isfinite(my_prices(1, h)))
			my_prices(1, h)=my_prices(1, h-1);
		end
	end

	for d=2:size(my_prices, 1)
		if (~isfinite(my_prices(d, 1)))
			my_prices(d, 1)=my_prices(d-1, end);
		end
		
		for h=2:size(prices, 2)
			if (~isfinite(my_prices(d, h)))
				my_prices(d, h)=my_prices(d, h-1);
			end
		end
	end

	
else
	assert(0);
end
