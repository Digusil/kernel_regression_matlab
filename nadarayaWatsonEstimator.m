function [m, dm, ddm] = nadarayaWatsonEstimator(u_feature, y_feature, kernelFunction, h, scaleMode)
    [m_u, n_u] = size(u_feature);
    
    if numel(h) > 1
        h = ones(m_u,1)*h;
    end
    
    u = u_feature./h;

    switch nargout
        case 1
            K = kernelFunction(u);
        case 2
            [K, dK] = kernelFunction(u);
        otherwise
            [K, dK, ddK] = kernelFunction(u);
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
            error('Scale mode error! Use scaled or unscaled.');
    end

    m = a./b;
    
    if any(isnan(m))
        switch scaleMode
            case 'scaled'
                m(isnan(m)) = sum(y_feature./h(1,:)')/sum(1./h(1,:));
            case 'unscaled'
                m(isnan(m)) = sum(y_feature);
        end
    end

    if nargout > 1
        switch scaleMode
            case 'unscaled'
                dK = -u./h.*dK;

                da = dK.*(ones(m_u,1)*y_feature');
                db = dK;
            case 'scaled'
                dKh = -1./(h.^2).*(u.*dK + K);

                da = dKh.*(ones(m_u,1)*y_feature');
                db = dKh;
        end

        if numel(h) == 1
            da = sum(da,2);
            db = sum(db,2);
        else
            a = a*ones(1,n_u);
            b = b*ones(1,n_u);
        end

        dm = (1./b).*da-(a./(b.^2)).*db;
        
        if sum(isnan(dm)) ~= 0
            dm(isnan(dm)) = 0;
        end
        
        if sum(isinf(dm)) ~= 0
            dm(isinf(dm)) = 0;
        end
    end
    
    if nargout > 2
        switch scaleMode
            case 'unscaled'
                ddK = u./(h.^2).*(2*dK+u.*ddK);

                dda = ddK.*(ones(m_u,1)*y_feature');
                ddb = ddK;
            case 'scaled'
                ddKh = -1./(h.^3).*(u.*dK + K)-u./h.*(dKh+u.*ddK);

                dda = ddKh.*(ones(m_u,1)*y_feature');
                ddb = ddKh;
        end

        if numel(h) == 1
            dda = sum(dda,2);
            ddb = sum(ddb,2);
        end

        ddm = (dda.*b-2*da.*db-a.*ddb)./(b.^2) + (a.* db.^2)./(b.^3);
        
        if any(isnan(ddm))
            switch scaleMode
                case 'scaled'
                    ddm(isnan(ddm)) = -sum(y_feature./h(1,:)')/sum(1./h(1,:));
                case 'unscaled'
                    ddm(isnan(ddm)) = -sum(y_feature);
            end
        end
    end
end
