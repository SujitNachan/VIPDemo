//
//  TagView.swift
//  LoopNewMedia
//
//  Created by  on 04/11/22.
//

import UIKit

class TagView: UILabel {
    private let paddingY: CGFloat = 5
    private let paddingX: CGFloat = 30
    
    @IBInspectable open var cornerRadius: CGFloat = 2 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable open var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            backgroundColor = tagBackgroundColor
        }
    }
    
    @IBInspectable open var textFont: UIFont = UIFont.SFProDisplay(.regular, size: 9) ?? .systemFont(ofSize: 12) {
        didSet {
            font = textFont
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public init(title: String) {
        super.init(frame: CGRect.zero)
        text = title
        setupView()
    }
    
    private func setupView() {
        lineBreakMode = .byWordWrapping
        frame.size = intrinsicContentSize
    }
    
    override open var intrinsicContentSize: CGSize {
        var size = text?.size(withAttributes: [NSAttributedString.Key.font: textFont]) ?? CGSize.zero
        size.height = textFont.pointSize + paddingY * 2
        size.width += paddingX * 2
        if size.width < size.height {
            size.width = size.height
        }
        return size
    }
}

class TagListView: UIView {
    @IBInspectable open dynamic var marginY: CGFloat = 2 {
        didSet {
            rearrangeViews()
        }
    }
    
    @IBInspectable open dynamic var marginX: CGFloat = 5 {
        didSet {
            rearrangeViews()
        }
    }

    @IBInspectable open dynamic var minWidth: CGFloat = 0 {
        didSet {
            rearrangeViews()
        }
    }
    
    @IBInspectable open dynamic var textColor: UIColor = .black {
        didSet {
            tagViews.forEach {
                $0.textColor = textColor
            }
        }
    }
    
    open private(set) var tagViews: [TagView] = []
    private(set) var tagBackgroundViews: [UIView] = []
    private(set) var rowViews: [UIView] = []
    private(set) var tagViewHeight: CGFloat = 0
    private(set) var rows = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    
    open override func layoutSubviews() {
        defer { rearrangeViews() }
        super.layoutSubviews()
    }
    
    private func rearrangeViews() {
        var currentRow = 0
        var currentRowView: UIView!
        var currentRowTagCount = 0
        var currentRowWidth: CGFloat = 0
        let frameWidth = frame.width
        
        for (index, tagView) in tagViews.enumerated() {
            tagView.frame.size = tagView.intrinsicContentSize
            tagViewHeight = tagView.frame.height
            
            if currentRowTagCount == 0 || currentRowWidth + tagView.frame.width > frameWidth {
                currentRow += 1
                currentRowWidth = 0
                currentRowTagCount = 0
                currentRowView = UIView()
                currentRowView.transform = .identity
                currentRowView.frame.origin.y = CGFloat(currentRow - 1) * (tagViewHeight + marginY)
                
                rowViews.append(currentRowView)
                addSubview(currentRowView)

                tagView.frame.size.width = min(tagView.frame.size.width, frameWidth)
            }
            let tagBackgroundView = tagBackgroundViews[index]
            tagBackgroundView.transform = .identity
            tagBackgroundView.frame.origin = CGPoint(
                x: currentRowWidth,
                y: 0)
            tagBackgroundView.frame.size = tagView.bounds.size
            tagView.frame.size.width = max(minWidth, tagView.frame.size.width)
            tagBackgroundView.layer.shadowColor = UIColor.white.cgColor
            tagBackgroundView.layer.shadowPath = UIBezierPath(roundedRect: tagBackgroundView.bounds, cornerRadius: 0).cgPath
            tagBackgroundView.layer.shadowOffset = .zero
            tagBackgroundView.layer.shadowOpacity = 0
            tagBackgroundView.layer.shadowRadius = 0
            tagBackgroundView.addSubview(tagView)
            currentRowView.addSubview(tagBackgroundView)
            
            currentRowTagCount += 1
            currentRowWidth += tagView.frame.width + marginX
            
            currentRowView.frame.origin.x = (frameWidth - (currentRowWidth - marginX)) / 2
            currentRowView.frame.size.width = currentRowWidth
            currentRowView.frame.size.height = max(tagViewHeight, currentRowView.frame.height)
        }
        rows = currentRow
        invalidateIntrinsicContentSize()
    }
    
    @discardableResult
    open func addTags(_ titles: [String]) -> [TagView] {
        return addTagViews(titles.map(createNewTagView))
    }
    
    open func removeAllTags() {
        tagViews.removeAll()
        tagBackgroundViews.removeAll()
        rowViews.removeAll()
    }
    
    @discardableResult
    open func addTagViews(_ tagViewList: [TagView]) -> [TagView] {
        defer { rearrangeViews() }
        tagViewList.forEach {
            tagViews.append($0)
            tagBackgroundViews.append(UIView(frame: $0.bounds))
        }
        return tagViews
    }
    
    private func createNewTagView(_ title: String) -> TagView {
        let tagView = TagView(title: title)
        tagView.textAlignment = .center
        tagView.textColor = .black
        tagView.font = UIFont.SFProDisplay(.regular, size: 14)
        tagView.tagBackgroundColor = #colorLiteral(red: 0.1000831202, green: 0.1472782791, blue: 0.1932071447, alpha: 0.05)
        tagView.cornerRadius = 8
        return tagView
    }
}
