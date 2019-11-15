# StockQuote

An universal iOS application that retrieve real-time details about a random set of stocks.

### Requirements

1) Test Driven Development - Unit Testing & UI Testing

2) Universal - works on iPhone & iPad in any orientation

3) Use UITableview to display stock symbals and current trading price

4) Create a detail view controller to display details of a stock (eg. high, low, average etc)

5) Use any network library to retrieve data in JSON format



------
### Third-Party Libraries/Frameworks/Services

Alamofire 
  - retrieve data from API endpoint

SwiftyJSON
  - decode JSON data
  
Swifter
  - stubs network request for UI Testing

Alpha Vantage
  - API Service Provider (eg. https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=demo)



------
### Important Note

Alpha Vantage API service allows only 5 API requests per minute.

A timer is implemented in order to resume failed network requests once the time limit is reached.

Tap on a stock(tableview cell) with no data will immediately request the data.

If success, the stock detail will be present.

Or else, an error alert will pop up.



------
### Main Components

Stock
  - Model to store stock quote data received from API service

StockViewModel
  - View Model for stock list display usage

StockListTableViewController
  - Primary ViewController to display stock info and current trading price
  - Request stock quote from API service
  - Notify user on network request status
  - Store and handle pending network request
  
StockDetailViewController
  - ViewController to display stock details with given Stock data
  
StockAPIService
  - Singleton to make network request and response with decoded data
