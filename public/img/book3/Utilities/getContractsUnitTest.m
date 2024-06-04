clear;

allcontracts=getContracts('J2', 12);
assert(all(strcmp(allcontracts, {'J2'; 'K2'; 'M2'; 'N2'; 'Q2'; 'U2'; 'V2'; 'X2'; 'Z2'; 'F3'; 'G3'; 'H3'}))); 

allcontracts=getContracts('Z9', 12);
assert(all(strcmp(allcontracts, {'Z9'; 'F0'; 'G0'; 'H0'; 'J0'; 'K0'; 'M0'; 'N0'; 'Q0'; 'U0'; 'V0'; 'X0'; }))); 