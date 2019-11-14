//
//  StockViewModelTests.swift
//  StockQuoteTests
//
//  Created by Ernest Fan on 2019-11-13.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import XCTest
@testable import StockQuote

class StockViewModelTests: XCTestCase {
    
    var symbol: String!
    var attributes: [String: Any]!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        symbol = "MSFT"
        
        attributes = [
            "01. symbol": "MSFT",
            "02. open": "146.7400",
            "03. high": "147.4625",
            "04. low": "146.2800",
            "05. price": "146.7300",
            "06. volume": "8991011",
            "07. latest trading day": "2019-11-13",
            "08. previous close": "147.0700",
            "09. change": "-0.3800",
            "10. change percent": "-0.2584%"
        ]
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        symbol = nil
        attributes = nil
    }
    
    func testStockViewModelAttributes() {
        let stock = Stock(symbol: symbol, attributes: attributes)
        let stockViewModel = StockViewModel(stock: stock)
        
        XCTAssertEqual(stockViewModel.symbol, stock.symbol)
        XCTAssertEqual(stockViewModel.price, stock.price)
        XCTAssertEqual(stockViewModel.change, stock.change)
    }
    
    func testStockViewModelDisplayInfoWithNegativePriceChange() {
        // Normal Stock, negative price change
        let stock = Stock(symbol: symbol, attributes: attributes)
        let stockViewModel = StockViewModel(stock: stock)
        
        XCTAssertEqual(stockViewModel.displayTextForPrice(), "146.73")
        XCTAssertEqual(stockViewModel.displayTextForChange(), "-0.38")
    }
    
    func testStockViewModelDisplayInfoWithPositivePriceChange() {
        // Normal Stock, positive price change
        attributes["09. change"] = "+0.3800"
        let stock = Stock(symbol: symbol, attributes: attributes)
        let stockViewModel = StockViewModel(stock: stock)
        
        XCTAssertEqual(stockViewModel.displayTextForPrice(), "146.73")
        XCTAssertEqual(stockViewModel.displayTextForChange(), "+0.38")
    }
    
    func testStockViewModelDisplayInfoWithEmptyStock() {
        // Empty Stock
        let stock = Stock(symbol: symbol, attributes: [:])
        let emptyStockViewModel = StockViewModel(stock: stock)
        
        XCTAssertEqual(emptyStockViewModel.displayTextForPrice(), "")
        XCTAssertEqual(emptyStockViewModel.displayTextForChange(), "")
    }
}
