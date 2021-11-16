//
//  InfographicViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 09/11/21.
//

protocol InfographicViewModelType {
    var image: String { get }
    var title: String { get }
    var status: BookStatus { get }
    var statusValue: String { get }
    var statusColor: AssetsColor { get }
    var author: String { get }
    var year: String { get }
    var genre: String { get }
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
    var statusValue: String {
        isBookAvailable ? "available".localized() : "unavailable".localized()
    }
    var statusColor: AssetsColor {
        isBookAvailable ? .availableColor : .unavailableColor
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
}
