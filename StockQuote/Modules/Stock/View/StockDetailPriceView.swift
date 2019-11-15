//
//  StockDetailPriceView.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-15.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import UIKit

class StockDetailPriceView: UIView {

    let priceString : String!
    let priceChangeString : String!
    let priceChange : Double!

    // MARK: - Init
    
    init(with priceString: String, and changeString: String, and changeValue: Double) {
        self.priceString = priceString
        self.priceChangeString = changeString
        self.priceChange = changeValue
        super.init(frame: CGRect.zero)
        
        setupView()
        configurePriceChangeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(priceLabel)
        priceLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 10, left: 15, bottom: 10, right: 0))
        
        addSubview(priceChangeLabel)
        priceChangeLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: priceLabel.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 5, bottom: 10, right: 15))
    }
    
    private func configurePriceChangeLabel() {
        if priceChange == 0 {
            priceChangeLabel.textColor = .black
        } else if priceChange > 0 {
            priceChangeLabel.textColor = .green
        } else {
            priceChangeLabel.textColor = .red
        }
    }
    
    // MARK: - UI Properties
    
    lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        label.textAlignment = .left
        label.text = priceString
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = priceChangeString
        return label
    }()
}
