function [K ,dK, ddK] = uniformKernel(u)
    indeces_u = abs(u) > 1;
    u(indeces_u) = sign(u(indeces_u));

    K = 1/2 * ones(size(u));

    if nargout > 1
        dK = zeros(size(u));
    end
    
    if nargout > 2
        ddK = zeros(size(u));
    end
end
