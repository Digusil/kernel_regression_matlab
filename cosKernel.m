function [K, dK, ddK] = cosKernel(u)
    indeces_u = abs(u) > 1;

    K = pi/4 * cos(pi/2 * u);
    K(indeces_u) = 0;
    
    if nargout > 1
        dK = -pi^2/8 * sin(pi/2 * u);
        dK(indeces_u) = 0;
    end
    
    if nargout > 2
        ddK = -pi^3/16 * cos(pi/2 * u);
        ddK(indeces_u) = 0;
    end
end
