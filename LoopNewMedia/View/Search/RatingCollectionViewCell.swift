//
//  RatingCollectionViewCell.swift
//  LoopNewMedia
//
//  Created by  on 17/11/22.
//

import UIKit

struct RatingViewModel {
    let rating: Int
    var isSelected: Bool
}

class RatingCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView {
    @IBOutlet private weak var ratingContainerView: UIView!
    @IBOutlet private weak var ratingView: StarsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(data: RatingViewModel) {
        ratingView.ratingOutOf = data.rating
        ratingView.filledStarColor = data.isSelected ?  #colorLiteral(red: 0.9998236299, green: 0.6797295809, blue: 0, alpha: 1)  : .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ratingContainerView.layer.borderColor = UIColor.white.cgColor
        ratingContainerView.layer.cornerRadius = 14
        ratingContainerView.layer.borderWidth = 1
    }
}
