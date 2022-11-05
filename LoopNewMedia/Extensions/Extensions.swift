//
//  Extensions.swift
//  LoopNewMedia
//
//  Created by  on 01/11/22.
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


protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type, ofKind kind: String) where T: ReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter, UICollectionView.elementKindSectionHeader:
            register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.defaultReuseIdentifier)
        default:
            fatalError("Could not find element kind")
        }
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type, ofKind kind: String) where T: ReusableView, T: NibLoadableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter, UICollectionView.elementKindSectionHeader:
            register(UINib(nibName: T.defaultReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.defaultReuseIdentifier)
        default:
            fatalError("Could not find element kind")
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue view with identifier: \(T.defaultReuseIdentifier)")
        }
        return reusableView
    }
}

public struct RangedAttributes {

    public let attributes: [NSAttributedString.Key: Any]
    public let range: NSRange

    public init(_ attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        self.attributes = attributes
        self.range = range
    }
}

public protocol ChangableFont: AnyObject {
    var rangedAttributes: [RangedAttributes] { get }
       func getText() -> String?
       func set(text: String?)
       func getAttributedText() -> NSAttributedString?
       func set(attributedText: NSAttributedString?)
       func getFont() -> UIFont?
       func changeFont(ofText text: String, with font: UIFont)
       func changeFont(inRange range: NSRange, with font: UIFont)
       func changeTextColor(ofText text: String, with color: UIColor)
       func changeTextColor(inRange range: NSRange, with color: UIColor)
       func resetFontChanges()
}


public extension ChangableFont {

    var rangedAttributes: [RangedAttributes] {
        guard let attributedText = getAttributedText() else {
            return []
        }
        var rangedAttributes: [RangedAttributes] = []
        let fullRange = NSRange(
            location: 0,
            length: attributedText.string.count
        )
        attributedText.enumerateAttributes(
            in: fullRange,
            options: []
        ) { (attributes, range, stop) in
            guard range != fullRange, !attributes.isEmpty else { return }
            rangedAttributes.append(RangedAttributes(attributes, inRange: range))
        }
        return rangedAttributes
    }

    func changeFont(ofText text: String, with font: UIFont) {
        guard let range = (self.getAttributedText()?.string ?? self.getText())?.range(ofText: text) else { return }
        changeFont(inRange: range, with: font)
    }

    func changeFont(inRange range: NSRange, with font: UIFont) {
        add(attributes: [.font: font], inRange: range)
    }

    func changeTextColor(ofText text: String, with color: UIColor) {
        guard let range = (self.getAttributedText()?.string ?? self.getText())?.range(ofText: text) else { return }
        changeTextColor(inRange: range, with: color)
    }

    func changeTextColor(inRange range: NSRange, with color: UIColor) {
        add(attributes: [.foregroundColor: color], inRange: range)
    }

    private func add(attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        guard !attributes.isEmpty else { return }

        var rangedAttributes: [RangedAttributes] = self.rangedAttributes

        var attributedString: NSMutableAttributedString

        if let attributedText = getAttributedText() {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else if let text = getText() {
            attributedString = NSMutableAttributedString(string: text)
        } else {
            return
        }

        rangedAttributes.append(RangedAttributes(attributes, inRange: range))

        rangedAttributes.forEach { (rangedAttributes) in
            attributedString.addAttributes(
                rangedAttributes.attributes,
                range: rangedAttributes.range
            )
        }

        set(attributedText: attributedString)
    }

    func resetFontChanges() {
        guard let text = getText() else { return }
        set(attributedText: NSMutableAttributedString(string: text))
    }
}

extension UILabel: ChangableFont {

    public func getText() -> String? {
        return text
    }

    public func set(text: String?) {
        self.text = text
    }

    public func getAttributedText() -> NSAttributedString? {
        return attributedText
    }

    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }

    public func getFont() -> UIFont? {
        return font
    }
}

public extension String {

    func range(ofText text: String) -> NSRange {
        let fullText = self
        let range = (fullText as NSString).range(of: text)
        return range
    }
}

extension UIFont {

    public enum SFProDisplayType: String {
        case regular = "-Regular"
        case medium = "-Medium"
        case bold = "-Bold"
    }

    static func SFProDisplay(_ type: SFProDisplayType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont? {
        return UIFont(name: "SFProDisplay\(type.rawValue)", size: size)
    }

}

extension UIView {
    func setShadow(shadowColor: CGColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor, shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0), radius: CGFloat = 18.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = 1.0
        layer.shadowRadius = radius
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
}

extension String {
    var getDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        return dateFormatter.date(from: self)
    }
}

extension Date {
    var getDDDotMMDotYYYY: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "DD.MM.YYYY"
        return dateFormatter.string(from: self)
    }
    
    var getYYYY: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
}
