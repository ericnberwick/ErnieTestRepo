function y=reverse(x)
% y=reverse(x) is same as y=x(end:-1:1);
sz=size(x);
if (sz(2)== 1)
    y=x(end:-1:1);
else
    y=x(:, end:-1:1);
end

