//
//  DynamicStubs.swift
//  StockQuoteUITests
//
//  Created by Ernest Fan on 2019-11-15.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import Foundation
import Swifter

class DynamicStubs {
    let server = HttpServer()
    
    func setUp() {
        try! server.start()
    }
    
    func tearDown() {
        server.stop()
    }
    
    func stubRequest(path: String, jsonData: Data) {
        
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            assertionFailure("Could not convert data to json")
            return
        }
        
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            HttpResponse.ok(.json(json as AnyObject))
        }
        
        server.get[path] = response
    }
}
