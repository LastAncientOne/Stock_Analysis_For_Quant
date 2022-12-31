<img src="Time_Series.PNG">

# Time Series Forecasting in Python

## Description:  
Time series forecasting is use for scientific predictions based on historical time stamped data. Building or developing models through historical data analysis and using them to make observations and drive future strategic decision-making.  

Time series analysis is a statistical technique that analyze time series data or trend data. Time series data is a group of observations on a single entity over time; for example, the daily closing prices over one year for a single financial security.  

Time series analysis shows how data changes over time, and forecasting can identify the direction in which the data is changing.  

## Purpose:  
A time series is a dataset that helps to identifying the nature of the phenomenon represented by the sequence of observations, and forecasting (predicting future values of the time series variable).   

### Step-by-Step:
(1) Making Data Stationary  
(2) Building Your Time Series Model  
(3) Evaluating Model Accuracy  

### Components of Time Series Analysis   
(1) Trend  
(2) Seasonality   
(3) Cyclical  
(4) Irregularity  

#### ARIMA Models  
ARIMA (Auto Regressive Integrated Moving Average) is a class of models that explains a given time series based on its own past values. The lags and the lagged forecast errors is the equation that can be used to forecast future values. 

ARIMA model has 3 characterized terms: p, d, q.  

The 'p' is the order of the AR term, 'q' is the order of the MA term, and 'd' is the number of differencing required to make the time series stationary.

If a time series, has seasonal patterns, then you need to add seasonal terms and it becomes SARIMA, short for ‘Seasonal ARIMA’. More on that once we finish ARIMA.  

In time series, the first step to build an ARIMA model is to make the time series stationary. The most common method is to defference it. For example, subtract the previous value from the current value.  However, the data might need more than one differencing because the complexity of the series. The value of 'd' is the minimum number of differencing needed to make the series stationary. If the time series is already stationary, then d = 0. The 'p' is the order of the 'Auto Regressive' (AR) term and is the number of lags of Y to be used as predictors. The 'q' is the order of the 'Moving Average' (MA) term and is the number of lagged forecast errors that should go into the ARIMA Model.        

### Auto Regressive (AR only) model Equations:  
<img src="https://latex.codecogs.com/svg.image?Y_{t}&space;=&space;\alpha&space;&plus;&space;\beta_{1}Y_{t-1}&space;&plus;&space;\beta_{2}Y_{t-2}&space;&plus;&space;...&space;&plus;&space;\beta_{p}Y_{t-p}&space;&plus;&space;\epsilon_{1}" title="Y_{t} = \alpha + \beta_{1}Y_{t-1} + \beta_{2}Y_{t-2} + ... + \beta_{p}Y_{t-p} + \epsilon_{1}" width="600" height="100">
   
#### Moving Average (MA only) model is one where Yt depends only on the lagged forecast errors.  

### Moving Average (MA only) model Equations:  
<img src="https://latex.codecogs.com/svg.image?Y_{t}&space;=&space;\alpha&space;&space;&plus;&space;\epsilon_{t}&space;&plus;&space;\phi_{1}\epsilon_{t-1}&space;&plus;&space;\phi_{2}\epsilon_{t-2}...&plus;&space;\phi_{q}\epsilon_{t-q}" title="Y_{t} = \alpha + \epsilon_{t} + \phi_{1}\epsilon_{t-1} + \phi_{2}\epsilon_{t-2}...+ \phi_{q}\epsilon_{t-q}" width="600" height="100">  

### Error Terms   
Error terms are the errors of the autoregressive models of the respective lags.  

### Error Terms Equations:    

<img src="https://latex.codecogs.com/svg.image?Y_{t}&space;=&space;\beta_{1}Y_{t-1}&space;&plus;&space;\beta_{2}Y_{t-2}&space;&plus;&space;...&space;&plus;&space;\beta_{0}Y_{0}&space;&plus;&space;\varepsilon_{t}" title="Y_{t} = \beta_{1}Y_{t-1} + \beta_{2}Y_{t-2} + ... + \beta_{0}Y_{0} + \varepsilon_{t}" width="600" height="100">  

<img src="https://latex.codecogs.com/svg.image?Y_{t-1}&space;=&space;\beta_{1}Y_{t-2}&space;&plus;&space;\beta_{2}Y_{t-3}&space;&plus;&space;...&space;&plus;&space;\beta_{0}Y_{0}&space;&plus;&space;\varepsilon_{t-1}" title="Y_{t-1} = \beta_{1}Y_{t-2} + \beta_{2}Y_{t-3} + ... + \beta_{0}Y_{0} + \varepsilon_{t-1}" width="600" height="100">  

### ARMA  
ARMA (Auto Regressive Moving Average) is a model that is combined from the AR and MA models. In this model, the impact of previous lags along with the residuals is considered for forecasting the future values of the time series.  

