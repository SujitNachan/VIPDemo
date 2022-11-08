//
//  YourFavoriteMovieCollectionViewCell.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import UIKit

class LoopMediaCollectioViewCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var imageView: ImageViewWithCache!
    @IBOutlet private weak var containerView: UIView!
    
    var celldata: TableViewCellWithCollectionViewViewModel? {
        didSet {
            imageView.loadImage(urlString: celldata?.imageURL)
            label.isHidden = (celldata?.text?.isEmpty ?? false)
            label.text = celldata?.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 14
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        containerView.layer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        containerView.layer.shadowRadius = 4.0
        containerView.layer.shadowOpacity = 1
          
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
    }
}
