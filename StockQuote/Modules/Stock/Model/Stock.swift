//
//  Stock.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-13.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import Foundation

class Stock {
    let symbol: String!
    let open: Double!
    let high: Double!
    let low: Double!
    let price: Double!
    let volume: Int!
    let latestTradingDate: String!
    let previousClose: Double!
    let change: Double!
    let changePercentage: Double!
    
    init(attributes: [String: Any]) {
        self.symbol = ""
        self.open = 0.0
        self.high = 0.0
        self.low = 0.0
        self.price = 0.0
        self.volume = 0
        self.latestTradingDate = ""
        self.previousClose = 0.0
        self.change = 0.0
        self.changePercentage = 0.0
    }
}
