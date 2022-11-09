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
            if let text = celldata?.text {
                label.text = text
                let gradient = CAGradientLayer()
                gradient.frame = imageView.frame
                gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
                gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradient.endPoint = CGPoint(x: 0.5, y: 1)
                imageView.layer.addSublayer(gradient)
            } else {
                label.isHidden = true
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.layer.sublayers?.removeAll()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.shadowColor = nil
        containerView.layer.cornerRadius = 14
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        containerView.layer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        containerView.layer.shadowRadius = 4.0
        containerView.layer.shadowOpacity = 1
          
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
    }
}
