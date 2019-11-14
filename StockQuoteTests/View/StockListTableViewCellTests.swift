//
//  StockListTableViewCellTests.swift
//  StockQuoteTests
//
//  Created by Ernest Fan on 2019-11-14.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import XCTest
@testable import StockQuote

class StockListTableViewCellTests: XCTestCase {

    var sut: StockListTableViewCell!
    var stockViewModel: StockViewModel!
    
    override func setUp() {
        super.setUp()
        
        sut = StockListTableViewCell()
        
        let symbol = "MSFT"
        
        let attributes = [
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
        
        stockViewModel = StockViewModel(stock: stock)
    }

    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testStockViewModelDidSet() {
        sut.stockViewModel = stockViewModel
        
        XCTAssertEqual(sut.symbolLabel.text, stockViewModel.symbol)
        XCTAssertEqual(sut.priceLabel.text, stockViewModel.displayTextForPrice())
        XCTAssertEqual(sut.priceChangeLabel.text, stockViewModel.displayTextForPriceChange())
    }
}
