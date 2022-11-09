//
//  FavoriteMovieCell.swift
//  LoopNewMedia
//
//  Created by  on 02/11/22.
//

import UIKit

struct TableViewCellWithCollectionViewViewModel {
    let id: Int?
    let imageURL: String?
    let text: String?
}

struct CollectionViewConfiguation {
    let footerSize: CGSize
    let itemSize: CGSize
    
}

class TableViewCellWithCollectionView: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var cellData: [TableViewCellWithCollectionViewViewModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var collectionViewConfiguation: CollectionViewConfiguation? {
        didSet {
            collectionViewHeightConstraint.constant = collectionViewConfiguation?.itemSize.height ?? .zero
        }
    }
    
    var didSelectHandler: ((_ yourFavoriteMovieViewModel: TableViewCellWithCollectionViewViewModel) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(LoopMediaCollectioViewCell.self)
        collectionView.registerSupplementaryView(YourFavoriteMovieCollectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TableViewCellWithCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LoopMediaCollectioViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if let celldata = cellData {
            cell.celldata = celldata[indexPath.row]
        }
        return cell
    }
}

extension TableViewCellWithCollectionView: UICollectionViewDelegate {
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
            didSelectHandler?(yourFavoriteMovieViewModel)
        }
    }
}

extension TableViewCellWithCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionViewConfiguation?.itemSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return collectionViewConfiguation?.footerSize ?? .zero
    }
}
