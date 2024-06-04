x=[1 2 3 8 -9];
y=reverse(x);

assert(all(y==[-9 8 3 2 1]));

x=[1 2 3 8 -9;
   3 4 2 2 1];

y=reverse(x);

assert(all(y==[-9 8 3 2 1; 1 2 2 4 3]));
    