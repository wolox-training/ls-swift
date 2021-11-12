//
//  Book.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 30/10/21.
//

import Foundation

typealias Books = [Book]

// MARK: - Book
struct Book: Codable, Hashable {
    let id: Int
    let image,
        title,
        author,
        year,
        genre: String?
    let status: BookStatus
    let createdAt,
        updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case image, title, author, year, genre
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum BookStatus: String, Codable {
    case available = "Available"
    case unavailable = "Unavailable"
}
