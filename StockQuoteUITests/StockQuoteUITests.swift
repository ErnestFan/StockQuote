//
//  StockQuoteUITests.swift
//  StockQuoteUITests
//
//  Created by Ernest Fan on 2019-11-13.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import XCTest
@testable import StockQuote

class StockQuoteUITests: XCTestCase {
    
    let dynamicStubs = DynamicStubs()

    override func setUp() {
        super.setUp()
        
        dynamicStubs.setUp()
        
        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()
        
        dynamicStubs.tearDown()
    }
    
    func testUpdateTableViewCellAfterNetworkRequest() {
        let jsonDict = ["Global Quote": [
            "01. symbol": "NVDA",
            "02. open": "146.7400",
            "03. high": "147.4625",
            "04. low": "146.2800",
            "05. price": "99.9900",
            "06. volume": "8991011",
            "07. latest trading day": "2019-11-13",
            "08. previous close": "147.0700",
            "09. change": "-0.3800",
            "10. change percent": "-0.2584%"
        ]]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: [.prettyPrinted]) {
            dynamicStubs.stubRequest(path: "/NVDA", jsonData: jsonData)
        } else {
            assertionFailure()
        }
        
        let app = XCUIApplication()
        app.launchArguments += ["TESTING"]
        app.launch()
        
        let tableViewCell = app.tables.staticTexts["NVDA"]
        XCTAssertTrue(tableViewCell.exists, "Cell should exist")
        
        // Make sure stubs data succeed
        let priceLabel = app.tables.staticTexts["99.99"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: priceLabel, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPresentAndDismissStockDetail() {
        let jsonDict = ["Global Quote": [
            "01. symbol": "NVDA",
            "02. open": "146.7400",
            "03. high": "147.4625",
            "04. low": "146.2800",
            "05. price": "99.9900",
            "06. volume": "8991011",
            "07. latest trading day": "2019-11-13",
            "08. previous close": "147.0700",
            "09. change": "-0.3800",
            "10. change percent": "-0.2584%"
        ]]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: [.prettyPrinted]) {
            dynamicStubs.stubRequest(path: "/NVDA", jsonData: jsonData)
        } else {
            assertionFailure()
        }
        
        let app = XCUIApplication()
        app.launchArguments += ["TESTING"]
        app.launch()
        
        // Navigate to stock detail
        let tableViewCell = app.tables.staticTexts["NVDA"]
        tableViewCell.tap()
        let openLabel = app.staticTexts["Open"]
        XCTAssertTrue(openLabel.exists, "Open label should exist and visible")
        
        // Navigate back to stock list
        app.navigationBars["NVDA"].buttons["Stock Quote"].tap()
        XCTAssertFalse(openLabel.exists, "Open label should not exist")
    }
    
    func testPresentAndDismissNetworkError() {
        let app = XCUIApplication()
        app.launchArguments += ["TESTING"]
        app.launch()
        
        let tableViewCell = app.tables/*@START_MENU_TOKEN@*/.staticTexts["AMZN"]/*[[".cells.staticTexts[\"AMZN\"]",".staticTexts[\"AMZN\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(tableViewCell.exists, "Cell should exist")
        
        // Present alert
        tableViewCell.tap()
        let alertButton = app.alerts["Unable to retrieve data"].scrollViews.otherElements.buttons["Got it"]
        XCTAssertTrue(alertButton.exists, "Alert should exist")
        
        // Dismiss alert
        alertButton.tap()
        XCTAssertFalse(alertButton.exists, "Alert should exist")
        
    }

}