### ARMA Equations:
<img src="https://latex.codecogs.com/svg.image?Y_{t}&space;=&space;c&space;&plus;&space;\sum_{i=1}^{p}\phi&space;_{i}Y_{t-i}&space;&plus;&space;\sum_{i=1}^{q}\theta_{i}\epsilon&space;_{t-1}&plus;\epsilon_{t}" title="Y_{t} = c + \sum_{i=1}^{p}\phi _{i}Y_{t-i} + \sum_{i=1}^{q}\theta_{i}\epsilon _{t-1}+\epsilon_{t}" width="1000" height="100">

### ARIMA  
ARIMA is a model where the time series was differenced at least once to make it stationary; therefore, you combine the AR and the MA terms. 

### ARIMA Equations:    
<img src="https://latex.codecogs.com/svg.image?Y_{t}&space;=&space;\alpha&space;&plus;&space;\beta_{1}Y_{t-1}&space;&plus;&space;\beta_{2}Y_{t-2}&space;&plus;&space;...&space;&plus;&space;\beta_{p}Y_{t-p}\epsilon_{t}&space;&plus;&space;\phi_{1}\epsilon_{t-1}&space;&plus;&space;\phi_{2}\epsilon_{t-2}&space;&plus;&space;...&space;&plus;&space;\phi_{q}\epsilon_{t-q}" title="Y_{t} = \alpha + \beta_{1}Y_{t-1} + \beta_{2}Y_{t-2} + ... + \beta_{p}Y_{t-p}\epsilon_{t} + \phi_{1}\epsilon_{t-1} + \phi_{2}\epsilon_{t-2} + ... + \phi_{q}\epsilon_{t-q}" width="1000" height="100">
  
## Error Metrics:   

(1) Mean Absolute Error (MAE) is useful when absolute error needs to be measured. It is easy to understand but it is not efficient when data has extreme values.  
(2) Mean Absolute Percentage Error (MAPE) is used when different forecast models or datasets need to be compared because this is a percentage value. MAPE is also easy to understand. MAPE suffers from the same disadvantage as MAE. MAPE is not efficient when data has extreme values.  
(3) Mean Squared Error (MSE) is useful when spread of the forecast values is important and larger values need to be penalized. However, this metrics is often difficult to interpret because it is a squared value.  
(4) Root Mean Squared Error (RMSE) is also useful when spread is of importance and larger values need to be penalized. RMSE is easier to interpret when compared to MSE because the RMSE value is of the same scale as the forecasted values.  
(5) Normalized Root Mean Squared Error (NRMSE) is extension of RMSE and is calculated by normalizing RMSE. There are two popular methods for normalizing RMSE that is using mean or using the range of the true values (difference of minimum and maximum values).  
(6) Weighted Absolute Percentage Error (WAPE) is useful when dealing with low volume data as it is calculated by weighting the error over total true values.  
(7) Weighted Mean Absolute Percentage Error (WMAPE) is also useful when dealing with low volume data. WMAPE helps to incorporate the priority by utilizing the weight (priority value) of each observation.  
  
## Libraries:  

### Arch  
https://github.com/bashtage/arch/  
from arch import arch_model  

### Autotos
https://github.com/winedarksea/AutoTS  
from autots import AutoTS, load_daily  

### Darts  
https://github.com/unit8co/darts  
https://winedarksea.github.io/AutoTS/build/html/source/tutorial.html  
from darts import TimeSeries  
from darts.models import ExponentialSmoothing  

### Orbit  
https://github.com/uber/orbit  
https://orbit-ml.readthedocs.io/en/stable/  
import orbit  
from orbit.eda import eda_plot    

### Prophet  
https://github.com/facebook/prophet  
https://facebook.github.io/prophet/  
from prophet import Prophet  

### Pastas  
https://github.com/pastas/pastas  
https://pastas.readthedocs.io/en/latest/index.html  
import pastas as ps  

### PyAF  
https://github.com/antoinecarme/pyaf  
https://notebook.community/antoinecarme/pyaf/docs/PyAF_Introduction  
import pyaf.ForecastEngine as autof   

### PyFlux  
https://github.com/RJT1990/pyflux  
https://pyflux.readthedocs.io/en/latest/index.html  
import pyflux as pf  

### Skforecast
https://github.com/JoaquinAmatRodrigo/skforecast/
https://joaquinamatrodrigo.github.io/skforecast/0.4.3/index.html  
from skforecast.ForecasterAutoreg import ForecasterAutoreg  
from skforecast.ForecasterAutoregCustom import ForecasterAutoregCustom  
from skforecast.ForecasterAutoregMultiOutput import ForecasterAutoregMultiOutput  
from skforecast.model_selection import grid_search_forecaster  
from skforecast.model_selection import backtesting_forecaster  

### statsmodels
https://github.com/statsmodels/statsmodels   
https://www.statsmodels.org/stable/index.html  
import statsmodels.api as sm  
import statsmodels.formula.api as smf  

## Credits:
### Creators who creates programming libraries for people to use.  

## Author  
### * Tin Hang  

## 🔴 Warning: This is not financial advisor.  Do not use this to invest or trade. It is for educational purpose.  
