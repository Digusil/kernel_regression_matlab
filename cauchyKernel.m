function [K, dK, ddK] = cauchyKernel(u)
    K = 1./(pi*(1+u.^2));

    if nargout > 1
        dK = -2 *u ./ (1+u.^2) .* K;
    end 
    
    if nargout > 2
        ddK = (-2*(1+u.^2).^2 + 8*u.^2)./(pi * (1+u.^2).^3);
    end 
end
