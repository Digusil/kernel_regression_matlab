function [h_opt, MSE_val] = learnKernelRegression(u_feature, y_val, y_learn, kernelString, hMode, scaleMode, OptimOptions) 
    switch kernelString
        case 'gaussian'
            kernelFunction = @(u) gaussianKernel(u);
        case 'cauchy'
            kernelFunction = @(u) cauchyKernel(u);
        case 'picard'
            kernelFunction = @(u) picardKernel(u);
        case 'cosinus'
            kernelFunction = @(u) cosKernel(u);
        case 'triangle'
            kernelFunction = @(u) triangleKernel(u);
        case 'uniform'
            kernelFunction = @(u) uniformKernel(u);
        case 'epanechnikov1'
            kernelFunction = @(u) epanechnikovKernel(u, 1);
        case 'epanechnikov2'
            kernelFunction = @(u) epanechnikovKernel(u, 2);
        case 'epanechnikov3'
            kernelFunction = @(u) epanechnikovKernel(u, 3);
    end
    
    switch hMode
        case 'single'
            initial_h = 1;
        case 'multi'
            initial_h = ones(1, size(u_feature,2));
    end

     h_opt = fminunc(@(h) krCostFunction(u_feature, y_val, y_learn, kernelFunction, h,  scaleMode), initial_h, OptimOptions);

    if nargout > 1
        a_val = nadarayaWatsonEstimator(u_feature, y_learn, kernelFunction, h_opt,  scaleMode);
        tmp = a_val - y_val;
        MSE_val = 1/(2*size(u_feature,1)) * (tmp'*tmp);
    end
end
