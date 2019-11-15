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
    
    var stockDetailDict = [String : Stock]()
    var pendingNetworkRequest = [IndexPath : String]()
    
    var networkRequestTimer : Timer?
    
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
                self.stockDetailDict[symbol] = Stock(symbol: symbol, attributes: attributes)
                self.removePendingNetworkRequest(for: indexPath)
                
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            } else {
                // If network request failed, add to pending
                self.addPendingNetworkRequest(with: indexPath, and: symbol)
            }
        }
    }
    
    func addPendingNetworkRequest(with indexPath: IndexPath, and symbol: String) {
        if !pendingNetworkRequest.keys.contains(indexPath) {
            pendingNetworkRequest[indexPath] = symbol
            enableNetworkRequestTimer()
        }
    }
    
    func removePendingNetworkRequest(for indexPath: IndexPath) {
        pendingNetworkRequest.removeValue(forKey: indexPath)
        if pendingNetworkRequest.count <= 0 {
            disableNetworkRequestTimer()
        }
    }
    
    // MARK: - Network Request Retry Timer
    
    func enableNetworkRequestTimer() {
        // If timer already exists and valid, return
        if let timer = networkRequestTimer, timer.isValid {
            return
        }
        
        networkRequestTimer = Timer.scheduledTimer(timeInterval: 90.0, target: self, selector: #selector(resumePendingRequest), userInfo: nil, repeats: true)
    }
    
    func disableNetworkRequestTimer() {
        networkRequestTimer?.invalidate()
    }
    
    @objc func resumePendingRequest() {
        var count = 0
        for key in pendingNetworkRequest.keys.sorted() {
            if let symbol = pendingNetworkRequest[key] {
                requestStockDetail(with: symbol, for: key)
                count += 1
            }
            if count >= 5 {
                break
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
            // Configure cell
            let symbol = stockSymbolArray[indexPath.row]
            cell.stockSymbol = symbol
            
            if let stock = stockDetailDict[symbol] {
                // Create StockViewModel and add to cell
                cell.stockViewModel = StockViewModel(stock: stock)
            } else {
                // Retrieve Stock from API
                requestStockDetail(with: symbol, for: indexPath)
            }
        }

        return cell
    }
}
