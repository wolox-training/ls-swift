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
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
