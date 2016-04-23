function sel = expecsel(fitness)
fit= fitness;
N = length(fit);
sumfit = sum(fit);
prob = fit/sumfit;
M = N * prob;
sel_raw = zeros(N,1);
i = 1;

while length(find(sel_raw~=0))<=N
n = find(M>0);
x = randsrc(1,1,n');

if x==-1
    break
end

if M(x)>0
sel_raw(i) = x;
M(x) = M(x) - 0.5;
i = i + 1;
end


end
sel = sel_raw(1:N);
end






