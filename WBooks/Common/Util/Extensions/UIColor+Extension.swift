//
//  UIColor+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 27/10/21.
//

import UIKit

enum AssetsColor: String {
    case borderButtonInitial = "BorderButtonInitial"
    case primaryColor = "PrimaryColor"
    case secondaryColor = "SecondaryColor"
    case titleColor = "TitleColor"
    case accentColor = "AccentColor"
    case shadowBoxColor = "ShadowBoxColor"
    case availableColor = "AvailableColor"
    case unavailableColor = "UnavailableColor"
    case gradientB1 = "GradientB1"
    case gradientB2 = "GradientB2"
    case gradientBD1 = "GradientBD1"
    case gradientBD2 = "GradientBD2"
    case gradientBD3 = "GradientBD3"
    case separatorLineColor = "SeparatorLineColor"
    case placeholderColor = "PlaceholderColor"
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
