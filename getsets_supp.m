function [ sets, supp ] = getsets_supp( data )
[~, col] = size(data);
supp = data(:,col);
sets = data(:,1:col-1);
end

