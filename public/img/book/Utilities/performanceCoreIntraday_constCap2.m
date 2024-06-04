% defragment memory
cwd = pwd;
cd(tempdir);
pack;
cd(cwd);

ret=NaN(size(my_cls));
for h=2:size(my_cls, 3)
    ret(:, :, h)=(my_cls(:, :, h)-my_cls(:, :, h-1))./my_cls(:, :, h-1); % Past period return
end
ret(:, :, 1) = (my_cls(:, :, 1)-backshift(1, my_cls(:, :, end)))./backshift(1, my_cls(:, :, end)); % Future overnight return

ret(~isfinite(ret))=0;


if (~isAdjustSharesDaily)
    positionTableAdj=positionTable;
    for d=1:size(positionTable, 1)
        if (d>1)
            positionTableAdj(d, :, 1)=positionTableAdj(d-1, :, end).*(1+ret(d, :, end));
            constPos=abs((positionTable(d, :, 1)-positionTable(d-1, :, end)))<1e-5;
            positionTableAdj(d, ~constPos, 1)=positionTable(d, ~constPos, 1);
        end

        for h=2:size(positionTable, 3)
            positionTableAdj(d, :, h)=positionTableAdj(d, :, h-1).*(1+ret(d, :, h));
            constPos=abs((positionTable(d, :, h)-positionTable(d, :, h-1)))<1e-5;
            positionTableAdj(d, ~constPos, h)=positionTable(d, ~constPos, h);
        end
    end

    positionTable=positionTableAdj;
end

clear constPos positionTableAdj;
positionTable0=backshift(1, positionTable); % yesterday's position

positionTable0(1, :, :)=0;

pnlstk=zeros(size(positionTable(:, :, 1)));

for h=2:size(positionTable, 3)
    pnlstk=pnlstk+positionTable(:, :, h-1).* ret(:, :, h);
end

pnl=smartsum(pnlstk, 2);
clear pnlstk;


pnl(1,:)=0;
assert(all(isfinite(pnl))); 

cumpnl=cumsum(pnl);

% capital=smartsum(abs(positionTable(:, :, end)), 2);
capitalhour=0;
for s=1:size(positionTable, 2)
    capitalhour=capitalhour+abs(positionTable(:, s, :));
end
capital=max(capitalhour, [], 3);
clear capitalhour;
capital(capital==0)=NaN;
delta=smartsum(positionTable(:, :, end), 2);
ratio=delta./smartsum(abs(positionTable(:, :, end)), 2);

if (size(capital, 1)>=126)
	avgcapital126=smartMovingAvg(capital, 126);
	avgcapital126(1:125)=smartmean(avgcapital126(1:126));
else
	avgcapital126=repmat(smartmean(capital, 1), [size(capital, 1) 1]);
end

avgret=252*smartmean(pnl./avgcapital126);
sharpe=sqrt(252)*smartmean(pnl./avgcapital126)/smartstd(pnl./avgcapital126);
negpnl=pnl;
negpnl(pnl>0)=NaN;
negpnl(~isfinite(avgcapital126))=NaN;
sortino=sqrt(252)*smartmean(pnl./avgcapital126)/sqrt(smartsum((negpnl./avgcapital126).^2)/(length(find(negpnl<0))-1));

d1998=find(tday >= 19980000 & tday <= 19989999 & tday >= startdate & tday <= enddate);
d1999=find(tday >= 19990000 & tday <= 19999999 & tday >= startdate & tday <= enddate);
d2000=find(tday >= 20000000 & tday <= 20009999 & tday >= startdate & tday <= enddate);
d2001=find(tday >= 20010000 & tday <= 20019999 & tday >= startdate & tday <= enddate);
d2002=find(tday >= 20020000 & tday <= 20029999 & tday >= startdate & tday <= enddate);
d2003=find(tday >= 20030000 & tday <= 20039999 & tday >= startdate & tday <= enddate);
d2004=find(tday >= 20040000 & tday <= 20049999 & tday >= startdate & tday <= enddate);
d2005=find(tday >= 20050000 & tday <= 20059999 & tday >= startdate & tday <= enddate);
d2006=find(tday >= 20060000 & tday <= 20069999 & tday >= startdate & tday <= enddate);
d2007=find(tday >= 20070000 & tday <= 20079999 & tday >= startdate & tday <= enddate);


fprintf(fid, '%s %f\n', 'investment', investment);
fprintf(fid, '%s %f\n', 'onewaytcost', onewaytcost);
fprintf(fid, '%s %f\n', 'slippage', slippage);
% fprintf(fid, '%s %i\n', 'dollarPerPos', dollarPerPos);
fprintf(fid, '%s %f\n', 'costPerShareTraded', costPerShareTraded);
fprintf(fid, '%s %f\n', 'mgmtFee', mgmtFee);
fprintf(fid, '%s %f\n', 'incentiveFee', incentiveFee);
fprintf(fid, '%s %f\n', 'financeCharge', financeCharge);
fprintf(fid, '%s %f\n', 'shortRebate', shortRebate);

fprintf(fid, 'No cost:\n');
fprintf(fid, '%18s%10s%10s%10s%10s\n', ' ', 'Avgret', 'Sharpe', 'Sortino', 'winratio');
if (length(d1998)>0)
	fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d1998(1)), tday(d1998(end)), 252*smartmean(pnl(d1998)./avgcapital126(d1998)), sqrt(252)*smartmean(pnl(d1998)./avgcapital126(d1998))/smartstd(pnl(d1998)./avgcapital126(d1998)), sqrt(252)*smartmean(pnl(d1998)./avgcapital126(d1998))/sqrt(smartsum((negpnl(d1998)./avgcapital126(d1998)).^2)/(length(find(negpnl(d1998)<0))-1)), length(find(pnl(d1998)>0))/length(d1998));
end
if (length(d1999)>0)
	fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d1999(1)), tday(d1999(end)), 252*smartmean(pnl(d1999)./avgcapital126(d1999)), sqrt(252)*smartmean(pnl(d1999)./avgcapital126(d1999))/smartstd(pnl(d1999)./avgcapital126(d1999)), sqrt(252)*smartmean(pnl(d1999)./avgcapital126(d1999))/sqrt(smartsum((negpnl(d1999)./avgcapital126(d1999)).^2)/(length(find(negpnl(d1999)<0))-1)), length(find(pnl(d1999)>0))/length(d1999));
end
if (length(d2000)>0)
	fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d2000(1)), tday(d2000(end)), 252*smartmean(pnl(d2000)./avgcapital126(d2000)), sqrt(252)*smartmean(pnl(d2000)./avgcapital126(d2000))/smartstd(pnl(d2000)./avgcapital126(d2000)), sqrt(252)*smartmean(pnl(d2000)./avgcapital126(d2000))/sqrt(smartsum((negpnl(d2000)./avgcapital126(d2000)).^2)/(length(find(negpnl(d2000)<0))-1)), length(find(pnl(d2000)>0))/length(d2000));
