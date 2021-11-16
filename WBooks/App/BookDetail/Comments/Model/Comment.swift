//
//  Comment.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 11/11/21.
//

typealias Comments = [Comment]

// MARK: - Comment
struct Comment: Codable {
    let user: User
    let id: Int
    let content: String
}
