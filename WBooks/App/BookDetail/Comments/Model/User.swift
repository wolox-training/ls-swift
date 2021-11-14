//
//  User.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 11/11/21.
//

import UIKit

// MARK: - User
struct User: Codable {
    let id: Int
    let username,
        password,
        image,
        createdAt,
        updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, password, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
