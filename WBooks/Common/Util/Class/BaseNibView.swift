//
//  BaseNibView.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 26/10/21.
//

import UIKit

class BaseNibView: UIView, NibLoadeable {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
}
