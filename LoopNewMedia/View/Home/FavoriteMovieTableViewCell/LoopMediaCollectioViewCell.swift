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
            self.configureCell()
        }
    }
    
    private func configureCell() {
        imageView.loadImage(urlString: celldata?.imageURL)
        if let name = celldata?.primaryText,
           let characterName = celldata?.secondaryText
        {
            label.text = name + "\n" + characterName
            label.changeTextColor(ofText: characterName, with: .white.withAlphaComponent(0.6))
            self.gardientEffect()
        } else if let name = celldata?.primaryText {
            label.text = name
        } else {
            label.isHidden = true
        }
    }
    
    private func gardientEffect() {
        let gradient = CAGradientLayer()
        gradient.frame = imageView.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        imageView.layer.sublayers?.removeAll()
        imageView.layer.addSublayer(gradient)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.shadowColor = nil
        containerView.setShadow(shadowOffset: CGSize(width: -2.0, height: -2.0), shadowRadius: 4, cornerRadius: 14)
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
    }
}
