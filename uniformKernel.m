function [K ,dK, ddK] = uniformKernel(u)
    indeces_u = abs(u) > 1;

    K = 1/2 * ones(size(u));
    K(indeces_u) = 0;

    if nargout > 1
        dK = zeros(size(u));
        dK(indeces_u) = 0;
    end
    
    if nargout > 2
        ddK = zeros(size(u));
        ddK(indeces_u) = 0;
    end
end
