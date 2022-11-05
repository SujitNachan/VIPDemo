//
//  FavoriteMovieCell.swift
//  LoopNewMedia
//
//  Created by  on 02/11/22.
//

import UIKit

class FavoriteMovieCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var cellData: [YourFavoriteMovieViewModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var movieSelectHandler: ((_ yourFavoriteMovieViewModel: YourFavoriteMovieViewModel) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(YourFavoriteMovieCollectionViewCell.self)
        collectionView.registerSupplementaryView(YourFavoriteMovieCollectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FavoriteMovieCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YourFavoriteMovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if let celldata = cellData {
            cell.celldata = celldata[indexPath.row]
        }
        return cell
    }
}

extension FavoriteMovieCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionFooter:
            let footerView: YourFavoriteMovieCollectionFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
                return footerView
            
            default:
                assert(false, "Unexpected element kind")
            }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let yourFavoriteMovieViewModel = cellData?[indexPath.row] {
            movieSelectHandler?(yourFavoriteMovieViewModel)
        }
    }
}
