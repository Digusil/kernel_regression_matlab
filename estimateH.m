function [h_est, rho] = estimateH(x)

    [m, n] = size(x);

    x2 = sum(x.^2, 2);
    u = sqrt(abs(bsxfun(@plus, x2, bsxfun(@plus, x2', - 2 * (x * x')))));
    
%     h_est = 0.35./(m.^0.2)*median(u(:));
%    h_est = 0.178 * m^-0.2597 * n^0.8986 * median(u(:));
    h_est = 0.22 * m^-0.185 * n^0.45 * median(u(:));
    
    if nargout > 1
        rho = 1/m* sum(u,2);
    end

end
