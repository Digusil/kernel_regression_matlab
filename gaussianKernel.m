function [K, dK] = gaussianKernel(u)
	K = 1/sqrt(2*pi) * exp(-u.^2/2);

	if nargout > 1
		dK = -u .* K;
	end
end
