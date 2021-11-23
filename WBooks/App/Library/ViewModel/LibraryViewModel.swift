//
//  LibraryViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 28/10/21.
//

import CocoaLumberjack

public class LibraryViewModel: BooksTableViewModel {
    
    // MARK: Properties
    private let bookRepository: BookRepositoryProtocol
    override var navBarTitle: String {
        "libraryTitleNavBar".localized()
    }
    
    init(bookRepository: BookRepositoryProtocol = BookRepository()) {
        self.bookRepository = bookRepository
    }
    
    override func fetchBooks() {
        self.bookRepository.fetchBooks(completion: { [weak self] result in
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
