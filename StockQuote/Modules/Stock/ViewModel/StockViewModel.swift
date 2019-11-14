//
//  StockViewModel.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-13.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import Foundation

class StockViewModel {
    let symbol: String!
    let price: Double!
    let change: Double!
    
    func displayTextForChange() -> String {
        if price == 0.0 || change == 0.0 {
            return ""
        }
        
        let prefix = change > 0 ? "+" : "-"
        return prefix + String(format: "%.2f", abs(change))
    }
    
    func displayTextForPrice() -> String {
        if price == 0.0 {
            return ""
        }
        
        return String(format: "%.2f", price)
    }
    
    init(stock: Stock) {
        self.symbol = stock.symbol
        self.price = stock.price
        self.change = stock.change
    }
}
