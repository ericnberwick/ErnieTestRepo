function y = mysoftall(x, dim, tol)
% y=mysoftall(x, dim, tol) is similar to all(x, dim), except it tolerates a number tol of x ~= 0

assert(tol>=0 & tol<=size(x, dim));

if (dim==1)
    xx=x';
elseif (dim==2)
    xx=x;
else
    assert(0, 'dim must be 1 or 2!');
end

y=zeros(size(xx, 1), 1);

tot=size(xx, 2)-tol;

for i=1:size(xx, 1)
    hits=find(xx(i, :));
    y(i)=length(hits) >= tot;
end

if (dim==1)
    y=y';
end
