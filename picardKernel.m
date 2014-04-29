function [K, dK] = picardKernel(u)
	K = 1/2 * exp(-abs(u));

	if nargout > 1
		dK = -sign(u) .* K;
	end  
end
