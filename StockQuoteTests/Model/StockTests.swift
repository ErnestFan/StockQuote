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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStockAttributes() {
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
        
        let stock = Stock(attributes: attributes)
        
        XCTAssertEqual(stock.symbol, "MSFT")
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

//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
