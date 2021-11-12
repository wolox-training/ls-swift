//
//  InfographicViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 09/11/21.
//

import Foundation

protocol InfographicViewModelType {
    var image: String { get }
    var title: String { get }
    var status: BookStatus { get }
    var author: String { get }
    var year: String { get }
    var genre: String { get }
    func availability(_ bookStatus: BookStatus) -> String
}

public class InfographicViewModel: InfographicViewModelType {
    
    // MARK: Properties
    internal var book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    var image: String {
        book.image ?? ""
    }
    var title: String {
        book.title ?? "Unknown"
    }
    var status: BookStatus {
        book.status
    }
    var author: String {
        book.author ?? "Unknown"
    }
    var year: String {
        book.year ?? ""
    }
    var genre: String {
        book.genre ?? "Unknown"
    }
    var isBookAvailable: Bool {
        status == BookStatus.available
    }
    var addToWishlistLabel: String {
        "addToWishlistButton".localized()
    }
    var rentLabel: String {
        "rentButton".localized()
    }
    
    func availability(_ bookStatus: BookStatus) -> String {
        switch bookStatus {
        case .available:
            return "available".localized()
        default:
            return "unavailable".localized()
        }
    }
}
