function out = intconcat (x)

% input is double array
% Out1 is char array

[s1,s2]=size(x);

out = char(zeros(s1,(s2*3)));

for j = 1:s1
    out_temp = [];
    for k = 1:s2
        temp = x(j,k);
        temp2 = num2str(temp);
        if length(temp2) == 2
            temp2 = ['0' temp2];
        elseif length(temp2) == 1
            temp2 = ['0' '0' temp2];
        end
        out_temp = [out_temp temp2];       
    end
    out(j,:) = out_temp;
end

