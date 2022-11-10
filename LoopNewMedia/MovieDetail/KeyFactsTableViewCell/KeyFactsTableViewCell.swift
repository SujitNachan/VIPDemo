//
//  KeyFactsTableViewCell.swift
//  LoopNewMedia
//
//  Created by  on 09/11/22.
//

import UIKit

protocol KeyFactsTableViewCellConfiguration {
    var cellData: [KeyFactViewModel]? { get }
}

struct KeyFactViewModel {
    let placeholder: String?
    let value: String?
}

struct KeyFactsTableViewCellConfigurator: KeyFactsTableViewCellConfiguration {
    var cellData: [KeyFactViewModel]?
}

class KeyFactsTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet private weak var collectionView: DynamicHeightCollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var configuration: KeyFactsTableViewCellConfiguration? {
        didSet {
            collectionView.reloadData()
            collectionView.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(KeyFactCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension KeyFactsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configuration?.cellData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let keyFactCell: KeyFactCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        keyFactCell.cellData = configuration?.cellData?[indexPath.row]
        return keyFactCell
    }
}

extension KeyFactsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.bounds.width / 2) - 40, height: 66)
    }
}
