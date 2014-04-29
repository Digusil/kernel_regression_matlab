function [K, dK] = triangleKernel(u)
	indeces_u = abs(u) > 1;
	u(indeces_u) = sign(u(indeces_u));

	K = 1-abs(u);

	if nargout > 1
		dK = -sign(u);
	end
end
