//
//  BookDetailViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 09/11/21.
//

import Foundation

protocol BookDetailViewModelType {
    var navBarTitle: String { get }
    func createInfographicsViewModel() -> InfographicViewModel
}

public class BookDetailViewModel: BookDetailViewModelType {
    
    // MARK: Properties
    private let book: Book
    
    var navBarTitle: String {
        "bookDetailTitleNavBar".localized()
    }
    
    init(book: Book) {
        self.book = book
    }
    
    func createInfographicsViewModel() -> InfographicViewModel {
        return InfographicViewModel(book: book)
    }
    
    func createCommentsViewModel() -> CommentsViewModel {
        return CommentsViewModel(bookId: book.id)
    }
}
