fetchDataFromYahoo({'MSFT','SPY'})

function Price = fetchDataFromYahoo(ticker)
    c = yahoo;
    for i = 1:numel(ticker)
        Price.(ticker{i}) = fetch(c,ticker(i),'Adj Close','Jan 1 00','Apr 19 13','d');
    end
end

ndays=365;
lday=datenum(‘2014-04-01’)
[R,T,N,ntdays]=FetchQuandl(fname,ndays,lday);

