//
//  UIViewAnchorTests.swift
//  StockQuoteTests
//
//  Created by Ernest Fan on 2019-11-14.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import XCTest
@testable import StockQuote

class UIViewAnchorTests: XCTestCase {

    var sut: UIViewController!
    var childView: UIView!
    
    override func setUp() {
        super.setUp()
        
        sut = UIViewController()
        childView = UIView()
    }

    override func tearDown() {
        super.tearDown()
        
        sut = nil
        childView = nil
    }

    func testFillSuperview() {
        sut.loadViewIfNeeded()
        
        sut.view.addSubview(childView)
        
        childView.fillSuperview()
        
        sut.view.layoutIfNeeded()
        
        XCTAssertEqual(sut.view.frame.origin.x, childView.frame.origin.x)
        XCTAssertEqual(sut.view.frame.origin.y, childView.frame.origin.y)
        XCTAssertEqual(sut.view.frame.size.width, childView.frame.size.width)
        XCTAssertEqual(sut.view.frame.size.height, childView.frame.size.height)
    }
    
    func testAnchorVerticalWithFixedWidth() {
        sut.loadViewIfNeeded()
        
        sut.view.addSubview(childView)
        
        childView.anchor(top: sut.view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: sut.view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, size: .init(width: 50, height: 0))
        
        sut.view.layoutIfNeeded()
        
        XCTAssertEqual(sut.view.frame.origin.y, childView.frame.origin.y)
        XCTAssertEqual(sut.view.frame.size.height, childView.frame.size.height)
        XCTAssertEqual(50.0, childView.frame.size.width)
    }
    
    func testAnchorHorizontalWithFixedHeight() {
        sut.loadViewIfNeeded()
        
        sut.view.addSubview(childView)
        
        childView.anchor(top: nil, leading: sut.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: sut.view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 50))
        
        sut.view.layoutIfNeeded()
        
        XCTAssertEqual(sut.view.frame.origin.x, childView.frame.origin.x)
        XCTAssertEqual(sut.view.frame.size.width, childView.frame.size.width)
        XCTAssertEqual(50.0, childView.frame.size.height)
    }
    
    func testAnchorWithPadding() {
        sut.loadViewIfNeeded()
        
        sut.view.addSubview(childView)
        
        childView.anchor(top: sut.view.safeAreaLayoutGuide.topAnchor, leading: sut.view.safeAreaLayoutGuide.leadingAnchor, bottom: sut.view.safeAreaLayoutGuide.bottomAnchor, trailing: sut.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        sut.view.layoutIfNeeded()
        
        XCTAssertEqual(sut.view.frame.origin.x + 10.0, childView.frame.origin.x)
        XCTAssertEqual(sut.view.frame.origin.y + 10.0, childView.frame.origin.y)
        XCTAssertEqual(sut.view.frame.size.width - 20.0, childView.frame.size.width)
        XCTAssertEqual(sut.view.frame.size.height - 20.0, childView.frame.size.height)
    }

}
