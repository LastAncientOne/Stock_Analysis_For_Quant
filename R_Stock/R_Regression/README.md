# Regression in R  
<img src="RegressionAnalysisR.PNG">


### Regression Analysis is a statistical method that explore the relationship between two or more variables. There many different types of regression analysis; however, they all have one or more independent variables on a dependent variable.  
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

#### Equations:  
<img src="https://latex.codecogs.com/svg.image?E(S)&space;=&space;\sum_{i=1}^{c}&space;-p_{i}log_{2}p_{i}&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;&space;" title="E(S) = \sum_{i=1}^{c} -p_{i}log_{2}p_{i} " width="300" height="100">


### Bayesian Linear Regression  
Bayesian Linear Regression is algorithm that uses probability distributions rather than point estimates. Use the model to predict the continuous or category. 

Equation

<img src="https://latex.codecogs.com/svg.image?y&space;=&space;\beta&space;_{0}&space;&plus;&space;&space;\beta&space;_{1}x_{1}&space;&plus;&space;\beta&space;_{2}x_{2}&space;&plus;&space;\epsilon&space;" title="y = \beta _{0} + \beta _{1}x_{1} + \beta _{2}x_{2} + \epsilon " width="500" height="60">  

### Elastic Net Regression
Ordinal Logistic Regression is algorithm uses a weighted combination of L1 and L2 regularization. Use this model to predict continuous data. 

Equation  

<img src="https://latex.codecogs.com/svg.image?L_{enet}(&space;\hat{\beta})&space;=&space;\frac{\sum_{i-1}^{n}\left&space;(&space;y_{i}&space;-&space;x_{i}^{j}\hat{\beta}\right&space;&space;)^{2}}{2n}&space;&plus;&space;\lambda&space;(\frac{1-\alpha&space;}{2}\sum_{j=1}^{m}\hat{\beta}_{j}^{2}&space;&plus;&space;\alpha&space;\sum_{j=1}^{m}\left|\hat{\beta}_{j}\right|)" title="L_{enet}( \hat{\beta}) = \frac{\sum_{i-1}^{n}\left ( y_{i} - x_{i}^{j}\hat{\beta}\right )^{2}}{2n} + \lambda (\frac{1-\alpha }{2}\sum_{j=1}^{m}\hat{\beta}_{j}^{2} + \alpha \sum_{j=1}^{m}\left|\hat{\beta}_{j}\right|)" width="700" height="100">  

### Quantile Regression  
Ordinal Logistic Regression is algorithm is used for finding the relationships between variables outside of the mean of the data, making it useful in understanding outcomes that are non-normally distributed and that have nonlinear relationships with predictor variables. Use this model to predict continuous or classification data.  

Equation  

<img src="https://latex.codecogs.com/svg.image?Q_{\tau}(y_{i})&space;=&space;\beta&space;_{0}(\tau&space;)&space;&plus;&space;\beta&space;_{1}(\tau&space;)x_{i1}&space;&plus;&space;...&space;&plus;&space;\beta&space;_{p}(\tau&space;)x_{ip}" title="Q_{\tau}(y_{i}) = \beta _{0}(\tau ) + \beta _{1}(\tau )x_{i1} + ... + \beta _{p}(\tau )x_{ip}" width="700" height="100">  

### Ordinal Regression  
Ordinal Logistic Regression is a method to use interactions between independent variables to predict the dependent variable.  
Use this model to predict an ordinal dependent variable given one or more independent variables.  

## Author:  
### * Tin Hang  
