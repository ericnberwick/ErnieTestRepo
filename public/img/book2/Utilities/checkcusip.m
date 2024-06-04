function Result = checkcusip(inputCell)
%CHECKCUSIP Check a CUSIP
%   CHECKCUSIP is used to validate 9 digit CUSIPs and 
%   provide the checkdigit for 8 digit CUSIPs.
%
%   Note that if you give this function a combination of  
%   8 and 9 digit CUSIPs, you need to check both the class 
%   (logical or non-logical) as well as the value of the
%   output.  Logicals are used to indicate validity of a
%   9 digit CUSIP, while non-logical doubles are used to
%   supply the checkdigit for an 8 digit CUSIP.
%
%   For example:
%
%       C = {'46145F105','46145F100','4A145F10','46145F10'};
%       R = checkcusip(C)
%
%   gives
%
%       R = 
%           [1]    [0]    [0]    [5]
%
%   because C{1} is the CUSIP for ITG, C{2} has an incorrect checkdigit,
%   C{3} has a letter in the second position, and C{4} is an 8 digit 
%   CUSIP with a checkdigit of 5.  C{1:3} are logical; C{4} is a double.
%
%   It may be useful to place the output of this function in an array, 
%   rather than the default cell array output.  To do this, you can use:
%   
%       R = checkcusip(C);
%       R = reshape([R{:}],size(C));
%
%   If this conversion is made, however, you will be unable to differentiate
%   between logical 1s and 0s and non-logical checkdigits that are 1s and 0s.
%
%   More information on CUSIPs can be found at:
%       http://www.cusip.com
%
%   Written by Nabeel Azar
%   Email:  nabeel@ieee.org


%   Notes
%   *   This code leans towards clarity while sacrificing a bit 
%       of memory efficiency (may use 2x memory needed in some areas)


%   Convert the input to a char array
if iscell(inputCell)
    cusipCharArray = strvcat(inputCell{:});
else
    error(['Inputs must be cell arrays of CUSIP strings.'])
end


%   Make sure there are at least 8 columns
if size(cusipCharArray,2)<8
    error(['Must supply 8 or 9 digit CUSIPs.']);
end

%   Make them all lowercase
cusipCharArray = lower(cusipCharArray);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Convert the string digits to numerical values and
%   the characters to their numerical values, with 'A':=10
%   Set spaces (for computing the checkdigit) to NaNs

%   Transpose the array, and work down the columns.
longCusipString    = double(cusipCharArray);
longCusipString    = longCusipString.';
numericalLocations = (longCusipString>='0' & longCusipString<='9');
charLocations      = (longCusipString>='a' & longCusipString<='z');
NaNLocations       = longCusipString==' ';

longCusipString(numericalLocations) = longCusipString(numericalLocations) - '0';
longCusipString(charLocations)      = longCusipString(charLocations) - 'a' + 10;
longCusipString(NaNLocations)       = NaN;

%   Get the cusip digits
cusipNums = longCusipString(1:8,:);

%   Scale with scaling factors
cusipNums = diag([1 2 1 2 1 2 1 2]) * cusipNums;

%   Sum the digits in each term >=10;
gt_10 = cusipNums>=10;
cusipNums(gt_10) = floor(cusipNums(gt_10)/10) + rem(cusipNums(gt_10),10);

%   Sum the resulting values
cusipNums = sum(cusipNums);

%   Get the last digit
lastDigit = rem(cusipNums,10);

%   Generate the checkdigit
checkDigit = 10 - lastDigit;
checkDigit(checkDigit==10) = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%   Create a cell array the right size for the output.
Result = cell(numel(inputCell),1);

%   If no check digit was given in the input, output the checkdigit
if size(longCusipString,1)==9
    needCusip = isnan(longCusipString(9,:));
else
    needCusip = logical(ones(1,size(longCusipString,2)));
end
Result(needCusip) = num2cell(checkDigit(needCusip));

%   If a check digit was given, validate it
if size(longCusipString,1)==9
    isCheckdigitCorrect = longCusipString(9,~needCusip)==checkDigit(~needCusip);
    Result(~needCusip) = num2cell(isCheckdigitCorrect);
end

%   Only the 1st, 4th, 5th, or 6th digit may be an alphanumeric letter
%   (1st for international issues)
badIdx = any(longCusipString([2 3 7 8],:)>=10,1);
Result(badIdx) = {logical(0)};

%   The first digit cannot be an i, o, or z
badIdx = any(longCusipString(1,:)=='i' | longCusipString(1,:)=='o' | longCusipString(1,:)=='z',1);
Result(badIdx) = {logical(0)};

%   Reshape the result
Result = reshape(Result,size(inputCell));
