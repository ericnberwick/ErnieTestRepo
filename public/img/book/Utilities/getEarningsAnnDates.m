earningsDir='\\Statarbsvr0\D_Drive\FirstCall\';

load('D:/Projects/sectorModel_prod/inputData4', 'stocks');

deadstocksIdx=find(~isempty(regexp(stocks, '_')));



