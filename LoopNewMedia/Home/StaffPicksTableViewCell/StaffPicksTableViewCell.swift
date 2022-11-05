//
//  StaffPicksTableViewCell.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import UIKit

class StaffPicksTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet private weak var posterImageView: ImageViewWithCache?
    @IBOutlet private weak var bookmarkImageView: UIImageView?
    @IBOutlet private weak var movieTitleLabel: UILabel?
    @IBOutlet private weak var movieReleaseYearLabel: UILabel?
    @IBOutlet private weak var movieRatingView: StarsView?
    
    var celldata: StaffPicksViewModel? {
        didSet {
            posterImageView?.loadImage(urlString: celldata?.posterImageURL)
            movieTitleLabel?.text = celldata?.movieTitle
            movieReleaseYearLabel?.text = celldata?.movieReleaseYear
            movieRatingView?.rating = celldata?.ratings ?? 0
            bookmarkImageView?.image = (UserDefaultDataManager.shared.retriveBookMarks().contains(celldata?.id ?? 0) ) ? UIImage(named: "BookmarkFill") : UIImage(named: "Bookmark")
        }
    }
    
    var bookmarkHandler: (() -> ())?
    
    @objc private func bookmarkImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        bookmarkHandler?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bookmarkImageTapped(tapGestureRecognizer:)))
        bookmarkImageView?.isUserInteractionEnabled = true
        bookmarkImageView?.addGestureRecognizer(tapGestureRecognizer)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

struct StaffPicksViewModel {
    let id: Int?
    let posterImageURL: String?
    let movieTitle: String?
    let movieReleaseYear: String?
    let ratings: Double?
}


