function res=lognchoosek(c, n)
% res=lognchoosek(c, n) is log of nchoosek(c, n)

% res=log(factorial(c))-log(factorial(c-n))-log(factorial(n));
% res=c*log(c) - c - ((c-n)*log(c-n)-(c-n)) - (n*log(n) - n); 


if c>= 100
	facc=c*log(c) - c;
else
	facc=log(factorial(c));
end

if c-n >= 100
	faccn=(c-n)*log(c-n)-(c-n);
else
	faccn=log(factorial(c-n));
end

if n >= 100
	facn=n*log(n) - n;
else
	facn=log(factorial(n));
end

res=facc-faccn-facn;

