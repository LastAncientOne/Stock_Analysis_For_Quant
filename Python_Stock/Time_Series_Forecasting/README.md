<img src="Time_Series.PNG">

# Time Series Forecasting in Python

## Description:  
Time series forecasting is use for scientific predictions based on historical time stamped data. Building or developing models through historical data analysis and using them to make observations and drive future strategic decision-making.  

Time series analysis is a statistical technique that analyze time series data or trend data. Time series data is a group of observations on a single entity over time; for example, the daily closing prices over one year for a single financial security.  

## Purpose:  
To make the data from non-stationary to time series stationary.  

#### ARIMA Models  
ARIMA (Auto Regressive Integrated Moving Average) is a class of models that explains a given time series based on its own past values. The lags and the lagged forecast errors is the equation that can be used to forecast future values.  

### Auto Regressive (AR only) model Equations:  
<img src="https://latex.codecogs.com/svg.image?Y_{t}&space;=&space;\alpha&space;&plus;&space;\beta_{1}Y_{t-1}&space;&plus;&space;\beta_{2}Y_{t-2}&space;&plus;&space;...&space;&plus;&space;\beta_{p}Y_{t-p}&space;&plus;&space;\epsilon_{1}" title="Y_{t} = \alpha + \beta_{1}Y_{t-1} + \beta_{2}Y_{t-2} + ... + \beta_{p}Y_{t-p} + \epsilon_{1}" width="600" height="100">
   
#### Moving Average (MA only) model is one where Yt depends only on the lagged forecast errors.  

### Moving Average (MA only) model Equations:  
<img src="https://latex.codecogs.com/svg.image?Y_{t}&space;=&space;\alpha&space;&space;&plus;&space;\epsilon_{t}&space;&plus;&space;\phi_{1}\epsilon_{t-1}&space;&plus;&space;\phi_{2}\epsilon_{t-2}...&plus;&space;\phi_{q}\epsilon_{t-q}" title="Y_{t} = \alpha + \epsilon_{t} + \phi_{1}\epsilon_{t-1} + \phi_{2}\epsilon_{t-2}...+ \phi_{q}\epsilon_{t-q}" width="600" height="100">  

### Error Terms   

#### Error terms are the errors of the autoregressive models of the respective lags.  

### Error Terms Equations:    

<img src="https://latex.codecogs.com/svg.image?Y_{t}&space;=&space;\beta_{1}Y_{t-1}&space;&plus;&space;\beta_{2}Y_{t-2}&space;&plus;&space;...&space;&plus;&space;\beta_{0}Y_{0}&space;&plus;&space;\varepsilon_{t}" title="Y_{t} = \beta_{1}Y_{t-1} + \beta_{2}Y_{t-2} + ... + \beta_{0}Y_{0} + \varepsilon_{t}" width="600" height="100">  

<img src="https://latex.codecogs.com/svg.image?Y_{t-1}&space;=&space;\beta_{1}Y_{t-2}&space;&plus;&space;\beta_{2}Y_{t-3}&space;&plus;&space;...&space;&plus;&space;\beta_{0}Y_{0}&space;&plus;&space;\varepsilon_{t-1}" title="Y_{t-1} = \beta_{1}Y_{t-2} + \beta_{2}Y_{t-3} + ... + \beta_{0}Y_{0} + \varepsilon_{t-1}" width="600" height="100">  

### ARIMA  
ARIMA is a model where the time series was differenced at least once to make it stationary; therefore, you combine the AR and the MA terms. 

### ARIMA Equations:    
<img src="https://latex.codecogs.com/svg.image?Y_{t}&space;=&space;\alpha&space;&plus;&space;\beta_{1}Y_{t-1}&space;&plus;&space;\beta_{2}Y_{t-2}&space;&plus;&space;...&space;&plus;&space;\beta_{p}Y_{t-p}\epsilon_{t}&space;&plus;&space;\phi_{1}\epsilon_{t-1}&space;&plus;&space;\phi_{2}\epsilon_{t-2}&space;&plus;&space;...&space;&plus;&space;\phi_{q}\epsilon_{t-q}" title="Y_{t} = \alpha + \beta_{1}Y_{t-1} + \beta_{2}Y_{t-2} + ... + \beta_{p}Y_{t-p}\epsilon_{t} + \phi_{1}\epsilon_{t-1} + \phi_{2}\epsilon_{t-2} + ... + \phi_{q}\epsilon_{t-q}" width="1000" height="100">  
  
  
## Libraries:  

### Darts  
https://github.com/unit8co/darts  
from darts import TimeSeries  
from darts.models import ExponentialSmoothing  

### Orbit  
https://orbit-ml.readthedocs.io/en/stable/  
https://github.com/uber/orbit  
import orbit  
from orbit.eda import eda_plot    

### Prophet  
https://facebook.github.io/prophet/  
https://github.com/facebook/prophet  
from prophet import Prophet  

### Pastas  
https://pastas.readthedocs.io/en/latest/index.html  
https://github.com/pastas/pastas  
import pastas as ps  

### PyAF  
https://github.com/antoinecarme/pyaf  
import pyaf.ForecastEngine as autof   

## Author  
### * Tin Hang  

## 🔴 Warning: This is not financial advisor.  Do not use this to invest or trade. It is for educational purpose.  
