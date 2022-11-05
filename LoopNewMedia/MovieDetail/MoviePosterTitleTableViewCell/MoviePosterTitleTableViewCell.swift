//
//  MoviePosterTitleTableViewCell.swift
//  LoopNewMedia
//
//  Created by  on 04/11/22.
//

import UIKit

class MoviePosterTitleTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet private weak var posterImageView: ImageViewWithCache?
    @IBOutlet private weak var posterImageViewContainer: UIView?
    @IBOutlet private weak var starView: StarsView?
    @IBOutlet private weak var releaseDateLabel: UILabel?
    @IBOutlet private weak var movieTitleLabel: UILabel?
    @IBOutlet private weak var tagListView: TagListView?
    
    var cellData: Movie? {
        didSet {
            movieTitleLabel?.text = cellData?.title //?? "" + "(\(cellData?.releaseDate?.getDate?.getYYYY ?? ""))"
            releaseDateLabel?.text = cellData?.releaseDate?.getDate?.getDDDotMMDotYYYY
            starView?.rating = cellData?.rating ?? 0
            posterImageView?.loadImage(urlString: cellData?.posterUrl)
            if let genres = cellData?.genres {
                tagListView?.addTags(genres)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageViewContainer?.layer.cornerRadius = 14
        posterImageViewContainer?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        posterImageViewContainer?.layer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        posterImageViewContainer?.layer.shadowRadius = 4.0
        posterImageViewContainer?.layer.shadowOpacity = 1
          
        posterImageView?.layer.cornerRadius = 14
        posterImageView?.clipsToBounds = true
    }
}
