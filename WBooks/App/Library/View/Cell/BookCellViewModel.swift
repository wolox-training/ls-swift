//
//  BookCellViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 7/11/21.
//

import UIKit

final class BookCellViewModel {
    
    // MARK: Properties
    private let book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    var title: String {
        return book.title ?? "Unknown"
    }
    var author: String {
        return book.author ?? "Unknown"
    }
    var image: String {
        return book.image ?? ""
    }
}
