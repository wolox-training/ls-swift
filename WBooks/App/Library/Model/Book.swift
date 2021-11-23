//
//  Book.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 30/10/21.
//

typealias Books = [Book]

// MARK: - Book
struct Book: Codable {
    var id: Int?
    var image: String?
    var title, author, year: String?
    var status: BookStatus?
    var genre, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, image, title, author, year, status, genre
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum BookStatus: String, Codable {
    case available = "Available"
    case unavailable = "Unavailable"
}
