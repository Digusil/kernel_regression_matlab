function u = krFeature(x, x_feature)

    X2 = sum(x_feature.^2, 2);
    x2 = sum(x.^2, 2);
    
    u = sqrt(abs(bsxfun(@plus, x2, bsxfun(@plus, X2', - 2 * (x * x_feature')))));

end
