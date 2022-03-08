# Regression in R  
<img src="RegressionAnalysisR.PNG">


### Description:  
#### Regression Analysis is a statistical method that explore the relationship between two or more variables. There many different types of regression analysis; however, they all have one or more independent variables on a dependent variable.  

### MSE, MAE, RMSE, and R-Squared metrics are mainly used to evaluate the prediction error rates and model performance in regression analysis.  
| MSE / RSME | MAE| R2| 
| ----------------------- | ------------- | -------------| 
| Based on square of error      | Based on absolute value of error | Based on correlation between actual and predicted value|
| Value lies between 0 to infinity | Value lies between 0 to infinity  | Value lies between 0 and 1 |
| Sensitive to outliers, punishes larger error more | Treat larger and small errors equally. Not sensitive to outliers | Not sensitive to outliers |
| Small value indicates better model | Small value indicates better model | Value near 1 indicates better model |



### Mean Squared Error (MSE)  
Mean Square Error (MSE) is a mean or average of the square of the difference between actual and estimated values.    
#### Equations:  
<img src="https://latex.codecogs.com/svg.image?MSE&space;=&space;\frac{1}{n}\sum_{i=1}^{n}(y_{i}&space;-&space;\hat{y_{i}})^{2}" title="MSE = \frac{1}{n}\sum_{i=1}^{n}(y_{i} - \hat{y_{i}})^{2}" width="300" height="100">  

MSE = mean squared error  
n = number of data points  
y_i = observed vales  
y ̂_i = predicted values  


### Root Mean Squared Error (RMSE)
Root Mean Square Error (MSE) is the residual (difference between prediction and truth) for each data point, compute the norm of residual for each data point, compute the mean of residuals and take the square root of that mean.  
#### Equations:  
<img src="https://latex.codecogs.com/svg.image?RMSE&space;=&space;\sqrt{\sum_{i=1}^{n}\frac{(y_{i}-\hat{y}_i)^{2}}{n}}" title="RMSE = \sqrt{\sum_{i=1}^{n}\frac{(y_{i}-\hat{y}_i)^{2}}{n}}" width="300" height="100">

RMSE = root-mean-squared error  
i = variable i   
n = number of non-missing data points  
x_i = actual observations time series  
x ̂_i = estimated time series  


### Mean Absolute Error (MAE)  
Mean Absolute Error (MAE) is a method to find the sum of the absolute difference between actual and predicted values.  
Equations:  
<img src="https://latex.codecogs.com/svg.image?MSE&space;=&space;\frac{1}{n}\sum_{i=1}^{n}(y_{i}&space;-&space;\hat{y_{i}})^{2}" title="MSE = \frac{1}{n}\sum_{i=1}^{n}(y_{i} - \hat{y_{i}})^{2}" width="300" height="100">  

MAE = mean absolute error  
n = total number of data points  
x_i = prediction  
y_i = true value  


### R Squared (R2)  
R2 or R Squared is a coefficient of determination and it is the total variance calculated by model/total variance.  

#### Equations:  
<img src="https://latex.codecogs.com/svg.image?R^{2}&space;=&space;1&space;-&space;\frac{RSS}{TSS}&space;=&space;1&space;-&space;\frac{\sum_{i}(y_{i}-\hat{y}_i)^2}{\sum_{i}(y_{i}-\bar{y}_i)^2}" title="R^{2} = 1 - \frac{RSS}{TSS} = 1 - \frac{\sum_{i}(y_{i}-\hat{y}_i)^2}{\sum_{i}(y_{i}-\bar{y}_i)^2}" width="400" height="100">  

<img src="https://latex.codecogs.com/svg.image?RSS&space;=&space;\sum_{i}^{n}(y_{i}-\hat{y}_i)^2" title="RSS = \sum_{i}^{n}(y_{i}-\hat{y}_i)^2" width="300" height="100">  
<img src="https://latex.codecogs.com/svg.image?TSS&space;=&space;\sum_{i}^{n}(y_{i}-\bar{y}_i)^2" title="TSS = \sum_{i}^{n}(y_{i}-\bar{y}_i)^2" width="300" height="100">  

R^2 = coefficient of determination  
RSS = sum of squares of residuals  
TSS = total sum of squares   


### Linear Regression  
Linear Regression is a linear model or linear regression algorithm, and mostly common used. The linear relationship between the input variables (x) and the single output variable (y). 
Use this model to predict numerical such as continuous and discrete data.  

(1) Simple Linear Regression – Single input variable (x)  
(2) Multiple Linear Regression – Multiple input variables (x)  

