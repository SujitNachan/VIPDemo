//
//  ViewExyensions.swift
//  LoopNewMedia
//
//  Created by  on 11/11/22.
//

import UIKit

extension UIView {
    func applyBlurEffect(_ style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurEffectView, at: 0)
    }
}

extension UIView {
    func setShadow(shadowColor: CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor, shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0), shadowRadius: CGFloat = 18.0, cornerRadius: CGFloat = 18.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = 1.0
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
    }
}
