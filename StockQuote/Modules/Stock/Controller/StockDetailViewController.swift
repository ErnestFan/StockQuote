//
//  StockDetailViewController.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-15.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    let stock : Stock!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Init
    
    init(with stock: Stock) {
        self.stock = stock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setup() {
        view.backgroundColor = .white
        self.title = stock.symbol
    }

}
