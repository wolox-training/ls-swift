//
//  Rentals.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 22/11/21.
//

typealias Rentals = [Rental]

// MARK: - Rental
struct Rental: Codable {
    let id, userId, bookId: Int?
    let to, from, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case bookId = "book_id"
        case to, from
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