#### Equations:  
#### Linear Regression Equation  
<img src="https://latex.codecogs.com/svg.image?y&space;=&space;b_{0}&space;&plus;&space;b_{1}x" title="y = b_{0} + b_{1}x" width="200" height="50">   
<img src="https://latex.codecogs.com/svg.image?y&space;=&space;\alpha&space;&plus;&space;\beta&space;x" title="y = \alpha + \beta x" width="200" height="50">  

#### Mulitple Linear Regression Equation  
<img src="https://latex.codecogs.com/svg.image?y&space;=&space;b_{0}&space;&plus;&space;b_{1}x_{1}&space;&plus;&space;b_{2}&space;x_{2}&space;&plus;&space;...&space;&plus;&space;b_{n}&space;x_{n}" title="y = b_{0} + b_{1}x_{1} + b_{2} x_{2} + ... + b_{n} x_{n}" width="500" height="50">   

#### Polynomial Linear Regression Equation  
<img src="https://latex.codecogs.com/svg.image?y&space;=&space;b_{0}&space;&plus;&space;b_{1}x_{1}&space;&plus;&space;b_{2}x_{1}^{2}&space;&plus;&space;...&space;&plus;&space;b_{n}x_{1}^{n}&space;" title="y = b_{0} + b_{1}x_{1} + b_{2}x_{1}^{2} + ... + b_{n}x_{1}^{n}" width="500" height="50">  

### Logistic Regression
Logistic Regression is a predictive modelling algorithm.  Use this model to predict the class or category.  

#### Equations: 
<img src="https://latex.codecogs.com/svg.image?p&space;=&space;\frac{1}{e^-(b_{0}&space;&plus;&space;b_{1}*x)}" title="p = \frac{1}{e^-(b_{0} + b_{1}*x)}" width="300" height="100">   


### Decision Tree
Decision Tree is algorithm that decide to split a node into two or more sub-nodes and is a diagram or chart that helps determine the course of action or show a statistical probability.     
Use this model to predict numerical such as class and category or continuous and discrete data.  
(1)	Categorical Variable Decision Tree – Class or Category data  
(2)	Continuous Variable Decision Tree – Continuous or Discrete data  

### Information Theory    
Information theory studies the quantification of information, its storage, and communication. There are two concepts that are used to construct a decision tree using ID3 algorithm is called information entropy and information gain.    
### Information Entropy  
Information Entropy is a measurement of the smallest amount of information to represent a data item from that data.  
### Information Gain  
Information Gain is calculated for a split by subtracting the weighted entropies of each branch from the original entropy. When training a Decision Tree using these metrics, the best split is chosen by maximizing Information Gain.  


#### Equations:  
<img src="https://latex.codecogs.com/svg.image?E(S)&space;=&space;\sum_{i=1}^{c}&space;-p_{i}log_{2}p_{i}&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;" title="E(S) = \sum_{i=1}^{c} -p_{i}log_{2}p_{i} " width="300" height="100">  

<img src="https://latex.codecogs.com/svg.image?Gain(T,&space;X)&space;=&space;Entropy(T)&space;-&space;Entropy(T,X)" title="Gain(T, X) = Entropy(T) - Entropy(T,X)" width="500" height="50">  
<img src="https://latex.codecogs.com/svg.image?Entropy(T,&space;X)&space;=&space;\sum_{v\in&space;&space;Values(A)}^{}\frac{\left|&space;S_{v}\right|}{\left|S&space;\right|}Entropy(S_{v})" title="Entropy(T, X) = \sum_{v\in Values(A)}^{}\frac{\left| S_{v}\right|}{\left|S \right|}Entropy(S_{v})" width="500" height="100">

### Bayesian Linear Regression  
Bayesian Linear Regression is algorithm that uses probability distributions rather than point estimates. Use the model to predict the continuous or category. 

#### Equations:  

<img src="https://latex.codecogs.com/svg.image?y&space;=&space;\beta&space;_{0}&space;&plus;&space;&space;\beta&space;_{1}x_{1}&space;&plus;&space;\beta&space;_{2}x_{2}&space;&plus;&space;\epsilon&space;" title="y = \beta _{0} + \beta _{1}x_{1} + \beta _{2}x_{2} + \epsilon " width="500" height="60">  

### Elastic Net Regression
Ordinal Logistic Regression is algorithm uses a weighted combination of L1 and L2 regularization. Use this model to predict continuous data. 

#### Equations:  

