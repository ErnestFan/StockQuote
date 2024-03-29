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
    
    // Get price change for display usage
    func displayTextForPriceChange() -> String {
        if price == 0.0 || change == 0.0 {
            return "-"
        }
        
        let prefix = change > 0 ? "+" : "-"
        return prefix + String(format: "%.2f", abs(change))
    }
    
    // Get price for display usage
    func displayTextForPrice() -> String {
        if price == 0.0 {
            return "-"
        }
        
        return String(format: "%.2f", price)
    }
    
    init(symbol: String, attributes: [String: Any]) {
        // Symbol needed no matter data exist or not
        self.symbol = symbol
        
        // Extract value from JSON data
        self.open = Double(attributes["02. open"] as? String ?? "") ?? 0.0
        self.high = Double(attributes["03. high"] as? String ?? "") ?? 0.0
        self.low = Double(attributes["04. low"] as? String ?? "") ?? 0.0
        self.price = Double(attributes["05. price"] as? String ?? "") ?? 0.0
        self.volume = Int(attributes["06. volume"] as? String ?? "") ?? 0
        self.latestTradingDate = attributes["07. latest trading day"] as? String ?? ""
        self.previousClose = Double(attributes["08. previous close"] as? String ?? "") ?? 0.0
        self.change = Double(attributes["09. change"] as? String ?? "") ?? 0.0
        
        if let percentageString = attributes["10. change percent"] as? String {
            // Remove "%" sign from string, convert to double
            self.changePercentage = Double(percentageString.dropLast())
        } else {
            self.changePercentage = 0
        }
    }
}