end
if (length(d2001)>0)
	fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d2001(1)), tday(d2001(end)), 252*smartmean(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/smartstd(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/sqrt(smartsum((negpnl(d2001)./avgcapital126(d2001)).^2)/(length(find(negpnl(d2001)<0))-1)), length(find(pnl(d2001)>0))/length(d2001));
end
if (length(d2002)>0)
	fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d2002(1)), tday(d2002(end)), 252*smartmean(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/smartstd(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/sqrt(smartsum((negpnl(d2002)./avgcapital126(d2002)).^2)/(length(find(negpnl(d2002)<0))-1)), length(find(pnl(d2002)>0))/length(d2002));
end
if (length(d2003)>0)
	fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d2003(1)), tday(d2003(end)), 252*smartmean(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/smartstd(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/sqrt(smartsum((negpnl(d2003)./avgcapital126(d2003)).^2)/(length(find(negpnl(d2003)<0))-1)), length(find(pnl(d2003)>0))/length(d2003));
end
if (length(d2004)>0)
	fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d2004(1)), tday(d2004(end)), 252*smartmean(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/smartstd(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/sqrt(smartsum((negpnl(d2004)./avgcapital126(d2004)).^2)/(length(find(negpnl(d2004)<0))-1)), length(find(pnl(d2004)>0))/length(d2004));
end
if (length(d2005)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), 252*smartmean(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/smartstd(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/sqrt(smartsum((negpnl(d2005)./avgcapital126(d2005)).^2)/(length(find(negpnl(d2005)<0))-1)), length(find(pnl(d2005)>0))/length(d2005));
end
if (length(d2006)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/length(d2006));
end
if (length(d2007)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f\n', tday(d2007(1)), tday(d2007(end)), 252*smartmean(pnl(d2007)./avgcapital126(d2007)), sqrt(252)*smartmean(pnl(d2007)./avgcapital126(d2007))/smartstd(pnl(d2007)./avgcapital126(d2007)), sqrt(252)*smartmean(pnl(d2007)./avgcapital126(d2007))/sqrt(smartsum((negpnl(d2007)./avgcapital126(d2007)).^2)/(length(find(negpnl(d2007)<0))-1)), length(find(pnl(d2007)>0))/length(d2007));
end

if (length(d1998)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d1998(1)), enddate, avgret, sharpe, sortino);
elseif (length(d1999)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d1999(1)), enddate, avgret, sharpe, sortino);
elseif (length(d2000)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d2000(1)), enddate, avgret, sharpe, sortino);
elseif (length(d2001)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d2001(1)), enddate, avgret, sharpe, sortino);
elseif (length(d2002)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d2002(1)), enddate, avgret, sharpe, sortino);
elseif (length(d2003)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d2003(1)), enddate, avgret, sharpe, sortino);
elseif (length(d2004)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d2004(1)), enddate, avgret, sharpe, sortino);
elseif (length(d2005)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d2005(1)), enddate, avgret, sharpe, sortino);
elseif (length(d2006)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d2006(1)), enddate, avgret, sharpe, sortino);
elseif (length(d2007)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f\n', tday(d2007(1)), enddate, avgret, sharpe, sortino);
end

figure;
subplot(3, 1, 1);
plot(cumsum(pnl), 'g');

monthFirst={};
monthFirstIdx=[];

if (length(d1998)>0)
    monthFirst={'19980102'};
elseif (length(d1999)>0)
    monthFirst={'19990104'};
elseif (length(d2000)>0)
    monthFirst={'20000104'};
elseif (length(d2001)>0)
    monthFirst={'20010102'};
elseif (length(d2002)>0)
    monthFirst={'20020102'};
elseif (length(d2003)>0)
    monthFirst={'20030102'};
elseif (length(d2004)>0)
    monthFirst={'20040102'};
elseif (length(d2005)>0)
	monthFirst={'20050103'};
elseif (length(d2006)>0)
	monthFirst={'20060103'};
    % monthFirst={'20060614'};
elseif (length(d2007)>0)
	monthFirst={'20070103'};
end

monthFirstIdx(1)=find(tday==str2num(monthFirst{1}));

lastMonth=num2str(startdate);
lastMonth=lastMonth(5:6);

for i=monthFirstIdx+1:length(tday)
  curMonth=num2str(tday(i));
  curMonth=curMonth(5:6);
  if (~strcmp(lastMonth, curMonth))
    if (strcmp(curMonth, '04')|strcmp(curMonth, '07')|strcmp(curMonth, '10'))
      monthFirst{end+1}='';   
      monthFirstIdx(end+1)=i;
    elseif (strcmp(curMonth, '01'))
      monthFirst{end+1}=num2str(tday(i));
      monthFirstIdx(end+1)=i;
    end
    lastMonth=curMonth;
  end
end


set(gca, 'xtick', monthFirstIdx);
grid on;
set(gca, 'XTickLabel', monthFirst);

hold on;

% with cost
numTradesStk=0;
for h=2:size(positionTable, 3)
    numTradesHr=(abs(positionTable(:, :, h)./my_cls(:, :, h)-positionTable(:, :, h-1)./my_cls(:, :, h-1))).*my_cls(:, :,h);
    numTradesHr(~isfinite(numTradesHr))=0;
    numTradesStk=numTradesStk+numTradesHr;
end
clear numTradesHr;

numTrades=smartsum((abs(positionTable(:, :, 1)./my_cls(:, :, 1)-positionTable0(:, :, end)./backshift(1, my_cls(:, :, end)))).*my_cls(:, :, 1), 2) + ...
    smartsum(numTradesStk, 2);
clear numTradesStk;
numTrades(1)=smartsum(abs(positionTable(1, :, 1)), 2) + smartsum(smartsum((abs(positionTable(1, :, 2:end)./my_cls(1, :, 2:end)-positionTable(1, :, 1:end-1)./my_cls(1, :, 1:end-1))).*my_cls(1, :, 2:end), 3), 2);

 

numTrades(~isfinite(numTrades))=0;

% positions in num shares
% poss=positionTable./my_cls;
% poss0=positionTable0./backshift(1, my_cls);
poss0=zeros(size(positionTable, 1), size(positionTable, 2));

for t=2:size(poss0, 1)
    poss0(t, :)=positionTable0(t, :, end)./my_cls(t-1, :, end);
end

clear positionTable0;

poss0(1, :)=0;

tradesd=NaN(size(ret));

% for t=1:size(poss, 1)
%     for h=2:size(poss, 3)
%         for s=1:size(tradesd, 2)
%             tradesd(t, s, h)=abs(poss(t, s, h)-poss(t, s, h-1)).*my_cls(t, s, h);
%         end
%     end
% end
% poss=positionTable./my_cls;

for h=2:size(positionTable, 3)
    tradesd(:, :, h)=abs(positionTable(:, :, h)./my_cls(:, :, h)-positionTable(:, :, h-1)./my_cls(:, :, h-1)).*my_cls(:, :, h);
end

tradesd(:, :, 1)=abs(positionTable(:, :, 1)./my_cls(:, :, 1)-poss0).*my_cls(:, :, 1);


tradess=tradesd;
clear tradesd;
costSlip=slippage*abs(tradess); % cost due to slippage

for h=2:size(positionTable, 3)
    tradess(:, :, h)=abs(positionTable(:, :, h)./my_cls(:, :, h)-positionTable(:, :, h-1)./my_cls(:, :, h-1));
end
tradess(:, :, 1)=abs(positionTable(:, :, 1)./my_cls(:, :, 1)-poss0);
clear poss poss0 my_cls;

costTrans=costPerShareTraded*abs(tradess);


cumpnl=smartcumsum(pnl);
cumnumTrades=smartcumsum(numTrades);

% clear pnl;

% pnl = smartsum(smartsum(positionTable .* retFut1, 3), 2);
pnl = pnl - onewaytcost*numTrades; 
numTrades(end)=[];


assert(all(isfinite(pnl))); 

% pnld=squeeze(smartsum(positionTable(:, :, 1:end-1).*retFut1(:, :, 1:end-1) - costSlip(:, :, 2:end) - costTrans(:, :, 2:end), 2)); % pnl after slippage and transactions
pnld=zeros(size(positionTable, 1), 1, size(positionTable, 3)-1);
for s=1:size(positionTable, 2)
    pnld_s=positionTable(:, s, 1:end-1).*ret(:, s, 2:end) - costSlip(:, s, 2:end) - costTrans(:, s,  2:end);
    pnld_s(~isfinite(pnld_s))=0;
    pnld(:, 1, :)=pnld(:, 1, :)+pnld_s;
end
clear pnld_s;
pnld=squeeze(pnld);


positionTable0=backshift(1, positionTable); % yesterday's position
positionTable0(1, :, :)=0;

pnld(:, end+1)=smartsum(positionTable0(:, :, end).*ret(:, :, end) - costSlip(:, :, 1) - costTrans(:, :, 1), 2);
clear ret  positionTable0;
pnld=smartsum(pnld, 2);



posdL=positionTable;
posdL(posdL < 0)=0;
LMV=smartsum(posdL, 2);
clear posdL;

posdS=positionTable;
posdS(posdS > 0)=0;
SMV=smartsum(posdS, 2);
clear posdS;

% financeCharge=0.5*(LMV+abs(SMV))*debitCreditSpd/12;


avgret=252*smartmean(pnl./avgcapital126);
sharpe=sqrt(252)*smartmean(pnl./avgcapital126)/smartstd(pnl./avgcapital126);
negpnl=pnl;
negpnl(pnl>0)=0;
negpnl(~isfinite(avgcapital126))=NaN;

sortino=sqrt(252)*smartmean(pnl./avgcapital126)/sqrt(smartsum((negpnl./avgcapital126).^2)/(length(find(negpnl<0))-1));

fprintf(fid, 'Onewaytcost=%f\n', onewaytcost);

fprintf(fid, '%18s%10s%10s%10s%10s%10s%10s\n', ' ', 'Avgret', 'Sharpe', 'Sortino', 'winratio', 'breakeven', 'Avg cap'); 

if (length(d1998)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d1998(1)), tday(d1998(end)), 252*smartmean(pnl(d1998)./avgcapital126(d1998)), sqrt(252)*smartmean(pnl(d1998)./avgcapital126(d1998))/smartstd(pnl(d1998)./avgcapital126(d1998)), sqrt(252)*smartmean(pnl(d1998)./avgcapital126(d1998))/sqrt(smartsum((negpnl(d1998)./avgcapital126(d1998)).^2)/(length(find(negpnl(d1998)<0))-1)), length(find(pnl(d1998)>0))/252, 1e4*cumpnl(d1998(end))/cumnumTrades(d1998(end)), smartmean(capital(d1998)));

	if (length(d1999)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d1999(1)), tday(d1999(end)), 252*smartmean(pnl(d1999)./avgcapital126(d1999)), sqrt(252)*smartmean(pnl(d1999)./avgcapital126(d1999))/smartstd(pnl(d1999)./avgcapital126(d1999)), sqrt(252)*smartmean(pnl(d1999)./avgcapital126(d1999))/sqrt(smartsum((negpnl(d1999)./avgcapital126(d1999)).^2)/(length(find(negpnl(d1999)<0))-1)), length(find(pnl(d1999)>0))/length(d1999), 1e4*(cumpnl(d1999(end))-cumpnl(d1998(end)))/(cumnumTrades(d1999(end))-cumnumTrades(d1998(end))), smartmean(capital(d1999)));
	end
	if (length(d2000)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2000(1)), tday(d2000(end)), 252*smartmean(pnl(d2000)./avgcapital126(d2000)), sqrt(252)*smartmean(pnl(d2000)./avgcapital126(d2000))/smartstd(pnl(d2000)./avgcapital126(d2000)), sqrt(252)*smartmean(pnl(d2000)./avgcapital126(d2000))/sqrt(smartsum((negpnl(d2000)./avgcapital126(d2000)).^2)/(length(find(negpnl(d2000)<0))-1)), length(find(pnl(d2000)>0))/length(d2000), 1e4*(cumpnl(d2000(end))-cumpnl(d1999(end)))/(cumnumTrades(d2000(end))-cumnumTrades(d1999(end))), smartmean(capital(d2000)));
	end
	if (length(d2001)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2001(1)), tday(d2001(end)), 252*smartmean(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/smartstd(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/sqrt(smartsum((negpnl(d2001)./avgcapital126(d2001)).^2)/(length(find(negpnl(d2001)<0))-1)), length(find(pnl(d2001)>0))/length(d2001), 1e4*(cumpnl(d2001(end))-cumpnl(d2000(end)))/(cumnumTrades(d2001(end))-cumnumTrades(d2000(end))), smartmean(capital(d2001)));
	end
	if (length(d2002)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2002(1)), tday(d2002(end)), 252*smartmean(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/smartstd(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/sqrt(smartsum((negpnl(d2002)./avgcapital126(d2002)).^2)/(length(find(negpnl(d2002)<0))-1)), length(find(pnl(d2002)>0))/length(d2002), 1e4*(cumpnl(d2002(end))-cumpnl(d2001(end)))/(cumnumTrades(d2002(end))-cumnumTrades(d2001(end))), smartmean(capital(d2002)));
	end
	if (length(d2003)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2003(1)), tday(d2003(end)), 252*smartmean(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/smartstd(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/sqrt(smartsum((negpnl(d2003)./avgcapital126(d2003)).^2)/(length(find(negpnl(d2003)<0))-1)), length(find(pnl(d2003)>0))/length(d2003), 1e4*(cumpnl(d2003(end))-cumpnl(d2002(end)))/(cumnumTrades(d2003(end))-cumnumTrades(d2002(end))), smartmean(capital(d2003)));
	end
	if (length(d2004)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2004(1)), tday(d2004(end)), 252*smartmean(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/smartstd(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/sqrt(smartsum((negpnl(d2004)./avgcapital126(d2004)).^2)/(length(find(negpnl(d2004)<0))-1)), length(find(pnl(d2004)>0))/length(d2004), 1e4*(cumpnl(d2004(end))-cumpnl(d2003(end)))/(cumnumTrades(d2004(end))-cumnumTrades(d2003(end))), smartmean(capital(d2004)));
	end
	if (length(d2005)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), 252*smartmean(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/smartstd(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/sqrt(smartsum((negpnl(d2005)./avgcapital126(d2005)).^2)/(length(find(negpnl(d2005)<0))-1)), length(find(pnl(d2005)>0))/length(d2005), 1e4*(cumpnl(d2005(end))-cumpnl(d2004(end)))/(cumnumTrades(d2005(end))-cumnumTrades(d2004(end))), smartmean(capital(d2005)));
    end
    if (length(d2006)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/length(d2006), 1e4*(cumpnl(d2006(end))-cumpnl(d2004(end)))/(cumnumTrades(d2006(end))-cumnumTrades(d2004(end))), smartmean(capital(d2006)));
	end

	fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d1998(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
elseif (length(d1999)>0)
	fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d1999(1)), tday(d1999(end)), 252*smartmean(pnl(d1999)./avgcapital126(d1999)), sqrt(252)*smartmean(pnl(d1999)./avgcapital126(d1999))/smartstd(pnl(d1999)./avgcapital126(d1999)), sqrt(252)*smartmean(pnl(d1999)./avgcapital126(d1999))/sqrt(smartsum((negpnl(d1999)./avgcapital126(d1999)).^2)/(length(find(negpnl(d1999)<0))-1)), length(find(pnl(d1999)>0))/252, 1e4*cumpnl(d1999(end))/cumnumTrades(d1999(end)), smartmean(capital(d1999)));
  
	if (length(d2000)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2000(1)), tday(d2000(end)), 252*smartmean(pnl(d2000)./avgcapital126(d2000)), sqrt(252)*smartmean(pnl(d2000)./avgcapital126(d2000))/smartstd(pnl(d2000)./avgcapital126(d2000)), sqrt(252)*smartmean(pnl(d2000)./avgcapital126(d2000))/sqrt(smartsum((negpnl(d2000)./avgcapital126(d2000)).^2)/(length(find(negpnl(d2000)<0))-1)), length(find(pnl(d2000)>0))/length(d2000), 1e4*(cumpnl(d2000(end))-cumpnl(d1999(end)))/(cumnumTrades(d2000(end))-cumnumTrades(d1999(end))), smartmean(capital(d2000)));
	end
	if (length(d2001)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2001(1)), tday(d2001(end)), 252*smartmean(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/smartstd(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/sqrt(smartsum((negpnl(d2001)./avgcapital126(d2001)).^2)/(length(find(negpnl(d2001)<0))-1)), length(find(pnl(d2001)>0))/length(d2001), 1e4*(cumpnl(d2001(end))-cumpnl(d2000(end)))/(cumnumTrades(d2001(end))-cumnumTrades(d2000(end))), smartmean(capital(d2001)));
	end
	if (length(d2002)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2002(1)), tday(d2002(end)), 252*smartmean(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/smartstd(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/sqrt(smartsum((negpnl(d2002)./avgcapital126(d2002)).^2)/(length(find(negpnl(d2002)<0))-1)), length(find(pnl(d2002)>0))/length(d2002), 1e4*(cumpnl(d2002(end))-cumpnl(d2001(end)))/(cumnumTrades(d2002(end))-cumnumTrades(d2001(end))), smartmean(capital(d2002)));
	end
	if (length(d2003)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2003(1)), tday(d2003(end)), 252*smartmean(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/smartstd(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/sqrt(smartsum((negpnl(d2003)./avgcapital126(d2003)).^2)/(length(find(negpnl(d2003)<0))-1)), length(find(pnl(d2003)>0))/length(d2003), 1e4*(cumpnl(d2003(end))-cumpnl(d2002(end)))/(cumnumTrades(d2003(end))-cumnumTrades(d2002(end))), smartmean(capital(d2003)));
	end
	if (length(d2004)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2004(1)), tday(d2004(end)), 252*smartmean(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/smartstd(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/sqrt(smartsum((negpnl(d2004)./avgcapital126(d2004)).^2)/(length(find(negpnl(d2004)<0))-1)), length(find(pnl(d2004)>0))/length(d2004), 1e4*(cumpnl(d2004(end))-cumpnl(d2003(end)))/(cumnumTrades(d2004(end))-cumnumTrades(d2003(end))), smartmean(capital(d2004)));
	end
	if (length(d2005)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), 252*smartmean(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/smartstd(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/sqrt(smartsum((negpnl(d2005)./avgcapital126(d2005)).^2)/(length(find(negpnl(d2005)<0))-1)), length(find(pnl(d2005)>0))/length(d2005), 1e4*(cumpnl(d2005(end))-cumpnl(d2004(end)))/(cumnumTrades(d2005(end))-cumnumTrades(d2004(end))), smartmean(capital(d2005)));
    end
    if (length(d2006)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/length(d2006), 1e4*(cumpnl(d2006(end))-cumpnl(d2004(end)))/(cumnumTrades(d2006(end))-cumnumTrades(d2004(end))), smartmean(capital(d2006)));
	end

    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d1999(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
elseif (length(d2000)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2000(1)), tday(d2000(end)), 252*smartmean(pnl(d2000)./avgcapital126(d2000)), sqrt(252)*smartmean(pnl(d2000)./avgcapital126(d2000))/smartstd(pnl(d2000)./avgcapital126(d2000)), sqrt(252)*smartmean(pnl(d2000)./avgcapital126(d2000))/sqrt(smartsum((negpnl(d2000)./avgcapital126(d2000)).^2)/(length(find(negpnl(d2000)<0))-1)), length(find(pnl(d2000)>0))/252, 1e4*cumpnl(d2000(end))/cumnumTrades(d2000(end)), smartmean(capital(d2000)));
    
	if (length(d2001)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2001(1)), tday(d2001(end)), 252*smartmean(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/smartstd(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/sqrt(smartsum((negpnl(d2001)./avgcapital126(d2001)).^2)/(length(find(negpnl(d2001)<0))-1)), length(find(pnl(d2001)>0))/length(d2001), 1e4*(cumpnl(d2001(end))-cumpnl(d2000(end)))/(cumnumTrades(d2001(end))-cumnumTrades(d2000(end))), smartmean(capital(d2001)));
	end
	if (length(d2002)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2002(1)), tday(d2002(end)), 252*smartmean(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/smartstd(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/sqrt(smartsum((negpnl(d2002)./avgcapital126(d2002)).^2)/(length(find(negpnl(d2002)<0))-1)), length(find(pnl(d2002)>0))/length(d2002), 1e4*(cumpnl(d2002(end))-cumpnl(d2001(end)))/(cumnumTrades(d2002(end))-cumnumTrades(d2001(end))), smartmean(capital(d2002)));
	end
	if (length(d2003)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2003(1)), tday(d2003(end)), 252*smartmean(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/smartstd(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/sqrt(smartsum((negpnl(d2003)./avgcapital126(d2003)).^2)/(length(find(negpnl(d2003)<0))-1)), length(find(pnl(d2003)>0))/length(d2003), 1e4*(cumpnl(d2003(end))-cumpnl(d2002(end)))/(cumnumTrades(d2003(end))-cumnumTrades(d2002(end))), smartmean(capital(d2003)));
	end
	if (length(d2004)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2004(1)), tday(d2004(end)), 252*smartmean(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/smartstd(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/sqrt(smartsum((negpnl(d2004)./avgcapital126(d2004)).^2)/(length(find(negpnl(d2004)<0))-1)), length(find(pnl(d2004)>0))/length(d2004), 1e4*(cumpnl(d2004(end))-cumpnl(d2003(end)))/(cumnumTrades(d2004(end))-cumnumTrades(d2003(end))), smartmean(capital(d2004)));
	end
	if (length(d2005)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), 252*smartmean(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/smartstd(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/sqrt(smartsum((negpnl(d2005)./avgcapital126(d2005)).^2)/(length(find(negpnl(d2005)<0))-1)), length(find(pnl(d2005)>0))/length(d2005), 1e4*(cumpnl(d2005(end))-cumpnl(d2004(end)))/(cumnumTrades(d2005(end))-cumnumTrades(d2004(end))), smartmean(capital(d2005)));
	end
    if (length(d2006)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/length(d2006), 1e4*(cumpnl(d2006(end))-cumpnl(d2005(end)))/(cumnumTrades(d2006(end))-cumnumTrades(d2005(end))), smartmean(capital(d2006)));
	end
    if (length(d2007)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2007(1)), tday(d2007(end)), 252*smartmean(pnl(d2007)./avgcapital126(d2007)), sqrt(252)*smartmean(pnl(d2007)./avgcapital126(d2007))/smartstd(pnl(d2007)./avgcapital126(d2007)), sqrt(252)*smartmean(pnl(d2007)./avgcapital126(d2007))/sqrt(smartsum((negpnl(d2007)./avgcapital126(d2007)).^2)/(length(find(negpnl(d2007)<0))-1)), length(find(pnl(d2007)>0))/length(d2007), 1e4*(cumpnl(d2007(end))-cumpnl(d2006(end)))/(cumnumTrades(d2006(end))-cumnumTrades(d2006(end))), smartmean(capital(d2007)));
	end

    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d2000(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
elseif (length(d2001)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2001(1)), tday(d2001(end)), 252*smartmean(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/smartstd(pnl(d2001)./avgcapital126(d2001)), sqrt(252)*smartmean(pnl(d2001)./avgcapital126(d2001))/sqrt(smartsum((negpnl(d2001)./avgcapital126(d2001)).^2)/(length(find(negpnl(d2001)<0))-1)), length(find(pnl(d2001)>0))/252, 1e4*cumpnl(d2001(end))/cumnumTrades(d2001(end)), smartmean(capital(d2001)));
    
	if (length(d2002)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2002(1)), tday(d2002(end)), 252*smartmean(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/smartstd(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/sqrt(smartsum((negpnl(d2002)./avgcapital126(d2002)).^2)/(length(find(negpnl(d2002)<0))-1)), length(find(pnl(d2002)>0))/length(d2002), 1e4*(cumpnl(d2002(end))-cumpnl(d2001(end)))/(cumnumTrades(d2002(end))-cumnumTrades(d2001(end))), smartmean(capital(d2002)));
	end
	if (length(d2003)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2003(1)), tday(d2003(end)), 252*smartmean(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/smartstd(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/sqrt(smartsum((negpnl(d2003)./avgcapital126(d2003)).^2)/(length(find(negpnl(d2003)<0))-1)), length(find(pnl(d2003)>0))/length(d2003), 1e4*(cumpnl(d2003(end))-cumpnl(d2002(end)))/(cumnumTrades(d2003(end))-cumnumTrades(d2002(end))), smartmean(capital(d2003)));
	end
	if (length(d2004)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2004(1)), tday(d2004(end)), 252*smartmean(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/smartstd(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/sqrt(smartsum((negpnl(d2004)./avgcapital126(d2004)).^2)/(length(find(negpnl(d2004)<0))-1)), length(find(pnl(d2004)>0))/length(d2004), 1e4*(cumpnl(d2004(end))-cumpnl(d2003(end)))/(cumnumTrades(d2004(end))-cumnumTrades(d2003(end))), smartmean(capital(d2004)));
	end
	if (length(d2005)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), 252*smartmean(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/smartstd(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/sqrt(smartsum((negpnl(d2005)./avgcapital126(d2005)).^2)/(length(find(negpnl(d2005)<0))-1)), length(find(pnl(d2005)>0))/length(d2005), 1e4*(cumpnl(d2005(end))-cumpnl(d2004(end)))/(cumnumTrades(d2005(end))-cumnumTrades(d2004(end))), smartmean(capital(d2005)));
    end
    if (length(d2006)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/length(d2006), 1e4*(cumpnl(d2006(end))-cumpnl(d2004(end)))/(cumnumTrades(d2006(end))-cumnumTrades(d2004(end))), smartmean(capital(d2006)));
	end

    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d2001(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
elseif (length(d2002)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2002(1)), tday(d2002(end)), 252*smartmean(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/smartstd(pnl(d2002)./avgcapital126(d2002)), sqrt(252)*smartmean(pnl(d2002)./avgcapital126(d2002))/sqrt(smartsum((negpnl(d2002)./avgcapital126(d2002)).^2)/(length(find(negpnl(d2002)<0))-1)), length(find(pnl(d2002)>0))/252, 1e4*cumpnl(d2002(end))/cumnumTrades(d2002(end)), smartmean(capital(d2002)));
    
	if (length(d2003)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2003(1)), tday(d2003(end)), 252*smartmean(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/smartstd(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/sqrt(smartsum((negpnl(d2003)./avgcapital126(d2003)).^2)/(length(find(negpnl(d2003)<0))-1)), length(find(pnl(d2003)>0))/length(d2003), 1e4*(cumpnl(d2003(end))-cumpnl(d2002(end)))/(cumnumTrades(d2003(end))-cumnumTrades(d2002(end))), smartmean(capital(d2003)));
	end
	if (length(d2004)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2004(1)), tday(d2004(end)), 252*smartmean(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/smartstd(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/sqrt(smartsum((negpnl(d2004)./avgcapital126(d2004)).^2)/(length(find(negpnl(d2004)<0))-1)), length(find(pnl(d2004)>0))/length(d2004), 1e4*(cumpnl(d2004(end))-cumpnl(d2003(end)))/(cumnumTrades(d2004(end))-cumnumTrades(d2003(end))), smartmean(capital(d2004)));
	end
	if (length(d2005)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), 252*smartmean(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/smartstd(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/sqrt(smartsum((negpnl(d2005)./avgcapital126(d2005)).^2)/(length(find(negpnl(d2005)<0))-1)), length(find(pnl(d2005)>0))/length(d2005), 1e4*(cumpnl(d2005(end))-cumpnl(d2004(end)))/(cumnumTrades(d2005(end))-cumnumTrades(d2004(end))), smartmean(capital(d2005)));
    end
    if (length(d2006)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/length(d2006), 1e4*(cumpnl(d2006(end))-cumpnl(d2004(end)))/(cumnumTrades(d2006(end))-cumnumTrades(d2004(end))), smartmean(capital(d2006)));
	end

    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d2002(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
elseif (length(d2003)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2003(1)), tday(d2003(end)), 252*smartmean(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/smartstd(pnl(d2003)./avgcapital126(d2003)), sqrt(252)*smartmean(pnl(d2003)./avgcapital126(d2003))/sqrt(smartsum((negpnl(d2003)./avgcapital126(d2003)).^2)/(length(find(negpnl(d2003)<0))-1)), length(find(pnl(d2003)>0))/252, 1e4*cumpnl(d2003(end))/cumnumTrades(d2003(end)), smartmean(capital(d2003)));
    
	if (length(d2004)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2004(1)), tday(d2004(end)), 252*smartmean(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/smartstd(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/sqrt(smartsum((negpnl(d2004)./avgcapital126(d2004)).^2)/(length(find(negpnl(d2004)<0))-1)), length(find(pnl(d2004)>0))/length(d2004), 1e4*(cumpnl(d2004(end))-cumpnl(d2003(end)))/(cumnumTrades(d2004(end))-cumnumTrades(d2003(end))), smartmean(capital(d2004)));
	end
	if (length(d2005)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), 252*smartmean(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/smartstd(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/sqrt(smartsum((negpnl(d2005)./avgcapital126(d2005)).^2)/(length(find(negpnl(d2005)<0))-1)), length(find(pnl(d2005)>0))/length(d2005), 1e4*(cumpnl(d2005(end))-cumpnl(d2004(end)))/(cumnumTrades(d2005(end))-cumnumTrades(d2004(end))), smartmean(capital(d2005)));
    end
    if (length(d2006)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/length(d2006), 1e4*(cumpnl(d2006(end))-cumpnl(d2004(end)))/(cumnumTrades(d2006(end))-cumnumTrades(d2004(end))), smartmean(capital(d2006)));
	end

    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d2003(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
elseif (length(d2004)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2004(1)), tday(d2004(end)), 252*smartmean(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/smartstd(pnl(d2004)./avgcapital126(d2004)), sqrt(252)*smartmean(pnl(d2004)./avgcapital126(d2004))/sqrt(smartsum((negpnl(d2004)./avgcapital126(d2004)).^2)/(length(find(negpnl(d2004)<0))-1)), length(find(pnl(d2004)>0))/252, 1e4*cumpnl(d2004(end))/cumnumTrades(d2004(end)), smartmean(capital(d2004)));
    
	if (length(d2005)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), 252*smartmean(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/smartstd(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/sqrt(smartsum((negpnl(d2005)./avgcapital126(d2005)).^2)/(length(find(negpnl(d2005)<0))-1)), length(find(pnl(d2005)>0))/252, 1e4*cumpnl(d2005(end))/cumnumTrades(d2005(end)), smartmean(capital(d2005)));
	end
	if (length(d2006)>0)
		fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/252, 1e4*cumpnl(d2006(end))/cumnumTrades(d2006(end)), smartmean(capital(d2006)));
	end
	
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d2004(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
elseif (length(d2005)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), 252*smartmean(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/smartstd(pnl(d2005)./avgcapital126(d2005)), sqrt(252)*smartmean(pnl(d2005)./avgcapital126(d2005))/sqrt(smartsum((negpnl(d2005)./avgcapital126(d2005)).^2)/(length(find(negpnl(d2005)<0))-1)), length(find(pnl(d2005)>0))/252, 1e4*cumpnl(d2005(end))/cumnumTrades(d2005(end)), smartmean(capital(d2005)));
    if (length(d2006)>0)
        fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/252, 1e4*cumpnl(d2006(end))/cumnumTrades(d2006(end)), smartmean(capital(d2006)));
    end
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d2005(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
elseif (length(d2006)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/252, 1e4*cumpnl(d2006(end))/cumnumTrades(d2006(end)), smartmean(capital(d2006)));
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d2006(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
elseif (length(d2007)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f%10.4f%10.4f%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), 252*smartmean(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/smartstd(pnl(d2006)./avgcapital126(d2006)), sqrt(252)*smartmean(pnl(d2006)./avgcapital126(d2006))/sqrt(smartsum((negpnl(d2006)./avgcapital126(d2006)).^2)/(length(find(negpnl(d2006)<0))-1)), length(find(pnl(d2006)>0))/252, 1e4*cumpnl(d2006(end))/cumnumTrades(d2006(end)), smartmean(capital(d2006)));
    fprintf(fid, '\n%i-%i:%10.4f%10.4f%10.4f%10s%10.4f%10.4f\n', tday(d2006(1)), enddate, avgret, sharpe, sortino, ' ', 1e4*cumpnl(end)/cumnumTrades(end), smartmean(capital));
end


plot(cumsum(pnl));
title('Cumulative P/L');

set(gca, 'xtick', monthFirstIdx);
grid on;
set(gca, 'XTickLabel', monthFirst);

fprintf(fid, 'Based on 20 day avg cap:\n');
avgcapital=smartMovingAvg(capital, 20);
avgcapital(1:20-1)=smartmean(avgcapital(1:20));
calculateDrawdown(cumsum(pnl), avgcapital, tday, fid);

fprintf(fid, 'Based on 125 day avg cap:\n');
if (size(capital, 1)>=125)
	avgcapital=smartMovingAvg(capital, 125);
	avgcapital(1:124)=smartmean(avgcapital(1:125));
else
	avgcapital=repmat(smartmean(capital, 1), [size(capital, 1) 1]);
end

calculateDrawdown(cumsum(pnl), avgcapital,  tday, fid);


fprintf(fid, 'Based on 252 day avg cap:\n');
if (size(capital, 1)>=252)
	avgcapital=smartMovingAvg(capital, 252);
	avgcapital(1:252-1)=smartmean(avgcapital(1:252));
else
	avgcapital=repmat(smartmean(capital, 1), [size(capital, 1) 1]);
end

calculateDrawdown(cumsum(pnl), avgcapital,  tday, fid);

if (isFixedCap)
    investment = repmat(investment, [size(avgcapital, 1) 1]);
else
    investment = avgcapital/capDivisor; % set capital to one side of average position
end

investment(end+1)=investment(end);

fprintf(fid, 'Mean Abs Capital Ratio=%f\n', smartmean(abs(ratio)));
fprintf(fid, 'Avg capital=%f\n', smartmean(capital));

% avgHoldday=calculateAvgHoldday(squeeze(positionTable(:, :, end)));
% fprintf(fid, 'Avg holding days=%f\n', avgHoldday);
% fprintf(fid, 'Avg turnover=%f\n', 1/avgHoldday);
avgHoldPeriod=calculateAvgHoldday(unpackCls(positionTable));
fprintf(fid, 'Avg holding period=%f\n', avgHoldPeriod);
fprintf(fid, 'Avg turnover=%f\n', 1/avgHoldPeriod);

avgNumTrades=smartmean(numTrades);
fprintf(fid, 'Avg num trades per day=%f\n', avgNumTrades);

numSymbols= smartsum(abs(sign(positionTable(:, :, end))), 2);
subplot(3, 1, 2); plot([capital numSymbols]);
title('Capital vs numSymbols');



set(gca, 'xtick', monthFirstIdx);
grid on;
set(gca, 'XTickLabel', monthFirst);


subplot(3, 1, 3);  plot(ratio);
title('L/S Imbalance');

set(gca, 'xtick', monthFirstIdx);
grid on;
set(gca, 'XTickLabel', monthFirst);

clear monthFirst;

hold off;
figure;
if (length(d1998)>0)
    monthFirst={'19980102'};
elseif (length(d1999)>0)
    monthFirst={'19990104'};
elseif (length(d2000)>0)
    monthFirst={'20000104'};
elseif (length(d2001)>0)
    monthFirst={'20010102'};
elseif (length(d2002)>0)
    monthFirst={'20020102'};
elseif (length(d2003)>0)
    monthFirst={'20030102'};
elseif (length(d2004)>0)
    monthFirst={'20040102'};
elseif (length(d2005)>0)
    monthFirst={'20050103'};
% 		monthFirst={'20050720'};
elseif (length(d2006)>0)
    monthFirst={'20060103'};
    % monthFirst={'20060614'};

elseif (length(d2007)>0)
    monthFirst={'20070103'};
end

lastMonth=num2str(startdate);
lastMonth=lastMonth(5:6);
monthlypnl=[];
monthlypnl(1)=0;

monthlypnld=[]; % pnl in dollars
monthlypnld(1)=0; 

smvmonth=[]; 
lmvmonth=[];

shrBoughtMonth=[];
shrSoldMonth=[];

investmentMonth=[];

monthFirstIdx(1)=find(tday==str2num(monthFirst{1}));

for i=monthFirstIdx:length(tday)
  curMonth=num2str(tday(i));
  curMonth=curMonth(5:6);
  if (~strcmp(lastMonth, curMonth)) % new month
    monthFirst{end+1}=num2str(tday(i));
    monthlypnl(end+1)=pnl(i);
    monthlypnld(end+1)=pnld(i);
    
    lastMonthIdx=find(tday < tday(i) & tday >= str2num(char(monthFirst(end-1))));
    lmvmonth(end+1)=smartmean(LMV(lastMonthIdx));
    smvmonth(end+1)=smartmean(SMV(lastMonthIdx));
    investmentMonth(end+1)=smartmean(investment(lastMonthIdx));

    shrBought=tradess(lastMonthIdx);
    shrBought(shrBought < 0)=0;
    shrSold=tradess(lastMonthIdx);
    shrSold(shrSold > 0)=0;
    shrBoughtMonth(end+1)=smartsum(smartsum(shrBought, 2), 1);
    shrSoldMonth(end+1)=-smartsum(smartsum(shrSold, 2), 1);

    lastMonth=curMonth;
  else
    monthlypnl(end)=monthlypnl(end)+pnl(i);
    monthlypnld(end)=monthlypnld(end)+pnld(i);
  end
end

lastMonthIdx=find(tday >= str2num(char(monthFirst(end)))  & tday <= tday(end));
lmvmonth(end+1)=smartmean(LMV(lastMonthIdx));
smvmonth(end+1)=smartmean(SMV(lastMonthIdx));
investmentMonth(end+1)=smartmean(investment(lastMonthIdx));

shrBought=tradess(lastMonthIdx);
shrBought(shrBought < 0)=0;
shrSold=tradess(lastMonthIdx);
shrSold(shrSold > 0)=0;
shrBoughtMonth(end+1)=smartsum(smartsum(shrBought, 2), 1);
shrSoldMonth(end+1)=-smartsum(smartsum(shrSold, 2), 1);

monthlypnld=monthlypnld';
smvmonth=smvmonth';
lmvmonth=lmvmonth';
investmentMonth=investmentMonth';
shrBoughtMonth=shrBoughtMonth';
shrSoldMonth=shrSoldMonth';

bar(monthlypnl);

% idxTbill=find(datenum(tbilldate) >= tday2datenum(startdate) & datenum(tbilldate) <= tday2datenum(enddate));

mymonthFirst=char(monthFirst);
mymonthFirst=cellstr(mymonthFirst(:, 1:6));

mytbilldate=char(datestr(datenum(tbilldate), 'yyyymmdd'));
mytbilldate=cellstr(mytbilldate(:, 1:6));

[foo, foo, idxTbill]=intersect(mymonthFirst, mytbilldate);
tbill=tbill(idxTbill);



set(gca, 'xtick', [1:12:length(monthFirst)]);


set(gca, 'XTickLabel', monthFirst([1:12:length(monthFirst)]));
title('Monthly P/L');
grid on;


financeChargeTot=financeCharge+tbill;
shortRebateTot=shortRebate+tbill;

if (length(investmentMonth)>=6)
	avgInvestmentMonth6=smartMovingAvg(investmentMonth, 6);
	avgInvestmentMonth6(1:5)=smartmean(avgInvestmentMonth6(1:6));
else
	avgInvestmentMonth6=repmat(smartmean(investmentMonth, 1), [size(investmentMonth, 1) 1]);
end

% monthlypnld=monthlypnld+investmentMonth.*tbill/12-0.5*(lmvmonth+abs(smvmonth))*debitCreditSpd/12;
monthlypnld=monthlypnld+investmentMonth.*tbill/12-(lmvmonth.*financeChargeTot-abs(smvmonth).*shortRebateTot)/12;
netmonthlypnld=monthlypnld-investmentMonth*mgmtFee/12 - monthlypnld*incentiveFee;
netMonthlyRet=netmonthlypnld./avgInvestmentMonth6;    
excessMonthlyRet=netMonthlyRet - tbill/12;

if (isPlotExcessReturn)
    netcumret=smartcumsum(excessMonthlyRet);
else
    netcumret=smartcumsum(netMonthlyRet);
end

m1998=find(str2num(char(monthFirst)) >= 19980000 & str2num(char(monthFirst)) <= 19989999);
m1999=find(str2num(char(monthFirst)) >= 19990000 & str2num(char(monthFirst)) <= 19999999);
m2000=find(str2num(char(monthFirst)) >= 20000000 & str2num(char(monthFirst)) <= 20009999);
m2001=find(str2num(char(monthFirst)) >= 20010000 & str2num(char(monthFirst)) <= 20019999);
m2002=find(str2num(char(monthFirst)) >= 20020000 & str2num(char(monthFirst)) <= 20029999);
m2003=find(str2num(char(monthFirst)) >= 20030000 & str2num(char(monthFirst)) <= 20039999);
m2004=find(str2num(char(monthFirst)) >= 20040000 & str2num(char(monthFirst)) <= 20049999);
m2005=find(str2num(char(monthFirst)) >= 20050000 & str2num(char(monthFirst)) <= 20059999);
m2006=find(str2num(char(monthFirst)) >= 20060000 & str2num(char(monthFirst)) <= 20069999);
m2007=find(str2num(char(monthFirst)) >= 20070000 & str2num(char(monthFirst)) <= 20079999);

fprintf(fid, 'After fees:\n');
fprintf(fid, '%18s%10s%10s\n', ' ', 'YTD ret', 'Sharpe'); 
if (length(d1998)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d1998(1)), tday(d1998(end)), smartsum(netMonthlyRet(m1998)), sqrt(12)*smartmean(excessMonthlyRet(m1998))/smartstd(excessMonthlyRet(m1998)));
end
if (length(d1999)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d1999(1)), tday(d1999(end)), smartsum(netMonthlyRet(m1999)), sqrt(12)*smartmean(excessMonthlyRet(m1999))/smartstd(excessMonthlyRet(m1999)));
end
if (length(d2000)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d2000(1)), tday(d2000(end)), smartsum(netMonthlyRet(m2000)), sqrt(12)*smartmean(excessMonthlyRet(m2000))/smartstd(excessMonthlyRet(m2000)));
end
if (length(d2001)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d2001(1)), tday(d2001(end)), smartsum(netMonthlyRet(m2001)), sqrt(12)*smartmean(excessMonthlyRet(m2001))/smartstd(excessMonthlyRet(m2001)));
end
if (length(d2002)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d2002(1)), tday(d2002(end)), smartsum(netMonthlyRet(m2002)), sqrt(12)*smartmean(excessMonthlyRet(m2002))/smartstd(excessMonthlyRet(m2002)));
end
if (length(d2003)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d2003(1)), tday(d2003(end)), smartsum(netMonthlyRet(m2003)), sqrt(12)*smartmean(excessMonthlyRet(m2003))/smartstd(excessMonthlyRet(m2003)));
end
if (length(d2004)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d2004(1)), tday(d2004(end)), smartsum(netMonthlyRet(m2004)), sqrt(12)*smartmean(excessMonthlyRet(m2004))/smartstd(excessMonthlyRet(m2004)));
end
if (length(d2005)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d2005(1)), tday(d2005(end)), smartsum(netMonthlyRet(m2005)), sqrt(12)*smartmean(excessMonthlyRet(m2005))/smartstd(excessMonthlyRet(m2005)));
end
if (length(d2006)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d2006(1)), tday(d2006(end)), smartsum(netMonthlyRet(m2006)), sqrt(12)*smartmean(excessMonthlyRet(m2006))/smartstd(excessMonthlyRet(m2006)));
end
if (length(d2007)>0)
    fprintf(fid, '%i-%i:%10.4f%10.4f\n', tday(d2007(1)), tday(d2007(end)), smartsum(netMonthlyRet(m2007)), sqrt(12)*smartmean(excessMonthlyRet(m2007))/smartstd(excessMonthlyRet(m2007)));
end

if (length(d1998)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d1998(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
elseif (length(d1999)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d1999(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
elseif (length(d2000)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d2000(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
elseif (length(d2001)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d2001(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
elseif (length(d2002)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d2002(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
elseif (length(d2003)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d2003(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
elseif (length(d2004)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d2004(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
elseif (length(d2005)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d2005(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
elseif (length(d2006)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d2006(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
elseif (length(d2007)>0)
    fprintf(fid, '\n%i-%i:%10.4f%10.4f\n', tday(d2007(1)), enddate, 12*smartmean(netMonthlyRet), sqrt(12)*smartmean(excessMonthlyRet)/smartstd(excessMonthlyRet));
end

fprintf(fid, '%s:%10.4f\n', 'Avg Excess Ret', 12*smartmean(excessMonthlyRet));
fprintf(fid, '%s:%10.4f\n', 'Total Ret', smartsum(netMonthlyRet));
fprintf(fid, '%s:%10.4f\n', 'Best Month', max(netMonthlyRet));
fprintf(fid, '%s:%10.4f\n', 'Worst Month', min(netMonthlyRet));
fprintf(fid, '%s:%10.4f\n', 'Success Rate', length(find(netMonthlyRet>0))/length(netMonthlyRet));

fprintf(fid, '%s:%10.4f\n', 'Standard Dev', sqrt(12)*smartstd(excessMonthlyRet));
fprintf(fid, '%s:%10.4f\n', 'Avg Leverage', smartmean(capital./investment(1:end-1)));
fprintf(fid, '%s:%10.4f\n', 'Max Leverage', max(capital./investment(1:end-1)));
figure;

if (isPlotExcessReturn)
    bar(excessMonthlyRet);
else
    bar(netMonthlyRet);
end

set(gca, 'xtick', [1:12:length(monthFirst)]);


set(gca, 'XTickLabel', monthFirst([1:12:length(monthFirst)]));
title('Net-of-fees returns');
ylabel('Monthly return');

grid on;
ax1=gca;

% hold on;

% ax2=axes('XTickLabel', monthFirst([1:12:length(monthFirst)]), 'Position', get(ax1, 'Position'), ...
%     'YAxisLocation', 'right', ...
%     'Color', 'none', ...
%     'YColor', 'g' );

ax2=axes('Position', get(ax1, 'Position'));


plot(netcumret, 'r');
if (1)
    set(ax2, 'YAxisLocation', 'right', ...
        'Color', 'none', ...
        'XTickLabel', [], 'xtick', [], 'YLimMode', 'manual', 'YLim', [0 0.4] );
    set(ax1, 'YLimMode', 'manual', 'YLim', [-0.02 0.06] );

else
    set(ax2, 'YAxisLocation', 'right', ...
        'Color', 'none', ...
        'XTickLabel', [], 'xtick', [] );
    %     set(ax1, 'YLimMode', 'manual', 'YLim', [-0.02 0.07] );
end

set(ax2, 'XLim', get(ax1, 'XLim'), 'Layer', 'top');
ylabel('Cumulative uncompounded return');
set(gcf, 'PaperPositionMode', 'auto');

calculateDrawdown(netcumret(1:end-1), 1, str2num(char(monthFirst')), fid);
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily15_varminret_avghour_indgpbeta/performance.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily15_trendCycle_rebalance/performance.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily15_trendCycle4/performance_xcyclerev.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily15_trendCycle4/performance_xtrendmom.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily15_trendCycle6/performance_xcyclerev.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily15_trendCycle_bothMom/performance.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily15_varminret_avghour_indgpbeta_lowPrice5/performance.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily15_momrev3/performance.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily_wmean/performance.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily_spxmid/performance.DTB');
% cell2txt([monthFirst', num2cell(monthlypnld), num2cell(shrBoughtMonth), num2cell(shrSoldMonth), num2cell(lmvmonth), num2cell(smvmonth), num2cell(netMonthlyRet), num2cell(netcumret)], {'Month:S', 'MonthlyPNL:N', 'Shares Bought:N', 'Shares Sold:N', 'LMV:N', 'SMV:N', 'Net Monthly Return:N', 'Cum net return:N'}, 'D:/Projects/sectorModel_prod/daily_momrev_balnew/performance.DTB');

fclose(fid);