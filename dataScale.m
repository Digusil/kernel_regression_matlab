function [y, mu, sigma] = dataScale(x, mu, sigma)
    m = size(x,1);
    
	if nargin == 1
	    mu = mean(x,1);
	    sigma = std(x,[],1);
	end
    
    y = (x-ones(m,1)*mu)./(ones(m,1)*sigma);
end
