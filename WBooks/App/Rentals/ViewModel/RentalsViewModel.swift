//
//  RentalsViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 19/11/21.
//

import RxSwift
import CocoaLumberjack

public class RentalsViewModel: BooksTableViewModel {
    
    // MARK: Properties
    private let bookRepository: BookRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    internal var rentals: Rentals = Rentals()
    override var navBarTitle: String {
        "rentalsTitleNavBar".localized()
    }
    
    init(bookRepository: BookRepositoryProtocol = BookRepository(),
         userRepository: UserRepositoryProtocol = UserRepository()) {
        self.bookRepository = bookRepository
        self.userRepository = userRepository
    }
    
    override func fetchBooks() {
        fetchRentalsByUserId()
    }
    
    func fetchRentalsByUserId() {
        self.userRepository.fetchRentals(userId: 9, completion: { [weak self] result in
            switch result {
            case .success(let rentals):
                DDLogDebug("User \(String(describing: rentals.first?.bookId))")
                self?.rentals = rentals
                self?.fetchBooksByRentals()
            case .failure(let error):
                var msgError = "Error getting User "
                msgError = msgError.appending(error.errorDescription ?? "")
                DDLogError(msgError)
            }
        })
    }
    
    private func filterBooks(_ bookList: (Books)) {
        for rent in self.rentals {
            if let book = bookList.first(where: { book in book.id == rent.bookId }) {
                let hasBook = self.books.contains { currentBook in
                    if book.id == currentBook.id {
                        return true
                    }
                    return false
                }
                if !hasBook {
                    self.books.append(book)
                }
            }
        }
    }
    
    func fetchBooksByRentals() {
        self.bookRepository.fetchBooks(completion: { [weak self] result in
            switch result {
            case .success(let bookList):
                DDLogDebug("Books \(bookList.count)")
                self?.filterBooks(bookList)
                self?.booksData.on(.next(self?.books ?? []))
            case .failure(let error):
                var msgError = "Error getting Books "
                msgError = msgError.appending(error.errorDescription ?? "")
                DDLogError(msgError)
            }
        })
    }
}
