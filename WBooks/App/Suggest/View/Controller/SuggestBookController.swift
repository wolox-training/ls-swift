//
//  SuggestBookController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 14/11/21.
//

import UIKit
import RxSwift
import CocoaLumberjack

final class SuggestBookController: BaseViewController {
    
    // MARK: Properties
    private lazy var suggestBookView = SuggestBookView()
    public var viewModel: SuggestBookViewModelType
    
    init(viewModel: SuggestBookViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestBookView.configure(viewModel: viewModel)
        configureNavigation()
        settingAlert()
        addBookTapped()
        setValidator()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        setValidator()
        suggestBookView.clean()
    }
    
    override func loadView() {
        super.loadView()
        view = suggestBookView
    }
    
    // MARK: Custom methods
    func configureNavigation() {
        initNavigation(title: viewModel.navBarTitle, hasBack: false)
        let tapGestureRecognizerSearch = UITapGestureRecognizer(target: self, action: #selector(activeSearch))
        addNavBarRightIcon(iconName: .iconSearch, tapGestureRecognizer: tapGestureRecognizerSearch)
        let tapGestureRecognizerNotification = UITapGestureRecognizer(target: self, action: #selector(redirectNotificaion))
        addNavBarLeftIcon(iconName: .iconNotification, tapGestureRecognizer: tapGestureRecognizerNotification)
    }
    
    @objc func activeSearch() {
        DDLogInfo("Active search")
    }
    
    @objc func redirectNotificaion() {
        DDLogInfo("Redirect notification")
    }
    
    @objc private func addBook() {
        guard suggestBookView.validateForm else {
            return
        }
        DDLogDebug("addBookTapped")
        var newBook: Book = Book()
        newBook.title = suggestBookView.bookNameTextField.text
        newBook.author = suggestBookView.authorTextField.text
        newBook.image = ""
        newBook.genre = suggestBookView.topicTextField.text
        newBook.status = BookStatus.available
        newBook.year = suggestBookView.yearTextField.text
        
        viewModel.addBook(newBook: newBook) { [weak self] result in
            switch result {
            case .success(let book):
                DDLogDebug("Added book: \(String(describing: book.id))")
                self?.suggestBookView.clean()
                self?.showMessage()
            case .failure(let error):
                var msgError = "Error creating book"
                msgError = msgError.appending(error.errorDescription ?? "")
                DDLogError(msgError)
            }
        }
    }
    
    private func addBookTapped() {
        suggestBookView.submitButton.rx.tap
            .throttle(.seconds(Int(0.5)), latest: false, scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.addBook()
            }.disposed(by: disposeBag)
    }
        
    private func setValidator() {
        let validator = { (value: String) in return !value.isEmpty }
        suggestBookView.bookNameTextField.setValidator(validator)
        suggestBookView.authorTextField.setValidator(validator)
        suggestBookView.yearTextField.setValidator(validator)
        suggestBookView.topicTextField.setValidator(validator)
        suggestBookView.descriptionTextField.setValidator(validator)        
    }
}

extension SuggestBookController: UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
    func showMessage() {
        let alertActions: [AlertAction] = [
            .action(title: viewModel.okAlertAction.localized())
        ]
        showAlert(title: Constants.AppInfo.appName,
                  message: viewModel.titleAddBookAlertMessage.localized(),
                  style: .alert,
                  actions: alertActions
        ).subscribe(onNext: { _ in
            print("Redirect")
        }).disposed(by: disposeBag)
    }
    
    func settingAlert() {
        suggestBookView.addPhotoButton.rx.tap.asDriver().drive(onNext: {
            self.showAlert(title: Constants.AppInfo.appName,
                           message: self.viewModel.chooseOptionAlertMessage,
                           style: .actionSheet,
                           actions: self.addAlertActions()
            ).subscribe(onNext: { [weak self] selectedIndex in
                self?.handleAlertAction(selectedIndex)
            }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
    }
    
    func handleAlertAction(_ selectedIndex: Int) {
        print(selectedIndex)
        switch selectedIndex {
        case 0:
            DDLogDebug("Load Gallery")
            self.showPickerBy(.photoLibrary)
        case 1:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                DDLogDebug("Load Camera")
                self.showPickerBy(.camera)
            }
        default:
            DDLogDebug("Cancel")
        }
    }
    
    func addAlertActions() -> [AlertAction] {
        var alertActions: [AlertAction] = [
            .action(title: viewModel.galleryAlertAction)
        ]
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let takeAction = AlertAction.action(title: viewModel.cameraAlertAction)
            alertActions.append(takeAction)
        }
        let cancelAction = AlertAction.action(title: viewModel.cancelAlertAction,
                                              style: .cancel)
        alertActions.append(cancelAction)
        return alertActions
    }
    
    func showPickerBy(_ sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        self.present(imagePickerController, animated: true, completion: .none)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        suggestBookView.loadImage(selectedImage)
        picker.dismiss(animated: true, completion: nil)
    }
}
