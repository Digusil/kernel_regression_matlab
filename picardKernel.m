function [K, dK, ddK] = picardKernel(u)
    K = 1/2 * exp(-abs(u));

    if nargout > 1
        dK = -sign(u) .* K;
    end  
    
    if nargout > 2
        ddK = K;
    end  
end
