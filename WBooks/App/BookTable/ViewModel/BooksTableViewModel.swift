//
//  BooksTableViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 19/11/21.
//

import RxSwift
import CocoaLumberjack

protocol BooksTableViewModelType {
    var books: Books { get set }
    var booksData: BehaviorSubject<Books> { get set }
    var navBarTitle: String { get }
    func fetchBooks()
    func createBookCellViewModel(for bookIndex: Int) -> BookCellViewModel
    func createBookDetailViewModel(book: Book) -> BookDetailViewModel
}

public class BooksTableViewModel: NSObject, BooksTableViewModelType {
    
    // MARK: Properties
    internal let repository: BookRepositoryProtocol
    internal var books: Books = Books()
    var booksData: BehaviorSubject<Books> = BehaviorSubject<Books>(value: Books())
    
    var navBarTitle: String {
        "libraryTitleNavBar".localized()
    }
    
    init(repository: BookRepositoryProtocol = BookRepository()) {
        self.repository = repository
    }
    
    func createBookCellViewModel(for bookIndex: Int) -> BookCellViewModel {
        return BookCellViewModel(book: books[bookIndex])
    }
    
    func createBookDetailViewModel(book: Book) -> BookDetailViewModel {
        return BookDetailViewModel(book: book)
    }
    
    func fetchBooks() {
        self.repository.fetchBooks(completion: { [weak self] result in
            switch result {
            case .success(let books):
                DDLogDebug("Books \(books.count)")
                self?.books = books
                self?.booksData.on(.next(books))
            case .failure(let error):
                var msgError = "Error getting Books "
                msgError = msgError.appending(error.errorDescription ?? "")
                DDLogError(msgError)
            }
        })
    }
}