//
//  InfographicView.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 09/11/21.
//

import UIKit
import CocoaLumberjack

final class InfographicView: BaseNibView {
    
    // MARK: Properties
    @IBOutlet var viewContainer: UIView! {
        didSet {
            viewContainer.backgroundColor = UIColor.appColor(.accentColor)
        }
    }
    @IBOutlet weak var infograficView: UIView! {
        didSet {
            infograficView.layer.cornerRadius = 5
            infograficView.backgroundColor = UIColor.white
            infograficView.shadow()
        }
    }
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel! {
        didSet {
            guard let fontSF = UIFont(name: FontName.boldSF.rawValue, size: 22) else {
                fatalError("""
                    Failed to load the "SF Bold" font.
                    """
                )
            }
            bookTitleLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: fontSF)
            bookTitleLabel.lineHeight = 24
            bookTitleLabel.letterSpacing(-0.58)
            bookTitleLabel.textColor = UIColor.appColor(.titleColor)
        }
    }
    @IBOutlet weak var bookStatusLabel: UILabel! {
        didSet {
            guard let fontSF = UIFont(name: FontName.boldSF.rawValue, size: 15) else {
                fatalError("""
                    Failed to load the "SF Bold" font.
                    """
                )
            }
            bookStatusLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: fontSF)
            bookStatusLabel.lineHeight = 18
            bookStatusLabel.letterSpacing(-0.36)
        }
    }
    @IBOutlet weak var bookAuthorLabel: UILabel! {
        didSet {
            setDefaultStyle(bookAuthorLabel)
        }
    }
    @IBOutlet weak var bookYearLabel: UILabel! {
        didSet {
            setDefaultStyle(bookYearLabel)
        }
    }
    @IBOutlet weak var bookGenreLabel: UILabel! {
        didSet {
            setDefaultStyle(bookGenreLabel)
        }
    }
    @IBOutlet weak var addToWishlistButton: UIButton! {
        didSet {
            addToWishlistButton.setStyle(.transparent)
        }
    }
    @IBOutlet weak var rentButton: UIButton!
    
    // MARK: Custom methods
    func configure(viewModel: InfographicViewModel) {
        bookTitleLabel.text = viewModel.title
        bookAuthorLabel.text = viewModel.author
        bookYearLabel.text = viewModel.year
        bookStatusLabel.text = viewModel.statusValue
        bookStatusLabel.textColor = UIColor.appColor(viewModel.statusColor)
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
        addToWishlistButton.setTitle(viewModel.addToWishlistLabel, for: .normal)
        rentButton.setTitle(viewModel.rentLabel, for: .normal)
        rentButton.setStyle(viewModel.isBookAvailable ? .blue : .grey)
    }
    
    fileprivate func setDefaultStyle(_ label: UILabel) {
        guard let fontSF = UIFont(name: FontName.lightSF.rawValue, size: 15) else {
            fatalError("""
                Failed to load the "SF Light" font.
                """
            )
        }
        label.font = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: fontSF)
        label.lineHeight = 16
        label.letterSpacing(-0.24)
        label.textColor = UIColor.appColor(.titleColor)
    }
}
