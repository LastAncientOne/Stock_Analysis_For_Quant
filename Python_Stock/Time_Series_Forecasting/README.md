<img src="Time_Series.PNG">

# Time Series Forecasting in Python

## Description:  
Time series forecasting is use for scientific predictions based on historical time stamped data. Building or developing models through historical data analysis and using them to make observations and drive future strategic decision-making.  

Time series analysis is a statistical technique that analyze time series data or trend data. Time series data is a group of observations on a single entity over time; for example, the daily closing prices over one year for a single financial security.  

#### ARIMA Models  
ARIMA (Auto Regressive Integrated Moving Average) is a class of models that explains a given time series based on its own past values. The lags and the lagged forecast errors is the equation that can be used to forecast future values.  

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
