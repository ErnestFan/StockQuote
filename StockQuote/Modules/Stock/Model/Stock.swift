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
    
    init(symbol: String, attributes: [String: Any]) {
        self.symbol = symbol
        self.open = Double(attributes["02. open"] as? String ?? "") ?? 0.0
        self.high = Double(attributes["03. high"] as? String ?? "") ?? 0.0
        self.low = Double(attributes["04. low"] as? String ?? "") ?? 0.0
        self.price = Double(attributes["05. price"] as? String ?? "") ?? 0.0
        self.volume = Int(attributes["06. volume"] as? String ?? "") ?? 0
        self.latestTradingDate = attributes["07. latest trading day"] as? String ?? ""
        self.previousClose = Double(attributes["08. previous close"] as? String ?? "") ?? 0.0
        self.change = Double(attributes["09. change"] as? String ?? "") ?? 0.0
        if let percentageString = attributes["10. change percent"] as? String {
            self.changePercentage = Double(percentageString.dropLast())
        } else {
            self.changePercentage = 0
        }
    }
}
