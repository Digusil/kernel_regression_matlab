function data = splitDataRandom(inputs, targets, splitdistribution)
    m = size(inputs, 1);    

    indeces_perm = randperm(m);

    N = numel(splitdistribution);
    M = sum(splitdistribution);

    ind = 0;

    for k = 1:N-1
        ind = ind(end)+1:ind(end)+round(m*splitdistribution(k)/M);
        data{k}.inputs = inputs(indeces_perm(ind),:);
        data{k}.targets = targets(indeces_perm(ind),:);
    end

    ind = ind(end)+1:m;
    data{N}.inputs = inputs(indeces_perm(ind),:);
    data{N}.targets = targets(indeces_perm(ind),:);
end
