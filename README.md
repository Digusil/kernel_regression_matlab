# Kernel Regression

A tiny functions collection to do some machine learning research on multidimensional datasets based on kernel regression.

## Why another regression system

Regression systems are useable tools to analyse datasets which conludes inputs and targets. Some of these kind of machine learning systems are based on hypothesis. The sucess is bounded to the qualitiy of the hypothesis. Often it is practical to define a specific hypothesis function with particular features, so that the dataset can be analysed on this features. In other cases the regression modell should fit the dataset as good as possible. In this case the hypothesis should *only* fit the data. An automaticly generated hypothesis is useable, if no special features are needed. 

## What does my kernel_regression

Kernel Regression is a nonparametric regression concept that produces its own hypothesis. The given feature tuples {x, y} will be used to generate the hypothesis. A kernel function K(u) evaluates the significance of the several feature points. The hypothesis will be calculated based on the Nadaraya-Watson-Estimator-Concept m_i = sum(y_j Kh(u_ij))/sum(Kh(u_ij)). As cost function the mean-squared-error (MSE) is implemented.

My kernel regression supports different modes for parametrizing the kernel function. Its possible to use a general bandwidth h over all feature points or to optimize separately for each. Also you can choose if you want to use a scaled Kh(u) = 1/h*K(u) or unscaled kernel function K(u). As kernel function the common ones are implemented (gaussian, cauchy, picard, uniform, triangle, cosinus and epanechnikov). Own kernel functions can be built in.

**The detailed documentation is in progress...**

## How to use it
The primary functionality of this collection.

### Split data
At the beginning it is important to split the dataset. If the same data is used for validation, testing and learning, the algorithm will gererate a solution with a high variance. The error for the the learning dataset would be minimized, but for new data the error will be quite bad. The function `splitDataRandom` split the whole date into differnt datasets in a radnom permutation. The function resutls a cell array. This cells contain a structure with the entries for the input and the target.

```matlab
data = splitDataRandom(inputs, targets, splitdistribution)
```

* inputs: oxk matrix; contains all input data
* targets: ox1 vactor; contains all target data
* splitdistribution: px1 vector; the distribution of the p resulting datasets in percent (normaly [60, 20, 20])

o is the number of all tuples  
k is the number of input features  
p is the number of splitted parts

data is a 1xp cell with the entries ".inputs" and ".targets". Example:
```matlab
data[3].inputs = x_test;
data[3].targets = y_test;
```

### Dimension reduction
This function evaluates each data point and sort them. Call the function `krReduceDim` to run the dimension reduction.

```matlab
[x_red, y_red] = krRedcDim(N, x_feature, y_feature)
```

* N: scalar in the range of 0 to 100; 
    * in the range of [0, 1[ the feature dimension will reduced by N*100%
    * in the range of [1, k] the feature diemension will be reduced by N
* x_feature: nxk matrix; contains the input data
* y_feature: nx1 matrix; contains the target data

m is the number of validation tuples  
k is the number of the input features

### Find the optimized hypothesis
For the first use you only need to call the function `learnKernelRegression`.

```matlab
h_opt = learnKernelRegression(x_val, y_val, x_learn, y_learn, kernelString, hMode, scaleMode, OptimOptions)
```

* x_val: mxk matrix; contains the input data to calculate the hypothesis values for the optimisation
* y_val: mx1 vector; contains the target date to evaluate the hypothesis for the optimisation
* x_learn: nxk matrix; contains the input data for the hypothesis
* y_learn: nx1 vector; contains the target data for the hypothesis
* kernelString: string; choose your kernel function (gaussian, cauchy, picard, uniform, triangle, cosinus, epanechnikov1, epanechnikov2, epanechnikov3)
* hMode: string; 'single' for a general bandwidth or 'multi' for a multiple bandwidth
* scaleMode: string; 'scaled' or 'unscaled' kernel function
* OptimOptions: struct; option set for the optimisation function (see optimset)

m is the number of validation tuples  
k is the number of the input features  
n is the number of the training tuples and the number of the hypothesis features  
h_opt is a scalar or a 1xn vector. These values are the optimized parameter for the hypothesis.


### Calculate new tuples
To calculate a new tuple set based on the optimized hypothesis call the function `nadarayaWatsonEstimator`.

```matlab
M = nadarayaWatsonEstimator(x, x_feature, y_feature, kernelFunction, h, scaleMode)
```

* x: mxk matrix; contains the input data to calculate the hypothesis values
* x_feature: nxk matrix; contains the input data for the hypothesis
* y_feature: nx1 vector; contains the target data for the hypothesis
* kernelString: function; use the same kernel function as in the function `learnKernelRegression`.
	* Example for 'gaussian' => @(u) gaussianKernel(u)
	* Example for 'epanechnikov1' => @(u) epanechnikovKernel(u, 1)
* h: scalar or 1xn vector; use the calculated h_opt here
* scaleMode: string; 'scaled' or 'unscaled' kernel function

m is the number of validation tuples  
k is the number of the input features  
n is the number of the training tuples and the number of the hypothesis features  
M is a  mx1 vector. These values are the estimated targets depending on the input data
