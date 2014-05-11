function [x_red, y_red] = krReduceDim(N, x_feature, y_feature)

    m_feature = size(x_feature,1);

    [h_est, rho] = estimateH(x_feature);

    [m, dm, ddm] = nadarayaWatsonEstimator(krFeature(x_feature, x_feature), y_feature, @(u) gaussianKernel(u), h_est, 'scaled');

    para = abs(sum(ddm*ddm',2)).*rho;

    [val, idx] = sort(para);

    idxMin = round(N/100 * m_feature);

    x_red = x_feature(idx(idxMin+1:end),:);
    y_red = y_feature(idx(idxMin+1:end),:);

end
