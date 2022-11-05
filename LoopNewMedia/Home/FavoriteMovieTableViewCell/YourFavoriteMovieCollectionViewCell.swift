//
//  YourFavoriteMovieCollectionViewCell.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import UIKit

class YourFavoriteMovieCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet private weak var movieImageView: ImageViewWithCache!
    @IBOutlet private weak var containerView: UIView!
    
    var celldata: YourFavoriteMovieViewModel? {
        didSet {
            movieImageView.loadImage(urlString: celldata?.imageURL)
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
          
        movieImageView.layer.cornerRadius = 14
        movieImageView.clipsToBounds = true
    }
}


struct YourFavoriteMovieViewModel {
    let id: Int?
    let imageURL: String?
}
