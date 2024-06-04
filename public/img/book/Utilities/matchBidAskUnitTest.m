clear;

D1=datetime(repmat(2000, [5, 1]), repmat(1, [5 1]), [1 1 2 2 2]', [23 23 0 0 0]', [58 59 0 1 2]', zeros(1, 5)');
bid=[11:15]';

D2=datetime(repmat(2000, [5, 1]), repmat(1, [5 1]), [1 2 2 2 2]', [23 0 0 0 0]', [58 0 1 2 3]', zeros(1, 5)');
ask=[110:10:150]';

[D, myBid, myAsk]=matchBidAsk(D1, bid, D2, ask);
   
% assert(all(D==datetime(repmat(2000, [6, 1]), repmat(1, [6 1]), [1 1 2 2 2 2]', [23 23 0 0 0 0]', [58 59 0 1 2 3]', zeros(1, 6)')));

