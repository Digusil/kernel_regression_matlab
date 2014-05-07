function [K, dK, ddK] = triangleKernel(u)
    indeces_u = abs(u) > 1;
    u(indeces_u) = sign(u(indeces_u));

    K = 1-abs(u);

    if nargout > 1
        dK = -sign(u);
    end
    
    if nargout > 2
        ddK = zeros(size(u));
    end
end
