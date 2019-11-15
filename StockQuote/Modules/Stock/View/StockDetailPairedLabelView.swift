//
//  StockDetailPairedLabelView.swift
//  StockQuote
//
//  Created by Ernest Fan on 2019-11-15.
//  Copyright © 2019 ErnestFan. All rights reserved.
//

import UIKit

class StockDetailPairedLabelView: UIView {

    let titleString : String!
    let valueString : String!

    // MARK: - Init
    
    init(with titleString: String, and valueString: String) {
        self.titleString = titleString
        self.valueString = valueString
        super.init(frame: CGRect.zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 4))
        
        addSubview(valueLabel)
        valueLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: centerXAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 4, bottom: 0, right: 0))
    }
    
    // MARK: - UI Properties
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        label.textColor = .darkGray
        label.textAlignment = .right
        label.text = titleString
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = valueString
        return label
    }()

}
