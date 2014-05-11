function [h_est, rho] = estimateH(x)

    [m, n] = size(x);

    u = krFeature(x, x);
    
    h_est = 0.22 * m^-0.185 * n^0.45 * median(u(:));
    
    if nargout > 1
        u(u==0) = NaN;
        rho = 1/m * min(abs(u),[],2).^n;
    end

end
