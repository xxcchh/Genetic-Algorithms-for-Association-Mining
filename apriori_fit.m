function [value, confi, suppi] = apriori_fit( member, group, matrix, supplist)
canshu;
[n, ~] = size(group);
fitness = zeros(n,1);
lenm = sum(member~=0);
choiceraw = repmat(member,n,1).*group;
supp = supplist(ismember(matrix,member,'rows'));
conf = zeros(n,1);
for i = 1:n
    temp = choiceraw(i, :);
    temp = sort(temp(temp~=0));
    len = length(temp);
    choice = [temp,zeros(1,maxlen-len)];
    [~,idx] = ismember(matrix,choice,'rows');
    if (sum(idx) == 0)||(lenm==len)
        fitness(i) = 0;
    else
        conf(i) = supp/supplist(idx~=0);
        if (conf(i) < minconf)||(supp < minsupp)
            fitness(i) = 0;
        else
            fitness(i) = w1*supp + w2*conf(i);
        end        
    end   
end
value = fitness;
confi = conf;
suppi = ones(n,1) * supp;







