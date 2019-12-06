//
//  StockListTableViewController.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-14.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import UIKit

class StockListTableViewController: UITableViewController {

    // Stock Info
    let stockSymbolArray : [String]!
    var stockDetailDict = [String : Stock]()
    
    // Networking
    var pendingNetworkRequest = [IndexPath : String]()
    var networkRequestTimer : Timer?
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    var onGoingNetworkRequestCount = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Stock Quote"
        setupTableView()
        setupActivityIndicator()
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
    
    private func setupActivityIndicator() {
        let barButtonItem = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // MARK: - Stock Detail
    
    func presentStockDetail(with stock: Stock) {
        let stockDetailVC = StockDetailViewController(with: stock)
        if let nc = self.navigationController {
            nc.pushViewController(stockDetailVC, animated: true)
        }
    }
    
    // MARK: - Alert
    
    func presentNetworkRequestError() {
        if self.presentingViewController != nil {
            return
        }
        
        let title = "Unable to retrieve data"
        let message = "Such error can occur due to your network connection or the limitation of 5 stock quotes per minute from our data provider. Please try again later."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Got it", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Activity Indicator
    
    func enableActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func disableActivityIndicator() {
        if onGoingNetworkRequestCount <= 0 {
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Network Request
    
    // Keep track of number of requests fired, stop animation when all request finished
    // If user tap on a cell, request data immediately with reaction
    // Else, request on scroll or resume pending requests based on timer
    
    func requestStockDetail(with symbol: String, for indexPath: IndexPath, reaction requiresReaction: Bool = false) {
        onGoingNetworkRequestCount += 1
        enableActivityIndicator()
        
        StockAPIService.instance.getStockDetail(for: symbol) { (data) in
            self.onGoingNetworkRequestCount -= 1
            self.disableActivityIndicator()
            
            if let attributes = data {
                // If received data, extract data from JSON
                let stock = Stock(symbol: symbol, attributes: attributes)
                self.stockDetailDict[symbol] = stock
                self.removePendingNetworkRequest(for: indexPath)
                
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    
                    if requiresReaction {
                        self.presentStockDetail(with: stock)
                    }
                }
            } else {
                // If failed, add request to pending
                self.addPendingNetworkRequest(with: indexPath, and: symbol)
                
                if requiresReaction {
                    self.presentNetworkRequestError()
                }
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
        // If timer already exists and valid, do nothing
        if let timer = networkRequestTimer, timer.isValid {
            return
        }
        
        networkRequestTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(resumePendingRequest), userInfo: nil, repeats: true)
    }
    
    func disableNetworkRequestTimer() {
        networkRequestTimer?.invalidate()
    }
    
    @objc func resumePendingRequest() {
        // Fire up to 5 network requests
        var count = 0
        
        for indexPath in pendingNetworkRequest.keys.sorted() {
            if let symbol = pendingNetworkRequest[indexPath] {
                requestStockDetail(with: symbol, for: indexPath)
                count += 1
            }
            if count >= 5 {
                break
            }
        }
    }
    
    // MARK: - Tableview data source

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
            
            if let stock = stockDetailDict[symbol] {
                cell.stock = stock
            } else {
                // Configure cell with basic info
                cell.stockSymbol = symbol
                requestStockDetail(with: symbol, for: indexPath)
            }
        }

        return cell
    }
    
    // MARK: - Tableview delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let symbol = stockSymbolArray[indexPath.row]
        
        if let stock = stockDetailDict[symbol] {
            presentStockDetail(with: stock)
        } else {
            requestStockDetail(with: symbol, for: indexPath, reaction: true)
        }
    }
}
