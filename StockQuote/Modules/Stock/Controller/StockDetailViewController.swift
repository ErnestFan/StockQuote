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
        
        setupView()
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
    
    func setupView() {
        view.backgroundColor = .white
        self.title = stock.symbol
        
        view.addSubview(priceView)
        priceView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 0, height: 60))
        
        view.addSubview(stockDetailStackView)
        stockDetailStackView.anchor(top: priceView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    // MARK: - UI Properties
    
    lazy var priceView : StockDetailPriceView = {
        let view = StockDetailPriceView(with: stock.displayTextForPrice(), and: stock.displayTextForPriceChange(), and: stock.change)
        return view
    }()
    
    lazy var stockDetailStackView : UIStackView = {
        let open = StockDetailPairedLabelView(with: "Open", and: String(format: "%.2f", stock.open))
        let high = StockDetailPairedLabelView(with: "High", and: String(format: "%.2f", stock.high))
        let low = StockDetailPairedLabelView(with: "Low", and: String(format: "%.2f", stock.low))
        let volume = StockDetailPairedLabelView(with: "Volume", and: String(stock.volume))
        let prevClose = StockDetailPairedLabelView(with: "Prev Close", and: String(format: "%.2f", stock.previousClose))
        
        let view = UIStackView(arrangedSubviews: [open, high, low, volume, prevClose, dateLabel, UIView()])
        view.axis = .vertical
        view.spacing = 6
        view.distribution = .fill
        return view
    }()

    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Mediumn", size: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = stock.latestTradingDate
        return label
    }()
}
