//
//  Comment.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 11/11/21.
//

import Foundation

typealias Comments = [Comment]

// MARK: - Comment

struct Comment: Codable, Hashable {
    let id, userId, bookId: Int
    let content, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case bookId = "book_id"
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
