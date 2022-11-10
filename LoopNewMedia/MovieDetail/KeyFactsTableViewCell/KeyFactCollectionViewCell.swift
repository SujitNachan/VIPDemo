//
//  KeyFactCollectionViewCell.swift
//  LoopNewMedia
//
//  Created by  on 09/11/22.
//

import UIKit

class KeyFactCollectionViewCell: UICollectionViewCell, ReusableView, NibLoadableView {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var placeholderLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    var cellData: KeyFactViewModel? {
        didSet {
            placeholderLabel.text = cellData?.placeholder
            valueLabel.text = cellData?.value
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
