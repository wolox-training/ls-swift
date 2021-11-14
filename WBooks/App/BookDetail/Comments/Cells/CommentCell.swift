//
//  CommentCell.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 11/11/21.
//

import UIKit
import CocoaLumberjack
import Kingfisher
import RxSwift

final class CommentCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var cellView: UIView! {
        didSet {
            cellView.layer.cornerRadius = 5
            cellView.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var commentImage: UIImageView! {
        didSet {
            commentImage.layer.cornerRadius = 23
            commentImage.layer.borderColor = UIColor.white.cgColor
            commentImage.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var commentUsername: UILabel! {
        didSet {
            guard let fontSF = UIFont(name: FontName.boldSF.rawValue, size: 15) else {
                fatalError("""
                    Failed to load the "SF Bold" font.
                    """
                )
            }
            commentUsername.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: fontSF)
            commentUsername.lineHeight = 18
            commentUsername.letterSpacing(-0.36)
            commentDescription.textColor = UIColor.appColor(.primaryColor)
        }
    }
    @IBOutlet weak var commentDescription: UILabel! {
        didSet {
            guard let fontSF = UIFont(name: FontName.lightSF.rawValue, size: 15) else {
                fatalError("""
                    Failed to load the "SF Bold" font.
                    """
                )
            }
            commentDescription.font = UIFontMetrics(forTextStyle: .callout).scaledFont(for: fontSF)
            commentDescription.lineHeight = 18
            commentDescription.letterSpacing(-0.24)
            commentDescription.textColor = UIColor.appColor(.titleColor)
        }
    }
    @IBOutlet weak var separatorLine: UILabel! {
        didSet {
            separatorLine.backgroundColor = UIColor.appColor(.separatorLineColor)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionColor = UIColor.appColor(.shadowBoxColor)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellView.shadow()
    }
    
    // MARK: Custom methods
    public func configureView(viewModel: CommentViewModel) {
        commentUsername.text = viewModel.username
        commentDescription.text = viewModel.content
        let imageUrl = URL(string: viewModel.image)
        commentImage.kf.setImage(
            with: imageUrl,
            placeholder: UIImage.loadAssets(.Commentator1),
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
