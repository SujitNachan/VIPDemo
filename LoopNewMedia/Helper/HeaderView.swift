//
//  HeaderView.swift
//  LoopNewMedia
//
//  Created by  on 01/11/22.
//

import UIKit

class HeaderViewWithButton: UIView {
    private var height = 48
    var searchButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        searchButton = UIButton(frame: CGRect(x: 30, y: 0, width: height, height: height))
        searchButton.setImage(UIImage(named: "Search"), for: .normal)
        searchButton.contentHorizontalAlignment = .fill
        searchButton.contentVerticalAlignment = .fill
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        searchButton.backgroundColor = .white
        searchButton.setShadow(radius: 12)
        self.addSubview(searchButton)
    }
}

class HeaderViewWithLabel: UIView {
    var headerTitleLabel: UILabel!
    private var headerTitle: String!
    private var headerColor: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(headerTitle: String, headerColor: UIColor) {
        self.init()
        self.headerTitle = headerTitle
        self.headerColor = headerColor
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 8, width: 320, height: 20))
        headerTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerTitleLabel.text = headerTitle
        headerTitleLabel.textColor = headerColor
        let headerView = UIView()
        headerView.addSubview(headerTitleLabel)
    }
}



public protocol WithPropertyAssignment {}

public extension WithPropertyAssignment where Self: AnyObject {

func with(_ closure: @escaping (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: WithPropertyAssignment {}


