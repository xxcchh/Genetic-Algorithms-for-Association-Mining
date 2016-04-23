function new_chrom = mutate(old_chrom, pm)
if nargin<2,
    pm = 0.3;
end
[number, length] = size(old_chrom);
mut = rand(number, length)<pm;
new_chrom = xor(old_chrom, mut);
end 
