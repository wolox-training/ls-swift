//
//  String+Extension.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 27/10/21.
//

import Foundation

extension String {
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
