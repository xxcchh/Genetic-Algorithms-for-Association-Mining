clear;
path = [pwd, '\data\\'];
userpath(path);
[name,num,row] = textread('info.txt','%*s %s %*s %d %*s %d',-1);
for i = 1:num
filename = ['matrix', num2str(i),'.csv'];
data = csvread(filename);
data = data(2:size(data,1), 2:size(data,2));
[sets, supp] = getsets_supp(data);
if i == 1
[ matrix, supplist ] = combinesets_supp( num, sets, supp);
frequentsets = [];
else
[ matrix, supplist ] = combinesets_supp( num, sets, supp, matrix, supplist);
[ frequentsets, ~] = combinesets_supp( num, sets, supp, frequentsets, supplist);
end
end
supplist = supplist/row;
clear data filename i num row sets supp
delete data//info.txt data//matrix* 

