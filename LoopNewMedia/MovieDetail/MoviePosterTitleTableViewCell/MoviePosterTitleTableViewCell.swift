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
    @IBOutlet private weak var movieTitleLabelHeightConstraint: NSLayoutConstraint?
    
    var cellData: MovieViewModel? {
        didSet {
            configureCell()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageViewContainer?.layer.shadowColor = nil
        posterImageViewContainer?.setShadow(shadowOffset: CGSize(width: -2.0, height: -2.0), shadowRadius: 14, cornerRadius: 14)
        posterImageView?.layer.cornerRadius = 14
        posterImageView?.clipsToBounds = true
    }
    
    private func configureCell() {
        if let cellData = cellData {
            posterImageView?.loadImage(urlString: cellData.posterUrl)
            starView?.rating = cellData.rating ?? 0
            releaseDateLabel?.text = cellData.releaseDateWithDuration
            movieTitleLabel?.text = (cellData.movieTitle ?? "" ) + " (\(cellData.releaseYear ?? ""))"
            movieTitleLabel?.changeFont(ofText: " (\(cellData.releaseYear ?? ""))", with: UIFont.SFProDisplay(.regular, size: 24) ?? .systemFont(ofSize: 24))
            movieTitleLabel?.changeTextColor(ofText: "(\(cellData.releaseYear ?? ""))", with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5989863597))
            movieTitleLabel?.sizeToFit()
            movieTitleLabelHeightConstraint?.constant = CGFloat(movieTitleLabel?.bounds.height ?? 29)
            tagListView?.removeAllTags()
            tagListView?.addTags(cellData.genres)
            tagListView?.alignment = .center
            tagListView?.textColor = .black
            tagListView?.textFont = UIFont.SFProDisplay(.regular, size: 14) ?? .systemFont(ofSize: 14)
            tagListView?.tagBackgroundColor = #colorLiteral(red: 0.1000831202, green: 0.1472782791, blue: 0.1932071447, alpha: 0.05)
            tagListView?.cornerRadius = 8
            tagListView?.paddingX = 10
            tagListView?.paddingY = 5
        }
    }
}
