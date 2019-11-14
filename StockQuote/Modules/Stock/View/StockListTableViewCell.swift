//
//  StockListTableViewCell.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-14.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import UIKit

class StockListTableViewCell: UITableViewCell {

    static let cellReuseIdentifier = "StockListTableViewCell"
    
    var stockViewModel: StockViewModel? {
        didSet {
            if let stock = stockViewModel {
                symbolLabel.text = stock.symbol
                priceLabel.text = stock.displayTextForPrice()
                priceChangeLabel.text = stock.displayTextForPriceChange()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - UI Setup

    func setupView() {
        let stackView = UIStackView(arrangedSubviews: [symbolLabel, priceLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 40))
        
        addSubview(priceChangeLabel)
        priceChangeLabel.anchor(top: stackView.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: stackView.trailingAnchor, size: .init(width: 0, height: 40))
    }
    
    // MARK: - UI Properties
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        label.textAlignment = .right
        return label
    }()
    
    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.textAlignment = .center
        return label
    }()
}
