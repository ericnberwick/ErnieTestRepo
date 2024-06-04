function [ oldFrontContract ] = getPrevContract( frontContract)
% [ oldFrontContract ] = getPrevContract( frontContract)
% Get contract just expired.
monthsSym={'F', 'G', 'H', 'J', 'K', 'M', 'N', 'Q', 'U', 'V', 'X', 'Z'};

frontContractM=frontContract(1);
contractY=str2double(frontContract(2));
M=find(strcmp(frontContractM, monthsSym));

if (M==1)
    oldFrontContract=['Z', num2str(mod(contractY-1, 10))];
else
    oldFrontContract=[monthsSym{M-1}, num2str(contractY)];
end

end

