//
//  MovieOverviewTableViewCell.swift
//  LoopNewMedia
//
//  Created by  on 05/11/22.
//

import Foundation
import UIKit

class MovieOverviewTableViewCell: UITableViewCell, ReusableView {
    var cellData: String? {
        didSet {
            textLabel?.text = cellData
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        textLabel?.lineBreakMode = .byWordWrapping
        textLabel?.numberOfLines = 0
        textLabel?.text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum."
        textLabel?.textColor = .black.withAlphaComponent(0.7)
        textLabel?.font = UIFont.SFProDisplay(.regular, size: 16)
        textLabel?.textAlignment = .justified
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel!.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 30
            ),
            textLabel!.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -30
            )
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
