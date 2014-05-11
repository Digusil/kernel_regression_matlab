function [J, dJ] = krCostFunction(u_feature, y_val, y_feature, kernelFunction, h, scaleMode)  
	m = size(u_feature,1);

    if numel(h) > 1
		h = reshape(h,1,size(u_feature,2));
    end
    
	[z, dz] = nadarayaWatsonEstimator(u_feature, y_feature, kernelFunction, h, scaleMode);

	hypo = z - y_val;

	J = 1/(2*m) * (hypo'*hypo);
	
	dJ = 1/m * dz'*hypo;
    
    J(isnan(J)) = 1e25;
    dJ(isnan(dJ)) = 0;
    
    J(isinf(J)) = sign(J(isinf(J)))*1e25;
    dJ(isinf(dJ)) = sign(dJ(isinf(dJ)))*1e25;
end
