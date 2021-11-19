//
//  BookCellViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 7/11/21.
//

import UIKit

protocol BookCellViewModelType {
    var title: String { get }
    var author: String { get }
    var image: String { get }
    func validateString(_ value: String?) -> String
}

final class BookCellViewModel: BookCellViewModelType {
    
    // MARK: Properties
    private let book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    var title: String {
        validateString(book.title)
    }
    var author: String {
        validateString(book.author)
    }
    var image: String {
        book.image ?? ""
    }
    
    func validateString(_ value: String?) -> String {
        if let dataString = value, !dataString.isEmpty {
            return dataString.capitalized
        } else {
            return "Unknown"
        }
    }
}
