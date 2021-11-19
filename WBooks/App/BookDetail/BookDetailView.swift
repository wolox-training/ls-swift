//
//  BookDetailView.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 09/11/21.
//

import UIKit

final class BookDetailView: BaseNibView {
    
    // MARK: Properties
    @IBOutlet var viewContainer: UIView! {
        didSet {
            viewContainer.backgroundColor = UIColor.appColor(.accentColor)
        }
    }
    @IBOutlet weak var detailView: UIView! {
        didSet {
            detailView.backgroundColor = .clear
        }
    }
}
