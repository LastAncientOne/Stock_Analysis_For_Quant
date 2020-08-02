<img src="Options_Titles.PNG">

# Python for Options Trading and Investment

## Description:  
Learning about options trading in python.

## What is options?  
Options is a contract that gives the buyer the right, but not the oblication, to buy or sell an underlying asset at a specified strike price to a specified date.  

### List of different types of analyzing options and options strategies  
Options analysis is a method for investors use for to buy call and put; therefore, traders make decision in buying and selling. 

### Two types of options:
1.) American options can be exercised at any time between the date of purchase and the expiration date.  
2.) European options are different from American options in that they can only be exercised at the end of their lives on their expiration date.  

#### Call option gives the holder the right to buy a stock.  
#### Put opton gives the holder the right to sell a stock.   

#### Risk-neutral Probability  
- Probability of future outcomes adjusted for risk. There are two main assumptions behind this concept:  
1.) The current value of an asset is equal to its expected payoff discounted at the risk-free rate.  
2.) There are no arbitrage opportunities in the market.  

#### Binomial Option Pricing Model  
- The simplest method to price the options for this model. This model uses the assumption of perfectly efficient market; however, the model can price the option at each point of a specified time frame. The binomial model, we consider that the price of the underlying asset will either go up or down in the period. Given the possible prices of the underlying asset and the strike price of an option, we can calculate the payoff of the option under these scenarios, then discount these payoffs and find the value of that option as of today.  

### Brokerages to represent  
#### "buy to open"
- to buy long call or put options in the underlying security. The option premium is immediately debited from your account.  
#### "sell to open" 
- selling or establishing a short position in an option. Options writing and collect premium because selling the rights of the option to another market participant.  
#### "sell to close" 
- used to exit a trade in which the trader already owns the options contract and must sell the contract to close the position. Traders "sell to close" call options contracts they own when they no longer want to hold a long bullish position on the underlying asset(Investopedia).  
#### "buy to close" 
- a trader is net short an option position and wants to exit that open position. In other words, they already have an open position, by way of writing an option, for which they have received a net credit, and now seek to close that position (Investopedia).  


### Understanding Binary Basics  
####  At the money (ATM) 
- is an option whose strike price is near where the stock price is currently; therefore, primarily made up of intrinsic value, with very little extrinsic value.  
#### In the Money (ATM) 
- is an option whose strike price is below where the stock price is currently; as a result, it has little to no intrinsic value.    
#### Out of the Money (OTM) 
- is an option with strike price is above where the stock price is currently and the option is made up of entirely extrinsic value.  


<img src="Cheatsheet_Options.PNG">  
  
## Options Strategies    
1. Long Call
2. Long Put
3. Short Put
4. Covered Call  
5. Married Put  
6. Bull Call Spread  
7. Bear Put Spread  
8. Protective Collar  
9. Long Straddle  
10. Long Strangle  
11. Long Call Butterfly Spread  
12. Iron Condor  
13. Iron Butterfly    

<img src="FiveGreeks.PNG">    
<img src="OptionsGreek.PNG">    

## Options Greeks   
1. Delta - Measures change in option price when stock price moves  
2. Gamma - Measures change in delta when stock price moves  
3. Vega - Measures change in option price when volatility moves  
5. Theta - Decay in option price every day as the expiration gets nearer  
6. Rho - Measures change in option price when stock price moves  

## Black Scholes Model  
### Equations:  
<img src="BlackScholes.PNG">  
<img src="BlackScholes1.PNG">  
Black Scholes model or Black-Scholes-Merton (BSM) model, is a mathematical model for pricing an options contract. Therefore, the equation derives the price of a call option or put option.  

## Options Pricing
Intrinsic Value (Calls) = Current Stock Price - Stock Price  
Intrinsic Value (Puts) = Strike Price - Current Stock Price  
Time Value = Option Premium - Intrinsic Value  

https://www.investopedia.com/trading/options-strategies/

## Author:    
### Tin Hang  

## References:  
https://www.investopedia.com/trading/options-strategies/  
https://www.optionsplaybook.com/option-strategies/  

:red_circle: Warning: This is not financial advisor.  Do not use this to invest or trade. It is for educational purpose.  

