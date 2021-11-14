//
//  CommentsView.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 10/11/21.
//

import UIKit

final class CommentsView: BaseNibView {
    
    // MARK: Properties
    @IBOutlet var viewContainer: UIView! {
        didSet { viewContainer.backgroundColor = .clear }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.layer.cornerRadius = 5
            tableView.clipsToBounds = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        tableView.backgroundColor = UIColor.appColor(.accentColor)
        tableView.separatorColor = .clear
    }
}
