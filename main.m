tic %��������ʱ��
canshu; %��������
gen = 1;%��ʼ����
group = create(number, clength); %������ʼ��Ⱦɫ��
confilist = []; %�������Ŷȼ��� 
supportlist = []; %����֧�ֶȼ���
fitlist = []; %������Ӧ�ȼ���
for i = 1:length(frequentsets) %������Ƶ�����
member = frequentsets(i,:); %��Ҫ���в�����������

%��һ��
[fit,confi,supp] = apriori_fit(member, group, matrix, supplist);
bestfit = max(fit);
bestx = group(fit==bestfit,:);

while gen<Max

%ѡ����
s = expecsel(fit);%����ѡ��
group = group(s,:);

%���溯��
childgroup = cross(group, Pc, n_cross);

%���캯��
childgroup = mutate(childgroup, Ps);
childfit = apriori_fit(member, childgroup, matrix, supplist);

%���²��뺯��
[group, bestfit, bestx] = rein(childgroup, childfit, bestfit, bestx);%��Ӣ����ѡ��

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
rulesnum = sum((fitlist~=0).*(confilist>=minconf).*(supportlist>=minsupp)); %�����Ĺ������
toc
 
[~, index] = sort(fitlist, 'descend'); %������Ӧ�ȴ�С�Ӵ�С���й���
result_supp = supportlist(index); 
result_conf = confilist(index);
plot(result_supp, result_conf, 'ro') %�����������б��֧�ֶȺ����Ŷȵ�ͼ
title('Final rules')
xlabel('Support')
ylabel('Confidence')



