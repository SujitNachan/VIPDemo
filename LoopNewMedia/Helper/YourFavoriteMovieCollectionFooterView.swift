//
//  CollectionFooterView.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import UIKit

class YourFavoriteMovieCollectionFooterView: UICollectionReusableView, ReusableView {
    
    var seeAllButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        // Customize here
     }

     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

     }
    
    private func setupUI() {
        seeAllButton = UIButton(frame: CGRect(x: 0, y: 0, width: 91, height: 33))
        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.titleLabel?.font = UIFont.SFProDisplay(.medium, size: 14)
        seeAllButton.setTitleColor(.black, for: .normal)
        seeAllButton.setImage(UIImage(named: "RightArrow"), for: .normal)
        seeAllButton.imageView?.contentMode = .scaleAspectFit
        seeAllButton.semanticContentAttribute = .forceRightToLeft
        seeAllButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 6, bottom: 10, right: -10)
        seeAllButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: -10)
        seeAllButton.backgroundColor = .white
        seeAllButton.setShadow()
        self.addSubview(seeAllButton)
        seeAllButton.center =  CGPoint(x: self.center.x-30, y: self.center.y)
    }
}
