function [K, dK, ddK] = epanechnikovKernel(u, p)
    indeces_u = abs(u) > 1;
    u(indeces_u) = sign(u(indeces_u));

    switch p
        case 1
            Cp = 3/4;
        case 2
            Cp = 15/16;
        case 3
            Cp = 35/32;
        otherwise
            error('Wrong parameter for the Epanechnikov kernel! p is element of the vector [1,2,3].')
    end

    K = Cp * (1-u.^2).^p;

    if nargout > 1
        dK = -2 * p * Cp * u .* (1-u.^2).^(p-1);
    end  
    
    if nargout > 2
        ddK = 2 * p * Cp *(2*u.^2*(p-1).*(1-u.^2).^(p-2) -(1-u.^2).^(p-1));
    end   
end
