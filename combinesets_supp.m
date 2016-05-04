function [ frequentssets, supplist ] = combinesets_supp( num, sets, supp, oldsets, oldsupp)

[row, col] = size(sets);
if nargin < 5
    frequentssets = [sets zeros(row, num-col)];
    supplist = supp;
else
    tempsets = [sets zeros(row, num-col)];
    frequentssets = [oldsets; tempsets];
    supplist = [oldsupp; supp];    
end
end

