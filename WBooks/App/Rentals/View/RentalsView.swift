//
//  RentalsView.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 19/11/21.
//

import UIKit

final class RentalsView: BaseNibView {
    
    // MARK: Properties
    @IBOutlet weak var navigationBar: UIImageView!
    @IBOutlet weak var viewContainer: UIView! {
        didSet {
            viewContainer.backgroundColor = UIColor.appColor(.accentColor)
        }
    }
}
