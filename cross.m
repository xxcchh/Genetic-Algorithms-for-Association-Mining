function new_chrom = cross(chrom, pc, n_cross)
if nargin<2
    pc = 0.7;
    n_cross = 1;
end
if nargin<3
    n_cross = 1;
end  
[number, length] = size(chrom);
pair = floor(number/2);
prob = rand(pair,1) <=pc;
odd = 1:2:number-1;
even = 2:2:number;
place = 1:length-1;
random_raw = randsample(place,n_cross);                                 
mask = zeros(1,length);

if rem(n_cross,2)
    mask(random_raw(n_cross)+1:end) = 1;
end

for i = 2:n_cross
    if ~rem(i,2)
        mask(random_raw(i-1)+1:random_raw(i)) = 1; 
    end 
end        

mask = repmat(mask,pair,1).*repmat(prob,1,length);
new_chrom(odd,:) = chrom(odd,:).*(~mask) +chrom(even,:).*mask;
new_chrom(even,:) = chrom(even,:).*(~mask) +chrom(odd,:).*mask;
if rem(number,2),
new_chrom(number,:) = chrom(number,:);
end
end