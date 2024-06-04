foo=randn(3)

foo2=numcell2str(foo)

assert(all(size(foo2)==[3 3]));
