//
//  StockListTableViewController.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-14.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import UIKit

class StockListTableViewController: UITableViewController {

    let stockSymbolArray : [String]!
    
    var stockDict = [String : Stock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(StockListTableViewCell.self, forCellReuseIdentifier: StockListTableViewCell.cellReuseIdentifier)
    }
    
    init(stocks:[String], style: UITableView.Style) {
        self.stockSymbolArray = stocks
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Network Request
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stockSymbolArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockListTableViewCell.cellReuseIdentifier, for: indexPath)
        
        if let cell = cell as? StockListTableViewCell {
            let symbol = stockSymbolArray[indexPath.row]
            
            if let stock = stockDict[symbol] {
                // Create StockViewModel with stock
                // Assign StockViewModel to cell
            } else {
                // Retrieve Stock from API
                // Update cell
            }
        }

        return cell
    }
}
