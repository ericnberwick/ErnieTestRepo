function [earnann]=parseEarningsIntradayCalendar(amcDate, bmoDate, allsyms)
% earnann=parseEarningsCalendarIntraday(amcDate, bmoDate, allsyms) from
% earningswhispers.com
% size(earnann)=size(allsyms)
% This intraday version includes annoucements during market hours today

% patternDate='<STRONG>Earnings Guidance for \w+, (\w+ \d+, \d\d\d\d)</STRONG>';
% patternSym='<A href="stocks.asp\?symbol=([\w\.]+)">[\w\.]+</A>';
patternSym='class=earnings2 href="stocks\.asp\?symbol=([\w\.]+)"';
% patternTime='(\d+:\d\d:\d\d \wM) ET&nbsp;<small>';
patternConfirmed='Confirmed';

earnann=zeros(size(allsyms));
prevLine=[];

tday=[amcDate; bmoDate];
for t=1:2
    clear mysyms syms syms2;
    mysyms={};

    try
        %         file
        %         =urlread(['file:///C:/Projects/earningsMom_data/earnann/', num2str(tday(t)), '.htm']);
        fid=fopen(['C:/Projects/earningsMom_data/earnann/', num2str(tday(t)), '.htm']);
        assert(fid~=-1);
    catch
        fprintf(1, '%s\n', ['Cannot read earnann file on ', num2str(tday(t))]);
        continue;
    end
    
    if t==1
        while (1)
            line=fgetl(fid);
            if ((length(line)==1 && line==-1) || ~isempty(regexp(line, 'After Market Closes')))
                break;
            end
        end

        while (1)
            line=fgetl(fid);
            if ((length(line)==1 && line==-1)||~isempty(regexp(line, 'Page Content Ends Here')))
                break;
            end

              
            if (~isempty(strfind(prevLine, patternConfirmed)))
                mysyms{end+1}=regexp(line, patternSym , 'tokens');
            end
            prevLine=line;
            
        end
    else

        while (1)
            line=fgetl(fid);
            
            
            %             if (line==-1 | ~isempty(regexp(line, 'After Market Closes')) | ~isempty(regexp(line, 'During Market Hours')))
            % NOTE: now this includes 'During Market Hours'
            if (line==-1 | ~isempty(regexp(line, 'After Market Closes')))
                break;
            end

            if (~isempty(strfind(prevLine, patternConfirmed)))
                mysyms{end+1}=regexp(line, patternSym , 'tokens');
            end
            prevLine=line;
        end
    end

    syms=[];
    syms2=[];
    if (~isempty(mysyms))
        syms=[mysyms{:}];
        syms2=[syms{:}];
    end
    
    %     if (~isempty(syms2))
    %         mysyms=regexprep(syms2, '\.', ''); % for earningswhispers.com, BFB is BF.B
    %     end

    [foo, idxA, idxB]=intersect(syms2, allsyms);
    earnann(idxB)=1;


    
end 
    
if (fid>0)
    fclose(fid);
end



