//
//  LibraryView.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 28/10/21.
//

import UIKit

class LibraryView: BaseNibView {
    
    //MARK: Properties
    @IBOutlet weak var libraryTable: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        libraryTable.backgroundColor = UIColor.appColor(.accentColor)
        libraryTable.separatorColor = .clear
        libraryTable.contentInset = UIEdgeInsets(top: 29, left: 0, bottom: 0, right: 0);
    }
}
