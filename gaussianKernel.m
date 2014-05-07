function [K, dK, ddK] = gaussianKernel(u)
    K = 1/sqrt(2*pi) * exp(-u.^2/2);

    if nargout > 1
        dK = -u .* K;
    end
    
    if nargout > 2
        ddK = (u.^2 -1) .* K;
    end
end
