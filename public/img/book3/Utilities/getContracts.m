function [ contracts ] = getContracts( frontContract, maxMonths )
% [ contracts ] = getContracts( frontContract, maxMonths )
% Find all months contracts starting with front month, up to a total of
% maxMonths

frontContractM=frontContract(1);
contractY=str2double(frontContract(2));

monthsSym={'F', 'G', 'H', 'J', 'K', 'M', 'N', 'Q', 'U', 'V', 'X', 'Z'};

M=find(strcmp(frontContractM, monthsSym));
contracts=cell(maxMonths, 1);
for m=1:maxMonths
    if (M<=12)
        contracts{m}=[monthsSym{M}, num2str(contractY)];
        M=M+1;
    else
        M=1;
        contractY=rem(contractY+1, 10);
        contracts{m}=[monthsSym{M}, num2str(contractY)];
        M=M+1;
    end
end

end

