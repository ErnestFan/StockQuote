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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Stock Quote"
        setupTableView()
    }
    
    // MARK: - Init
    
    init(stocks:[String], style: UITableView.Style) {
        self.stockSymbolArray = stocks
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableView.register(StockListTableViewCell.self, forCellReuseIdentifier: StockListTableViewCell.cellReuseIdentifier)
        
        tableView.separatorStyle = .none
    }
    
    // MARK: - Network Request
    
    func requestStockDetail(with symbol: String, for indexPath: IndexPath) {
        StockAPIService.instance.getStockDetail(for: symbol) { (data) in
            if let attributes = data {
                self.stockDict[symbol] = Stock(symbol: symbol, attributes: attributes)
                
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            } else {
                // Handle network error
                print("Failed network request")
            }
        }
    }
    
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
            
            cell.stockSymbol = symbol
            
            if let stock = stockDict[symbol] {
                // Create StockViewModel and to cell
                cell.stockViewModel = StockViewModel(stock: stock)
            } else {
                // Retrieve Stock from API
                requestStockDetail(with: symbol, for: indexPath)
            }
        }

        return cell
    }
}
