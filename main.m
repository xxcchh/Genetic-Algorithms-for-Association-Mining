tic %计算运行时间
canshu; %参数设置
gen = 1;%初始代数
group = create(number, clength); %产生初始代染色体
confilist = []; %规则置信度集合 
supportlist = []; %规则支持度集合
fitlist = []; %规则适应度集合
for i = 1:length(frequentsets) %对所有频繁项集合
member = frequentsets(i,:); %需要从中产生规则的组合

%第一代
[fit,confi,supp] = apriori_fit(member, group, matrix, supplist);
bestfit = max(fit);
bestx = group(fit==bestfit,:);

while gen<Max

%选择函数
s = expecsel(fit);%期望选择法
group = group(s,:);

%交叉函数
childgroup = cross(group, Pc, n_cross);

%变异函数
childgroup = mutate(childgroup, Ps);
childfit = apriori_fit(member, childgroup, matrix, supplist);

%重新插入函数
[group, bestfit, bestx] = rein(childgroup, childfit, bestfit, bestx);%精英保留选择

[fit, confi, supp] = apriori_fit(member, group, matrix, supplist);
gen = gen +1;
end

bestcraw = group(fit==bestfit,:);
rulesraw = repmat(member, size(bestcraw,1),1).*bestcraw;
before = unique(rulesraw, 'rows');
after = repmat(member, size(before,1), 1) - before;
bestconfi = unique(confi(fit==bestfit));
bestsupp = supp(1:length(bestconfi));

supportlist = [supportlist;bestsupp];
confilist = [confilist;bestconfi];
fitlist = [fitlist; ones(size(bestconfi))*bestfit];
% fprintf('member = %s', num2str(member))
% fprintf('\n')
% before
% after
% bestconfi
% bestfit 
% disp('****************')
% pause;
end
rulesnum = sum((fitlist~=0).*(confilist>=minconf).*(supportlist>=minsupp)); %产生的规则个数
toc
 
[~, index] = sort(fitlist, 'descend'); %按照适应度大小从大到小排列规则
result_supp = supportlist(index); 
result_conf = confilist(index);
plot(result_supp, result_conf, 'ro') %画出最后规则列表的支持度和置信度的图
title('Final rules')
xlabel('Support')
ylabel('Confidence')



