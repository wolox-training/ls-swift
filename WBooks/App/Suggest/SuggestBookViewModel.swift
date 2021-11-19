//
//  SuggestBookViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 14/11/21.
//

import RxSwift
import CocoaLumberjack

protocol SuggestBookViewModelType {
    var bookData: BehaviorSubject<Book> { get set }
    var navBarTitle: String { get }
    var submitLabel: String { get }
    var bookNamePlaceholder: String { get }
    var authorPlaceholder: String { get }
    var yearPlaceholder: String { get }
    var topicPlaceholder: String { get }
    var descriptionPlaceholder: String { get }
    var chooseOptionAlertMessage: String { get }
    var galleryAlertAction: String { get }
    var cameraAlertAction: String { get }
    var cancelAlertAction: String { get }
    func addBook(newBook: Book, completion: @escaping HandleCompletion<Book>)
}

public class SuggestBookViewModel: SuggestBookViewModelType {
    
    // MARK: Properties
    private let repository: BookRepositoryProtocol
    internal var books: Books = Books()
    var bookData: BehaviorSubject<Book> = BehaviorSubject<Book>(value: Book())
    
    var navBarTitle: String {
        "suggestTitleNavBar".localized()
    }
    var submitLabel: String {
        "submitButton".localized()
    }
    var bookNamePlaceholder: String {
        "bookNamePlaceholder".localized()
    }
    var authorPlaceholder: String {
        "authorPlaceholder".localized()
    }
    var yearPlaceholder: String {
        "yearPlaceholder".localized()
    }
    var topicPlaceholder: String {
        "topicPlaceholder".localized()
    }
    var descriptionPlaceholder: String {
        "descriptionPlaceholder".localized()
    }
    var chooseOptionAlertMessage: String {
        "chooseOptionAlertMessage".localized()
    }
    var galleryAlertAction: String {
        "galleryAlertAction".localized()
    }
    var cameraAlertAction: String {
        "cameraAlertAction".localized()
    }
    var cancelAlertAction: String {
        "cancelAlertAction".localized()
    }
    
    init(repository: BookRepositoryProtocol = BookRepository()) {
        self.repository = repository
    }
    
    // MARK: API Requests
    func addBook(newBook: Book, completion: @escaping HandleCompletion<Book>) {
        self.repository.addBook(book: newBook, completion: { result in
            switch result {
            case .success(let book):
                DDLogDebug("Book \(String(describing: book.title))")
                self.bookData.onNext(book)
                completion(.success(book))
            case .failure(let error):
                var msgError = "Error creating book"
                msgError = msgError.appending(error.errorDescription ?? "")
                DDLogError(msgError)
                completion(.failure(error))
            }
        })
    }
}
