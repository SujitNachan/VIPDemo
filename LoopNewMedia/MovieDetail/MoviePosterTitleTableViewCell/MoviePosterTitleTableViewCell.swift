//
//  MoviePosterTitleTableViewCell.swift
//  LoopNewMedia
//
//  Created by  on 04/11/22.
//

import UIKit

struct MovieViewModel {
    let id : Int
    let posterUrl: String?
    let rating : Double?
    let releaseDateWithDuration : String?
    let movieTitle: String?
    let releaseYear: String?
    let genres : [String]
    
}

class MoviePosterTitleTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet private weak var posterImageView: ImageViewWithCache?
    @IBOutlet private weak var posterImageViewContainer: UIView?
    @IBOutlet private weak var starView: StarsView?
    @IBOutlet private weak var releaseDateLabel: UILabel?
    @IBOutlet private weak var movieTitleLabel: UILabel?
    @IBOutlet private weak var tagListView: TagListView?
    @IBOutlet private weak var tagListViewHeightConstraint: NSLayoutConstraint?
    
    var cellData: MovieViewModel? {
        didSet {
            if let cellData = cellData {
                posterImageView?.loadImage(urlString: cellData.posterUrl)
                starView?.rating = cellData.rating ?? 0
                releaseDateLabel?.text = cellData.releaseDateWithDuration
                movieTitleLabel?.text = (cellData.movieTitle ?? "" ) + " (\(cellData.releaseYear ?? ""))"
                movieTitleLabel?.changeFont(ofText: " (\(cellData.releaseYear ?? ""))", with: UIFont.SFProDisplay(.regular, size: 24) ?? .systemFont(ofSize: 24))
                movieTitleLabel?.changeTextColor(ofText: "(\(cellData.releaseYear ?? ""))", with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5989863597))
                tagListView?.addTags(cellData.genres)
                tagListViewHeightConstraint?.constant = CGFloat(((tagListView?.rows ?? 2) - 1) * 19)
                layoutIfNeeded()
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
        posterImageViewContainer?.layer.shadowRadius = 14.0
        posterImageViewContainer?.layer.shadowOpacity = 1
          
        posterImageView?.layer.cornerRadius = 14
        posterImageView?.clipsToBounds = true
    }
}
