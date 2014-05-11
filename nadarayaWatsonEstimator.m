function [m, dm, ddm] = nadarayaWatsonEstimator(u_feature, y_feature, kernelFunction, h, scaleMode)

    if numel(h) > 1
        h = ones(size(u_feature,1),1)*h;
    end

    switch nargout
        case 1
            K = kernelFunction(u_feature./h);
        case 2
            [K, dK] = kernelFunction(u_feature./h);
        otherwise
            [K, dK, ddK] = kernelFunction(u_feature./h);
    end

    switch scaleMode
        case 'scaled'
            Kh = K./h;

            a = Kh*y_feature;
            b = sum(Kh,2)*ones(1,size(y_feature,2));
        case 'unscaled'
            a = K*y_feature;
            b = sum(K,2)*ones(1,size(y_feature,2));
        otherwise
            error('Scale mode error! Use scaled or unscaled');
    end

    m = a./b;

    if nargout > 1
        switch scaleMode
            case 'unscaled'
                dK = -u_feature./h.*dK;

                da = dK.*(ones(size(dK,1),1)*y_feature');
                db = dK;
            case 'scaled'
                dKh = -1./(h.^2).*(u_feature.*dK + K);

                da = dKh.*(ones(size(dKh,1),1)*y_feature');
                db = dKh;
        end

        if numel(h) == 1
            da = sum(da, 2);
            db = sum(db, 2);
        else
            N = size(u_feature,2);
            a = a*ones(1,N);
            b = b*ones(1,N);
        end

        dm = (1./b).*da-(a./(b.^2)).*db;
    end
    
    if nargout > 2
        switch scaleMode
            case 'unscaled'
                ddK = u./(h.^2).*(2*dK+u_feature*ddK);

                dda = ddK.*(ones(size(ddK,1),1)*y_feature');
                ddb = ddK;
            case 'scaled'
                ddKh = -1./(h.^3).*(u_feature*dK + K)-u_feature./h.*(dKh+u_feature.*ddK);

                dda = ddKh.*(ones(size(ddKh,1),1)*y_feature');
                ddb = ddKh;
        end

        if numel(h) == 1
            dda = sum(dda, 2);
            ddb = sum(ddb, 2);
        else
            N = size(x_feature,1);
            a = a*ones(1,N);
            b = b*ones(1,N);
        end

        ddm = (dda.*b-2*da.*db-a.*ddb)./(b.^2) + (a.* db.^2)./(b.^3);
    end
end
