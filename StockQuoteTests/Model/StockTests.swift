//
//  StockTests.swift
//  StockQuoteTests
//
//  Created by Ernest Fan on 2019-11-13.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import XCTest
@testable import StockQuote

class StockTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testStockAttributes() {
        // Test Stock model with normal attributes
        let symbol = "MSFT"
        let attributes: [String: Any] = [
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
    
        let stock = Stock(symbol: symbol, attributes: attributes)
        
        XCTAssertEqual(stock.symbol, symbol)
        XCTAssertEqual(stock.open, 146.7400)
        XCTAssertEqual(stock.high, 147.4625)
        XCTAssertEqual(stock.low, 146.2800)
        XCTAssertEqual(stock.price, 146.7300)
        XCTAssertEqual(stock.volume, 8991011)
        XCTAssertEqual(stock.latestTradingDate, "2019-11-13")
        XCTAssertEqual(stock.previousClose, 147.0700)
        XCTAssertEqual(stock.change, -0.3800)
        XCTAssertEqual(stock.changePercentage, -0.2584)
    }
    
    func testStockEmptyAttributes() {
        // Test Stock model with empty attributes (eg. request returns nothing)
        let symbol = "MSFT"
        let attributes : [String: Any] = [:]
        
        let stock = Stock(symbol: symbol, attributes: attributes)
        
        XCTAssertEqual(stock.symbol, symbol)
        XCTAssertEqual(stock.open, 0.0)
        XCTAssertEqual(stock.high, 0.0)
        XCTAssertEqual(stock.low, 0.0)
        XCTAssertEqual(stock.price, 0.0)
        XCTAssertEqual(stock.volume, 0)
        XCTAssertEqual(stock.latestTradingDate, "")
        XCTAssertEqual(stock.previousClose, 0.0)
        XCTAssertEqual(stock.change, 0.0)
        XCTAssertEqual(stock.changePercentage, 0.0)
    }
}
