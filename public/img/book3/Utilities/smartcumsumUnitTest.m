X=[0 1 2; 3 4 5];

assert(smartcumsum(X, 1)==[0 1 2; 3 5 7]);

X=[0 1 2; NaN 4 5];

assert(smartcumsum(X, 1)==[0 1 2; 0 5 7]);
