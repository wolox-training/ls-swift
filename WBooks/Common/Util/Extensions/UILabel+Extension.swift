//
//  UILabel+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 2/11/21.
//

import UIKit

public protocol TypographyExtensions: UILabel {
    var lineHeight: CGFloat? { get set }
}

extension NSAttributedString {
    var entireRange: NSRange {
        NSRange(location: 0, length: self.length)
    }
}

extension UILabel: TypographyExtensions {
    var paragraphStyle: NSParagraphStyle? {
        getAttribute(.paragraphStyle)
    }
    
    fileprivate func setAttribute(_ key: NSAttributedString.Key, value: Any?) {
        if let value = value {
            addAttribute(key, value: value)
        } else {
            removeAttribute(key)
        }
    }
    
    fileprivate var attributes: [NSAttributedString.Key : Any]? {
        if let attributedText = attributedText {
            return attributedText.attributes(at: 0, effectiveRange: nil)
        } else {
            return nil
        }
    }
    
    fileprivate func getAttribute<AttributeType>(_ key: NSAttributedString.Key) -> AttributeType? {
        return attributes?[key] as? AttributeType
    }
    
    fileprivate func addAttribute(_ key: NSAttributedString.Key, value: Any) {
        if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.addAttribute(key, value: value, range: attributedText.entireRange)
            self.attributedText = mutableAttributedText
        } else {
            self.attributedText = NSAttributedString(string: text ?? "", attributes: attributes)
        }
    }
    
    fileprivate func removeAttribute(_ key: NSAttributedString.Key) {
        if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.removeAttribute(key, range: attributedText.entireRange)
            self.attributedText = mutableAttributedText
        }
    }
    
    func setParagraphStyleProperty<ValueType>(
        _ value: ValueType,
        for keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, ValueType>
    ) {
        let mutableParagraphStyle = NSMutableParagraphStyle()
        if let paragraphyStyle = paragraphStyle {
            mutableParagraphStyle.setParagraphStyle(paragraphyStyle)
        }
        mutableParagraphStyle[keyPath: keyPath] = value
        setAttribute(.paragraphStyle, value: mutableParagraphStyle)
    }
    
    public var lineHeight: CGFloat? {
        get { paragraphStyle?.maximumLineHeight }
        set {
            let lineHeight = newValue ?? 0.0
            let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / 2.0
            addAttribute(.baselineOffset, value: baselineOffset)
            setParagraphStyleProperty(lineHeight, for: \.minimumLineHeight)
            setParagraphStyleProperty(lineHeight, for: \.maximumLineHeight)
        }
    }
    
    func letterSpacing(_ value: CGFloat) {
        if let textString = text {
            let attrs: [NSAttributedString.Key : Any] = [.kern: value]
            attributedText = NSAttributedString(string: textString, attributes: attrs)
        }
    }
}
