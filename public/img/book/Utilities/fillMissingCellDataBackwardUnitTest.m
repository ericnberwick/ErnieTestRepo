clear;

x={'NaN' '1' 'NaN';
   'NaN' 'NaN' '2';
   '3'   '4'   '5'};

y=fillMissingCellDataBackward(x);

z={    '3'    '1'     '2';
     '3'     '4'     '2';
     '3'     '4'     '5'};
 
assert(all(all(strcmp(y, z))));


