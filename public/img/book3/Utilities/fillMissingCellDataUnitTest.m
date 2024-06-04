clear;

x={'1' '1' 'NaN';
   'NaN' 'NaN' '2';
   '3'   'NaN'   '5'};

y=fillMissingCellData(x);

z={    '1'    '1'     'NaN';
     '1'     '1'     '2';
     '3'     '1'     '5'};
 
assert(all(all(strcmp(y, z))));


