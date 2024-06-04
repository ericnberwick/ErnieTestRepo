function myRsi = SRSI( cl, x )
%myRsi = SRSI( cl, x )
% smoothed RSI from Joe Duffy

momentum=cl-backshift(1, cl);

myRS=smartMovingSum(momentum, x)./smartMovingSum(abs(momentum), x);
myRsi=(myRS*100+100)/2;

end

