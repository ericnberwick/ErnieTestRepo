clear;

cellarr={'A', 'B_1', 'B_2', 'C'};
idx=strnotcontain('_', cellarr);

assert(all([1 4]==idx));
