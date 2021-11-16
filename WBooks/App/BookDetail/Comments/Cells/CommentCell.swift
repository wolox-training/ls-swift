//
//  CommentCell.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 11/11/21.
//

import UIKit

final class CommentCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentUsername: UILabel!
    @IBOutlet weak var commentDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
}
