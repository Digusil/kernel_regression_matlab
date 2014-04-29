function [m, dm] = nadarayaWatsonEstimator(x, x_feature, y_feature, kernelFunction, h, scaleMode)
	X2 = sum(x_feature.^2, 2);
	x2 = sum(x.^2, 2);
    
    if numel(h) > 1
        h = ones(size(x,1),1)*h;
    end

	u = sqrt(bsxfun(@plus, x2, bsxfun(@plus, X2', - 2 * (x * x_feature'))))./h;

    if nargout > 1
		[K, dK] = kernelFunction(u);
	else
		K = kernelFunction(u);
    end
    
    switch scaleMode
        case 'scaled'
            Kh = K./h;

            tmp1 = Kh*y_feature;
            tmp2 = sum(Kh,2)*ones(1,size(y_feature,2));
        case 'unscaled'
            tmp1 = K*y_feature;
            tmp2 = sum(K,2)*ones(1,size(y_feature,2));
        otherwise
            error('Scale mode error! Use scaled or unscaled');
    end

    m = tmp1./tmp2;

	if nargout > 1
        switch scaleMode
            case 'unscaled'
                dK = -u./h.*dK;
                
                dtmp1 = dK.*(ones(size(dK,1),1)*y_feature');
                dtmp2 = dK;
            case 'scaled'
                dKh = -u./(h.^2).*(dK + K);
                
                dtmp1 = dKh.*(ones(size(dKh,1),1)*y_feature');
                dtmp2 = dKh;
        end
        
        if numel(h) == 1
			dtmp1 = sum(dtmp1, 2);
			dtmp2 = sum(dtmp2, 2);
        else
			N = size(x_feature,1);
            tmp1 = tmp1*ones(1,N);
            tmp2 = tmp2*ones(1,N);
        end

		dm = (1./tmp2).*dtmp1-(tmp1./(tmp2.^2)).*dtmp2;
	end
end
