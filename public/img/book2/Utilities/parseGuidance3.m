function [guidance]=parseGuidance3(amcDate, bmoDate, allsyms)
% guidance=parseGuidance3(amcDate, bmoDate, allsyms) 
% size(guidance)=size(allsyms)

patternDate='<STRONG>Earnings Guidance for \w+, (\w+ \d+, \d\d\d\d)</STRONG>';
patternSym='<A href="stocks.asp\?symbol=([\w\.]+)">[\w\.]+</A>';
patternTime='(\d+:\d\d:\d\d \wM) ET&nbsp;<small>';

guidance=zeros(size(allsyms));

tday=[amcDate; bmoDate];
for t=1:2
       
    try
        file =urlread(['file:///C:/Projects/earningsMom_data/guidance/', num2str(tday(t)), '.htm']);
    catch
        fprintf(1, '%s\n', ['Cannot read guidance file on ', num2str(tday(t))]);
        continue;
    end
    
    mydate=regexp(file, patternDate, 'tokens');
    mydate=datestr(mydate{:}, 'yyyymmdd');

    assert(str2double(mydate)==tday(t));
    
    mysyms=regexp(file, patternSym , 'tokens');
    times=regexp(file, patternTime, 'tokens');
    times=[times{:}]';
    
    hh=regexp(times, '(\d+):\d\d:\d\d \wM', 'tokens');
    %     mm=regexp(times, '\d+:(\d\d):\d\d \wM', 'tokens');
    apm=regexp(times, '\d+:\d\d:\d\d (\wM)', 'tokens');
    
    hh=[hh{:}]';
    apm=[apm{:}]';
    
    hh=[hh{:}]';
    apm=[apm{:}]';    
        
    assert(length(mysyms)==length(times));
    
    upsIdx=regexp(file, 'up.gif');
    dnsIdx=regexp(file, 'down.gif');
    symsIdx=regexp(file, patternSym);
    
    assert(length(symsIdx)==length(mysyms));
    
    upordown=zeros(length(symsIdx), 1);
    
    for s=1:length(symsIdx)    
        if (~isempty(upsIdx) && upsIdx(1) > symsIdx(s))
            if (s < length(symsIdx) && upsIdx(1) < symsIdx(s+1))
                upordown(s)=1;
                upsIdx(1)=[];
            elseif (s == length(symsIdx))
                upordown(s)=1;
                upsIdx(1)=[];
            end
        end
        
        if (~isempty(dnsIdx) && dnsIdx(1) > symsIdx(s))
            if (s < length(symsIdx) && dnsIdx(1) < symsIdx(s+1))
                upordown(s)=-1;
                dnsIdx(1)=[];
            elseif (s == length(symsIdx))
                upordown(s)=-1;
                dnsIdx(1)=[];
            end
        end
    end
    
    assert(isempty(upsIdx) & isempty(dnsIdx));  
    
    if (t==1)
        idx=find(strcmp(apm, 'PM') & str2double(hh) >= 4);
        syms=mysyms(idx);
        syms=[syms{:}];
        if (~isempty(syms))
            syms=regexprep(syms, '\.', ''); % for earningswhispers.com, BFB is BF.B
        end
    
        [foo, idxA, idxB]=intersect(syms, allsyms);
        guidance(idxB)=upordown(idx(idxA));
    else
        idx=find(strcmp(apm, 'AM') & str2double(hh) <= 9);
        syms=mysyms(idx);
        syms=[syms{:}];
        if (~isempty(syms))
            syms=regexprep(syms, '\.', ''); % for earningswhispers.com, BFB is BF.B
        end

        [foo, idxA, idxB]=intersect(syms, allsyms);
        guidance(idxB)=upordown(idx(idxA));
    end
    
end 
    



