//
//  ViewControllerExtension.swift
//  LoopNewMedia
//
//  Created by  on 11/11/22.
//

import UIKit

extension UIViewController {
    func showAlertViewWithStyle(title: String, message: String, actionTitles: [String], style: UIAlertController.Style = .alert, handler: [((UIAlertAction) -> Void)?]) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for (index, title) in actionTitles.enumerated() {
            // add an action (button)
            if !handler.isEmpty {
                alert.addAction(UIAlertAction(title: title, style: .default, handler: handler[index]))
            } else {
                alert.addAction(UIAlertAction(title: title, style: .default, handler: nil))
            }
        }
        if style == .actionSheet {
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        // show the alert
        self.showDetailViewController(alert, sender: self)
    }
}
