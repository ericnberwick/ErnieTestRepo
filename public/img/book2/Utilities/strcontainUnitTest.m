clear;

cellarr={'A', 'B_1', 'B_2', 'C'};
idx=strcontain('_', cellarr);

assert(all([2; 3]==idx));
