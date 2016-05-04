preprocessing; %得到需要计算的数据
canshu; %参数设置
gen = 1;%初始代数
group = create(number, clength); %产生初始代染色体
confilist = []; %规则置信度集合 
supportlist = []; %规则支持度集合
fitlist = []; %规则适应度集合
for i = 1:length(frequentsets) %对所有频繁项集合
member = frequentsets(i,:); %提取需要从中产生规则的组合

%第一代
[fit,confi,supp] = apriori_fit(member, group, matrix, supplist);%得到满足最小支持度和最小置信度的个体
bestfit = max(fit); %得到最大的适应度
bestx = group(fit==bestfit,:);%得到最大适应度相对应的最佳个体

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

bestcraw = group(fit==bestfit,:); %提取最优个体
rulesraw = repmat(member, size(bestcraw,1),1).*bestcraw; %提取最优个体对应的规则
before = unique(rulesraw, 'rows'); %规则前项
after = repmat(member, size(before,1), 1) - before; %规则后项
bestconfi = unique(confi(fit==bestfit)); %最大置信度
bestsupp = supp(1:length(bestconfi)); %最大支持度

supportlist = [supportlist;bestsupp]; %所有规则支持度集合
confilist = [confilist;bestconfi]; %所有规则置信度集合
fitlist = [fitlist; ones(size(bestconfi))*bestfit];
% 以下可以看提取出的所有规则
% fprintf('member = %s', num2str(member)) %
% fprintf('\n')
% before
% after
% bestconfi
% bestfit 
% disp('****************')
% pause;
end
rulesnum = sum((fitlist~=0).*(confilist>=minconf).*(supportlist>=minsupp)); %产生的规则个数
 
[~, index] = sort(fitlist, 'descend'); %按照适应度大小从大到小排列规则
result_supp = supportlist(index); 
result_conf = confilist(index);
N = 20; %提取前N个规则画图
plot(result_supp(1:N), result_conf(1:N), 'ro') %画出最后规则列表的支持度和置信度的二维图
title('Final rules')
xlabel('Support')
ylabel('Confidence')