<img src="https://latex.codecogs.com/svg.image?L_{enet}(&space;\hat{\beta})&space;=&space;\frac{\sum_{i-1}^{n}\left&space;(&space;y_{i}&space;-&space;x_{i}^{j}\hat{\beta}\right&space;&space;)^{2}}{2n}&space;&plus;&space;\lambda&space;(\frac{1-\alpha&space;}{2}\sum_{j=1}^{m}\hat{\beta}_{j}^{2}&space;&plus;&space;\alpha&space;\sum_{j=1}^{m}\left|\hat{\beta}_{j}\right|)" title="L_{enet}( \hat{\beta}) = \frac{\sum_{i-1}^{n}\left ( y_{i} - x_{i}^{j}\hat{\beta}\right )^{2}}{2n} + \lambda (\frac{1-\alpha }{2}\sum_{j=1}^{m}\hat{\beta}_{j}^{2} + \alpha \sum_{j=1}^{m}\left|\hat{\beta}_{j}\right|)" width="700" height="100">  

### Quantile Regression  
Ordinal Logistic Regression is algorithm and is used for finding the relationships between variables outside of the mean of the data.  Also, it is useful in understanding outcomes that are non-normally distributed and that have nonlinear relationships with predictor variables. Use this model to predict continuous or classification data.  

#### Equations:    

<img src="https://latex.codecogs.com/svg.image?Q_{\tau}(y_{i})&space;=&space;\beta&space;_{0}(\tau&space;)&space;&plus;&space;\beta&space;_{1}(\tau&space;)x_{i1}&space;&plus;&space;...&space;&plus;&space;\beta&space;_{p}(\tau&space;)x_{ip}" title="Q_{\tau}(y_{i}) = \beta _{0}(\tau ) + \beta _{1}(\tau )x_{i1} + ... + \beta _{p}(\tau )x_{ip}" width="700" height="100">  

### Ordinal Regression  
Ordinal Logistic Regression is a method to use interactions between independent variables to predict the dependent variable.  
Use this model to predict an ordinal dependent variable given one or more independent variables.  

#### Equations:  
<img src="https://latex.codecogs.com/svg.image?In(\theta&space;_j)&space;=&space;\alpha&space;_j&space;-&space;\beta&space;X" title="In(\theta _j) = \alpha _j - \beta X" width="300" height="100">

### Random Forest Regression  
Random Forest Regression is algorithm that performed both classification and regression tasks with the use of multiple decision trees. The technique is called Bootstrap and Aggregation, commonly known as bagging.  
Use this model to predict continuous or categorical data.  

### Ridge Regression  
Ridge Regression is algorithm that used to analyses any data that suffers from multicollinearity and it performs L2 regularization. If the multicollinearity occurs in the model, least-squares are unbiased, and variances are large. Therefore, results in predicted values to be far away from the actual values. Use this model to predict continuous or categorical data.  

### Support Vector Machines  
Support Vector Machines is a supervised machine learning algorithm that performed both classification and regression. Also, is a linear model for classification and regression problems.  As a result, classification and regression. Use this model to predict continuous or categorical data.  
#### Equations:  
### * Minimize:  
<img src="https://latex.codecogs.com/svg.image?\frac{1}{2}\begin{Vmatrix}x\end{Vmatrix}^{2}&space;&plus;&space;C\sum_{i=1}^{N}(\xi&space;_{i}&plus;\xi&space;_{*}^{i})" title="\frac{1}{2}\begin{Vmatrix}x\end{Vmatrix}^{2} + C\sum_{i=1}^{N}(\xi _{i}+\xi _{*}^{i})" width="300" height="100">


### Tobit Regression    
Tobit Regression is algorithm is a class of regression models in the observed range of the dependent variable is censored in some way.  
Use this model to predict continuous or categorical data.   
#### Equations:  
<img src="https://latex.codecogs.com/svg.image?y_{i}^{*}&space;=&space;\beta&space;^{t}x_{i}&space;&plus;&space;e_{i}&space;" title="y_{i}^{*} = \beta ^{t}x_{i} + e_{i} " width="300" height="100">
<img src="https://latex.codecogs.com/svg.image?y_{i}&space;=&space;y_{i}^{*}&space;=&space;\begin{Bmatrix}&space;&space;y_{i}&space;=&space;y_{i}^{*}&space;&&space;if&space;&space;&&space;y_{i}^{*}&space;>&space;&space;0&space;&space;\\&space;y_{i}&space;=&space;0&space;&&space;if&space;&space;&&space;y_{i}^{*}&space;\leq&space;&space;0&space;\end{Bmatrix}" title="y_{i} = y_{i}^{*} = \begin{Bmatrix} y_{i} = y_{i}^{*} & if & y_{i}^{*} > 0 \\ y_{i} = 0 & if & y_{i}^{*} \leq 0 \end{Bmatrix}" width="300" height="100">

## Author:  
### * Tin Hang  
