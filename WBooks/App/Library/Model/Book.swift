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
    let image: String?
    let title: String?
    let id: Int?
    let author: String?
    
    enum CodingKeys: String, CodingKey {
        case author, title, image
        case id
    }
}
