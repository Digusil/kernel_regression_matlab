function [K, dK, ddK] = triangleKernel(u)
    indeces_u = abs(u) > 1;

    K = 1-abs(u);
    K(indeces_u) = 0;

    if nargout > 1
        dK = -sign(u);
        dK(indeces_u) = 0;
    end
    
    if nargout > 2
        ddK = zeros(size(u));
        ddK(indeces_u) = 0;
    end
end
