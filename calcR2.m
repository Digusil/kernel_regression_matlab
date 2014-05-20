function rSquare = calcR2(y_appr, y_true)
    y_mean = mean(y_true);
    
    tmp1 = y_true - y_appr;
    tmp2 = y_true - y_mean;
    
    rSquare = 1- (tmp1'*tmp1)/(tmp2'*tmp2);
end
