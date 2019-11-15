//
//  StockAPIService.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-14.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StockAPIService: NSObject {
    static let instance = StockAPIService()
    
    fileprivate let BASE_URL_FOR_TESTING = "http://localhost:8080/"
    fileprivate let BASE_URL_STRING = "https://www.alphavantage.co/query?"
    fileprivate let API_KEY = "30F7WL67GB3NW55Q"
    fileprivate let FUNCTION = "GLOBAL_QUOTE"
    fileprivate let isTesting = ProcessInfo.processInfo.arguments.contains("TESTING")
    
    private func getBaseURL(for symbol: String) -> String {
        return isTesting ? BASE_URL_FOR_TESTING + symbol : BASE_URL_STRING
    }
    
    func getStockDetail(for symbol: String, completion: @escaping (_ data: [String: Any]?) -> ()) {
        let parameters = [
            "function" : FUNCTION,
            "apikey" : API_KEY,
            "symbol" : symbol
        ]
        
        Alamofire.request(getBaseURL(for: symbol), method: .get, parameters: isTesting ? nil : parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard response.result.isSuccess, let value = response.result.value else {
                completion(nil)
                return
            }
            
            completion(JSON(value)["Global Quote"].dictionaryObject)
        }
    }
}
