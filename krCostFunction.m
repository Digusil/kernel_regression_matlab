function [J, dJ] = krCostFunction(x_val, y_val, x_feature, y_feature, kernelFunction, h, scaleMode)  
	m = size(x_val,1);

    if numel(h) > 1
		h = reshape(h,1,size(x_feature,1));
    end
    
	[z, dz] = nadarayaWatsonEstimator(x_val, x_feature, y_feature, kernelFunction, h, scaleMode);

	hypo = z - y_val;

	J = 1/(2*m) * (hypo'*hypo);
	
	dJ = 1/m * dz'*hypo;
    
    J(isnan(J)) = 1e25;
    dJ(isnan(dJ)) = 0;
    
    J(isinf(J)) = sign(J(isinf(J)))*1e25;
    dJ(isinf(dJ)) = sign(dJ(isinf(dJ)))*1e25;
end
