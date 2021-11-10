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
    var image,
        title,
        author: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case author, title, image
        case id
    }
}
