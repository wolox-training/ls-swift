//
//  LibraryViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 28/10/21.
//

import RxSwift
import CocoaLumberjack

protocol LibraryViewModelType {
    var books: Books { get set }
    var navBarTitle: String { get }
    func observableBooks() -> Observable<Books>
    func createBookCellViewModel(for bookIndex: Int) -> BookCellViewModel
}

public class LibraryViewModel: NSObject, LibraryViewModelType {
    
    // MARK: Properties
    private let repository: BookRepositoryProtocol
    internal var books: Books = Books()
    
    var navBarTitle: String {
        "libraryTitleNavBar".localized()
    }
    
    init(repository: BookRepositoryProtocol = BookRepository()) {
        self.repository = repository
    }
    
    func createBookCellViewModel(for bookIndex: Int) -> BookCellViewModel {
        return BookCellViewModel(book: books[bookIndex])
    }
    
    func observableBooks() -> Observable<Books> {
        return Observable.create { [weak self] observer in
            self?.repository.fetchBooks(completion: { [weak self] result in
                switch result {
                case .success(let books):
                    print("Books \(books.count)")
                    self?.books = books
                    observer.onNext(books)
                    observer.onCompleted()
                case .failure(let error):
                    print("Error Books \(error.get())")
                    observer.onError(error)
                }
            })
            return Disposables.create()
        }
    }
}
