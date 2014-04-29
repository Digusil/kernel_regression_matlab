function [K, dK] = cauchyKernel(u)
	K = 1./(pi*(1+u.^2));

	if nargout > 1
		dK = -2 *u ./ (1+u.^2) .* K;
	end  
end
