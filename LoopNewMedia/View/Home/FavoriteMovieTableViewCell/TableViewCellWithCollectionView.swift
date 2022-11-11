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
    let primaryText: String?
    let secondaryText: String?
}

protocol TableViewCellWithCollectionViewConfiguration {
    var cellData: [TableViewCellWithCollectionViewViewModel]? { get set }
    var footerSize: CGSize { get set }
    var itemSize: CGSize { get set }
}

struct TableViewCellWithCollectionViewConfigurator: TableViewCellWithCollectionViewConfiguration {
    var cellData: [TableViewCellWithCollectionViewViewModel]?
    var footerSize: CGSize
    var itemSize: CGSize
}

class TableViewCellWithCollectionView: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var configuation: TableViewCellWithCollectionViewConfiguration? {
        didSet {
            collectionView.reloadData()
            collectionViewHeightConstraint.constant = configuation?.itemSize.height ?? .zero
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
        return configuation?.cellData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LoopMediaCollectioViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if let celldata = configuation?.cellData {
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
        if let yourFavoriteMovieViewModel = configuation?.cellData?[indexPath.row] {
            didSelectHandler?(yourFavoriteMovieViewModel)
        }
    }
}

extension TableViewCellWithCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return configuation?.itemSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return configuation?.footerSize ?? .zero
    }
}
