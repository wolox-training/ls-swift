//
//  BookCell.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 28/10/21.
//

import UIKit
import CocoaLumberjack
import Kingfisher
import RxSwift

final class BookCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var cellView: UIView! {
        didSet {
            cellView.layer.cornerRadius = 5
            cellView.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var bookTitle: UILabel! {
        didSet {
            guard let fontSF = UIFont(name: FontName.boldSF.rawValue, size: 17) else {
                fatalError("""
                    Failed to load the "SF Bold" font.
                    """
                )
            }
            bookTitle.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: fontSF)
            bookTitle.lineHeight = 20
            bookTitle.letterSpacing(-0.41)
            bookTitle.textColor = UIColor.appColor(.titleColor)
        }
    }
    @IBOutlet weak var bookAuthor: UILabel! {
        didSet {
            guard let fontSF = UIFont(name: FontName.lightSF.rawValue, size: 15) else {
                fatalError("""
                    Failed to load the "SF Bold" font.
                    """
                )
            }
            bookAuthor.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: fontSF)
            bookAuthor.lineHeight = 18
            bookAuthor.letterSpacing(-0.24)
            bookAuthor.textColor = UIColor.appColor(.titleColor)
        }
    }
    @IBOutlet weak var bookImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionColor = UIColor.appColor(.shadowBoxColor)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let edgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        cellView.frame = cellView.frame.inset(by: edgeInsets)
        cellView.shadow()
    }
    
    // MARK: Custom methods
    public func configureView(viewModel: BookCellViewModel) {
        bookTitle.text = viewModel.title
        bookAuthor.text = viewModel.author
        let imageUrl = URL(string: viewModel.image)
        bookImage.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(named: "Cover6"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { result in
            switch result {
            case .success(let value):
                DDLogDebug("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                DDLogError("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
