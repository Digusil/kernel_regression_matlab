function [h_opt, MSE_val] = learnKernelRegression(x_val, y_val, x_feature, y_feature, kernelString, hMode, scaleMode, OptimOptions) 
    u_feature = [krFeature(x_val, x_feature)];
    
    switch kernelString
        case 'gaussian'
            kernelFunction = @(u) gaussianKernel(u);
            first_h = estimateH(x_feature);
        case 'cauchy'
            kernelFunction = @(u) cauchyKernel(u);
            first_h = estimateH(x_feature);
        case 'picard'
            kernelFunction = @(u) picardKernel(u);
            first_h = estimateH(x_feature);
        case 'cosinus'
            kernelFunction = @(u) cosKernel(u);
            first_h = max(u_feature(:));
        case 'triangle'
            kernelFunction = @(u) triangleKernel(u);
            first_h = max(u_feature(:));
        case 'uniform'
            kernelFunction = @(u) uniformKernel(u);
            first_h = max(u_feature(:));
        case 'epanechnikov1'
            kernelFunction = @(u) epanechnikovKernel(u, 1);
            first_h = max(u_feature(:));
        case 'epanechnikov2'
            kernelFunction = @(u) epanechnikovKernel(u, 2);
            first_h = max(u_feature(:));
        case 'epanechnikov3'
            kernelFunction = @(u) epanechnikovKernel(u, 3);
            first_h = max(u_feature(:));
        otherwise
            error('Wrong kernel function! Choose a valid kernel function.')
    end
    
    switch hMode
        case 'single'
            initial_h = first_h;
        case 'multi'
            initial_h = first_h*ones(1, size(u_feature,2));
    end

     h_opt = fminunc(@(h) krCostFunction(u_feature, y_val, [y_feature], kernelFunction, h,  scaleMode), initial_h, OptimOptions);

    if nargout > 1
        a_val = nadarayaWatsonEstimator(u_feature, [y_feature], kernelFunction, h_opt,  scaleMode);
        tmp = a_val - y_val;
        MSE_val = 1/(2*size(u_feature,1)) * (tmp'*tmp);
    end
end
