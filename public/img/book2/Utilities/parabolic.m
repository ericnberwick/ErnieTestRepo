function sar=parabolic(hi, lo,  initAlpha, maxAlpha)
% sar=parabolic(hi, lo, initAlpha, maxAlpha)

assert(size(hi, 2)==1);

sar=NaN(size(hi));

trend=0;
alpha=initAlpha;
ep=0;

for t=3:size(sar, 1)
	if (trend==0)
		if (hi(t) > hi(t-1) && lo(t) > lo(t-1))
			trend=1;
			sar(t)=min(lo(t-1), lo(t-2));
			ep=hi(t);
			epNew=ep;
		elseif (hi(t) < hi(t-1) && lo(t) < lo(t-1))
			trend=-1;
			sar(t)=max(hi(t-1), hi(t-2));
			ep=lo(t);
			epNew=ep;
		end
	
		continue;
	elseif (trend > 0)
		epNew=max(ep, hi(t));
	else
		epNew=min(ep, lo(t));
	end
		
	sar(t)=sar(t-1)+alpha*(ep-sar(t-1));
	
	if (epNew~=ep)
		alpha=min(alpha+initAlpha, maxAlpha);
		ep=epNew;
	end
	
	
	if (trend > 0 & sar(t) > min(lo(t-1), lo(t-2)))
		sar(t)=min(lo(t-1), lo(t-2));
	elseif (trend < 0 & sar(t) < max(hi(t-1), hi(t-2)))
		sar(t)=max(hi(t-1), hi(t-2));
	end
	
	if (trend > 0 & sar(t) > lo(t))
		trend=-1;
		sar(t)=ep;
		ep=lo(t);
		alpha=initAlpha;
	elseif (trend < 0 & sar(t) < hi(t))
		trend=1;
		sar(t)=ep;
		ep=hi(t);
		alpha=initAlpha;
	end
end