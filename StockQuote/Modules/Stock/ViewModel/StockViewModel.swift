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
        return "-"
    }
    
    func displayTextForPrice() -> String {
        return ""
    }
    
    init(stock: Stock) {
        self.symbol = ""
        self.price = 0.0
        self.change = 0.0
    }
}
