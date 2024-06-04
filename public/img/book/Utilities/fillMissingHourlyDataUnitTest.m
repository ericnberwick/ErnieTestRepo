clear;

cls=randn(5, 2, 3);

cls(1, 1, :)=NaN;
cls(1, 2, 2)=NaN;
cls(3, 1, 1)=NaN;
cls(4, 2, 3)=NaN;


my_cls=fillMissingHourlyData(cls);

assert(all(isnan(my_cls(1, 1, :))));

squeeze(cls(:, 1, :))
squeeze(my_cls(:, 1, :))

squeeze(cls(:, 2, :))
squeeze(my_cls(:, 2, :))


my_cls=fillMissingHourlyData(squeeze(cls(:, 1, :)))

