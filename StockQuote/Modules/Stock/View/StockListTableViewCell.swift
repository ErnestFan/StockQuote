//
//  StockListTableViewCell.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-14.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import UIKit

class StockListTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let cellReuseIdentifier = "StockListTableViewCell"
    
    var stockViewModel: StockViewModel? {
        didSet {
            if let stock = stockViewModel {
                symbolLabel.text = stock.symbol
                priceLabel.text = stock.displayTextForPrice()
                priceChangeLabel.text = stock.displayTextForPriceChange()
                self.layoutIfNeeded()
            }
        }
    }
    
    var stockSymbol : String? {
        didSet {
            if let symbol = stockSymbol {
                symbolLabel.text = symbol
                priceLabel.text = ""
                priceChangeLabel.text = ""
            }
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 40))
        
        addSubview(priceChangeLabel)
        priceChangeLabel.anchor(top: stackView.bottomAnchor, leading: nil, bottom: nil, trailing: stackView.trailingAnchor, size: .init(width: 0, height: 40))
        
        addSubview(dividerView)
        dividerView.anchor(top: priceChangeLabel.bottomAnchor, leading: stackView.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: stackView.trailingAnchor, size: .init(width: 0, height: 1))
    }
    
    // MARK: - UI Properties
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        label.textAlignment = .right
        return label
    }()
    
    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
}
