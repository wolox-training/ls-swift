//
//  BooksTableView.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 19/11/21.
//

import UIKit

final class BooksTableView: BaseNibView {
    
    // MARK: Properties
    @IBOutlet weak var booksTable: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        booksTable.backgroundColor = UIColor.appColor(.accentColor)
        booksTable.separatorColor = .clear
        booksTable.contentInset = UIEdgeInsets(top: 29, left: 0, bottom: 0, right: 0)
    }
}
