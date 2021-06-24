# Options

BlackScholesModel <- function(type, S, K, r, T, vol){
  
  if(type=="c"){
    d1 <- (log(S/K) + (r + vol^2/2)*T) / (vol*sqrt(T))
    d2 <- d1 - vol*sqrt(T)
    
    value <- S*pnorm(d1) - K*exp(-r*T)*pnorm(d2)
    return(value)}
  
  if(type=="p"){
    d1 <- (log(S/K) + (r + vol^2/2)*T) / (vol*sqrt(T))
    d2 <- d1 - vol*sqrt(T)
    
    value <-  (K*exp(-r*T)*pnorm(-d2) - S*pnorm(-d1))
    return(value)}
}