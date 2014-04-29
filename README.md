# Kernel Regression

A tiny functions collection to do some machine learning research on multidimensional datasets.

## What does my kernel_regression

Kernel Regression is a nonparametric regression concept that produces its own hypothesis. The given feature dataset {x, y} will be used to generate the hypothesis. A kernel function K(u) evaluates the significance of the several feature points. The hypothesis will be calculated based on the Nadaraya-Watson-Estimator-Concept m_i = sum(y_j Kh(u_ij))/sum(Kh(u_ij)). As cost function the mean-squared-error (MSE) is implemented.

My kernel regression supports different modes for parametrizing the kernel function. Its possible to use a general bandwidth h over all feature points or to optimize separately for each. Also you can choose if you want to use a scaled Kh(u) = 1/h*K(u) or unscaled kernel function K(u). As kernel function the common ones are implemented (gaussian, cauchy, picard, uniform, triangle, cosinus and epanechnikov). Own kernel functions can be built in.

**The detailed documentation will be online soon. I'm only a beginner on Github and have to learn many things about this. Till today I programmed only for myself and so this is my first try. Please be considerately, I will do my best**