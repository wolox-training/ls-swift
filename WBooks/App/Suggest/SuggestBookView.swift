//
//  SuggestBookView.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 14/11/21.
//

import UIKit

final class SuggestBookView: BaseNibView {
    
    // MARK: Properties
    var validateForm: Bool {
        return bookNameTextField.isValidField()
        && authorTextField.isValidField()
        && yearTextField.isValidField()
        && topicTextField.isValidField()
        && descriptionTextField.isValidField()
    }
    @IBOutlet var viewContainer: UIView! {
        didSet {
            viewContainer.backgroundColor = UIColor.appColor(.accentColor)
        }
    }
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var addPhotoButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var submitButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bookNameTextField: CustomTextField!
    @IBOutlet weak var authorTextField: CustomTextField!
    @IBOutlet weak var yearTextField: CustomTextField!
    @IBOutlet weak var topicTextField: CustomTextField!
    @IBOutlet weak var descriptionTextField: CustomTextField!
    @IBOutlet weak var addPhotoButton: UIButton! {
        didSet {
            addPhotoButton.setBackgroundImage(UIImage.loadAssets(.addPhoto), for: .normal)
        }
    }
    @IBOutlet weak var submitButton: UIButton!
    
    override func layoutSubviews() {
        stackView.spacing = Helper.sizeBy(height: 20).screenHeight
        viewTopConstraint.constant = Helper.sizeBy(height: 38).screenHeight
        viewBottomConstraint.constant = Helper.sizeBy(height: 10).screenHeight
        addPhotoButtonTopConstraint.constant = Helper.sizeBy(height: 26).screenHeight
        stackViewTopConstraint.constant = Helper.sizeBy(height: 31).screenHeight
        submitButtonTopConstraint.constant = Helper.sizeBy(height: 39).screenHeight
    }
    
    // MARK: Custom methods
    func configure(viewModel: SuggestBookViewModelType) {
        bookNameTextField.placeholder = viewModel.bookNamePlaceholder
        authorTextField.placeholder = viewModel.authorPlaceholder
        yearTextField.placeholder = viewModel.yearPlaceholder
        topicTextField.placeholder = viewModel.topicPlaceholder
        descriptionTextField.placeholder = viewModel.descriptionPlaceholder
        submitButton.setTitle(viewModel.submitLabel, for: .normal)
        submitButton.setStyle(.blue)
    }
    
    func loadImage(_ selectedImage: UIImage) {
        addPhotoButton.setBackgroundImage(selectedImage, for: .normal)
        addPhotoButton.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(
            withDuration: 0.9,
            delay: 0.0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.2,
            options: .curveEaseInOut,
            animations: {
                let transform = CGAffineTransform(scaleX: 1, y: 1)
                self.addPhotoButton.transform = transform
            },
            completion: nil)
    }
    
    func clean() {
        bookNameTextField.text = ""
        bookNameTextField.setStyleColor(true)
        authorTextField.text = ""
        authorTextField.setStyleColor(true)
        yearTextField.text = ""
        yearTextField.setStyleColor(true)
        topicTextField.text = ""
        topicTextField.setStyleColor(true)
        descriptionTextField.text = ""
        descriptionTextField.setStyleColor(true)
        addPhotoButton.setBackgroundImage(UIImage.loadAssets(.addPhoto), for: .normal)
    }
}
