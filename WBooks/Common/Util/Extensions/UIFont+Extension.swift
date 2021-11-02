//
//  UIFont+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 2/11/21.
//

import UIKit

enum FontName: String {
    case regularSF = "SFUIText-Regular"
    case regularItalicSF = "SFUIText-RegularItalic"
    case lightSF = "SFUIText-Light"
    case lightItalicSF = "SFUIText-LightItalic"
    case mediumSF = "SFUIText-Medium"
    case mediumItalicSF = "SFUIText-MediumItalic"
    case semiboldSF = "SFUIText-Semibold"
    case semiboldItalicSF = "SFUIText-SemiboldItalic"
    case boldSF = "SFUIText-Bold"
    case boldItalicSF = "SFUIText-BoldItalic"
    case heavySF = "SFUIText-Heavy"
    case heavyItalicSF = "SFUIText-HeavyItalic"
}

extension UIFont {
    static func customFont(_ fontName: FontName, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: fontName.rawValue, size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }
}
