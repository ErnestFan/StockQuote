//
//  StockListTableViewControllerTests.swift
//  StockQuoteTests
//
//  Created by Ernest Fan on 2019-11-14.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import XCTest
@testable import StockQuote

class StockListTableViewControllerTests: XCTestCase {
    
    var stockSymbolArray: [String]!
    var sut: StockListTableViewController!

    override func setUp() {
        super.setUp()
        
        stockSymbolArray = ["MSFT", "GOOG", "AAPL", "NKE", "SBUX"]
        sut = StockListTableViewController(stocks: stockSymbolArray, style: .plain)
    }

    override func tearDown() {
        super.tearDown()
        
        stockSymbolArray = nil
        sut = nil
    }
    
    // MARK: - Table View
    
    func testControllerHasTableView() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView, "StockListController should have a tableview")
    }
    
    func testTableViewNumberOfSections() {
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
    }
    
    func testTableViewNumberOfRows() {
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), stockSymbolArray.count)
    }

    func testTableViewHasCells() {
        let cell = sut.tableView.dequeueReusableCell(withIdentifier: StockListTableViewCell.cellReuseIdentifier)
        
        XCTAssertNotNil(cell, "StockListController's tableview should be able to dequeue a reusable cell")
    }
    
    // MARK: - Pending Network Request
    
    func testPendingNetworkRequest() {
        XCTAssertEqual(sut.pendingNetworkRequest.count, 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        sut.addPendingNetworkRequest(with: indexPath, and: "")
        XCTAssertEqual(sut.pendingNetworkRequest.count, 1)
        
        sut.addPendingNetworkRequest(with: indexPath, and: "")
        XCTAssertEqual(sut.pendingNetworkRequest.count, 1, "Same request being added again should not change the count")
        
        sut.removePendingNetworkRequest(for: indexPath)
        XCTAssertEqual(sut.pendingNetworkRequest.count, 0)
    }
    
    // MARK: - Timer
    
    func testNetworkRequestTimer() {
        XCTAssertNil(sut.networkRequestTimer, "Timer should be nil")
        
        sut.enableNetworkRequestTimer()
        XCTAssertNotNil(sut.networkRequestTimer, "Timer should exist after adding pending request")
        if let timer = sut.networkRequestTimer {
            XCTAssertTrue(timer.isValid, "Timer should be valid")
        }
        
        sut.disableNetworkRequestTimer()
        if let timer = sut.networkRequestTimer {
            XCTAssertFalse(timer.isValid, "Timer should be invalid")
        }
    }
}
