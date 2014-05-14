function [x_red, y_red] = krReduceDim(N, x_feature, y_feature) 
    if N < 0 || ~isnumeric(N)
        error('Wrong N!')
    end

    m_feature = size(x_feature,1);

    [h_est, rho] = estimateH(x_feature);

    [~, ~, ddm] = nadarayaWatsonEstimator(krFeature(x_feature, x_feature), y_feature, @(u) gaussianKernel(u), h_est, 'scaled');

    para = abs(sum(ddm*ddm',2)).*rho;

    [~, idx] = sort(para);
    
    if N < 1
        idxMin = round(N * m_feature)+1;
    else
        if N >= m_feature
            idxMin = 0;
        else
            idxMin = m_feature - N +1;
        end
    end

    x_red = x_feature(idx(idxMin:end),:);
    y_red = y_feature(idx(idxMin:end),:);
end
