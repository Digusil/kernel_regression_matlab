function [y, mu, sigma] = dataScale(x, mode, mu, sigma)
    m = size(x,1);
    
    if nargin <= 2
        if nargin < 2
            mode = 'std';
        end
        
        
        switch mode
            case 'std'
                mu = mean(x,1);
                sigma = std(x,[],1);
            case 'range'
                mu = mean(x,1);
                sigma = range(x,1);
            case 'unsigned'
                mu = min(x,[],1);
                sigma = range(x,1);
            otherwise
                error('Wrong mode! Please use std or range')
        end
    end
    
    y = (x-ones(m,1)*mu)./(ones(m,1)*sigma);
end
