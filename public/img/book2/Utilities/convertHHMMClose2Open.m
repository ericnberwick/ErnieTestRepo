function [ hhmm_open ] = convertHHMMClose2Open( hhmm_close )
%[ hhmm_open ] = convertHHMMClose2Open( hhmm_close )
%   Convert 1201 to 1200, 1199 to 1159, etc.

hhmm_open=hhmm_close-1;
idx=hhmm_open+1==round((hhmm_open+1)/100)*100;
hhmm_open(idx)=hhmm_open(idx)-40;
idx=hhmm_open<0;
hhmm_open(idx)=2300+hhmm_open(idx)+100;


end

