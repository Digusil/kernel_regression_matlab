function [K, dK, ddK] = cosKernel(u)
    indeces_u = abs(u) > 1;
    u(indeces_u) = sign(u(indeces_u));

    K = pi/4 * cos(pi/2 * u);

    if nargout > 1
        dK = -pi^2/8 * sin(pi/2 * u);
    end
    
    if nargout > 2
        ddK = -pi^3/16 * cos(pi/2 * u);
    end
end
