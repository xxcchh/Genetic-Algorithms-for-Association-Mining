preprocessing; %�õ���Ҫ���������
canshu; %��������
gen = 1;%��ʼ����
group = create(number, clength); %������ʼ��Ⱦɫ��
confilist = []; %�������Ŷȼ��� 
supportlist = []; %����֧�ֶȼ���
fitlist = []; %������Ӧ�ȼ���
for i = 1:length(frequentsets) %������Ƶ�����
member = frequentsets(i,:); %��ȡ��Ҫ���в�����������

%��һ��
[fit,confi,supp] = apriori_fit(member, group, matrix, supplist);%�õ�������С֧�ֶȺ���С���Ŷȵĸ���
bestfit = max(fit); %�õ�������Ӧ��
bestx = group(fit==bestfit,:);%�õ������Ӧ�����Ӧ����Ѹ���

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

bestcraw = group(fit==bestfit,:); %��ȡ���Ÿ���
rulesraw = repmat(member, size(bestcraw,1),1).*bestcraw; %��ȡ���Ÿ����Ӧ�Ĺ���
before = unique(rulesraw, 'rows'); %����ǰ��
after = repmat(member, size(before,1), 1) - before; %�������
bestconfi = unique(confi(fit==bestfit)); %������Ŷ�
bestsupp = supp(1:length(bestconfi)); %���֧�ֶ�

supportlist = [supportlist;bestsupp]; %���й���֧�ֶȼ���
confilist = [confilist;bestconfi]; %���й������Ŷȼ���
fitlist = [fitlist; ones(size(bestconfi))*bestfit];
% ���¿��Կ���ȡ�������й���
% fprintf('member = %s', num2str(member)) %
% fprintf('\n')
% before
% after
% bestconfi
% bestfit 
% disp('****************')
% pause;
end
rulesnum = sum((fitlist~=0).*(confilist>=minconf).*(supportlist>=minsupp)); %�����Ĺ������
 
[~, index] = sort(fitlist, 'descend'); %������Ӧ�ȴ�С�Ӵ�С���й���
result_supp = supportlist(index); 
result_conf = confilist(index);
N = 20; %��ȡǰN������ͼ
plot(result_supp(1:N), result_conf(1:N), 'ro') %�����������б��֧�ֶȺ����ŶȵĶ�άͼ
title('Final rules')
xlabel('Support')
ylabel('Confidence')



