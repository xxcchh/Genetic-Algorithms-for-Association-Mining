function [group, bestfit, bestx] = rein(childgroup, childfit, tempbestfit, tempbestx)
if tempbestfit>=max(childfit)
idx = find(childfit==min(childfit));
number = length(idx);
prob = rand(number,1)<=1;
childgroup(idx.*prob~=0,:) = repmat(tempbestx(1,:), sum(idx.*prob~=0), 1);
group = childgroup;
bestfit = tempbestfit;
bestx = tempbestx;
else
bestfit = max(childfit);
bestx = childgroup(childfit==bestfit,:);
idx = find(childfit==min(childfit));
number = length(idx);
prob = rand(number,1)<=1;
childgroup(idx.*prob~=0,:) = repmat(bestx(1,:),  sum(idx.*prob~=0), 1);
group = childgroup;
end
end