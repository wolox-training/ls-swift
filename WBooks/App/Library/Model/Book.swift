//
//  Book.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 30/10/21.
//

import Foundation
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

// MARK: Book convenience initializers and mutators

extension Book {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Book.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        image: String?? = nil,
        title: String?? = nil,
        author: String?? = nil,
        year: String?? = nil,
        status: BookStatus?? = nil,
        genre: String?? = nil,
        createdAt: String?? = nil,
        updatedAt: String?? = nil
    ) -> Book {
        return Book(
            id: id ?? self.id,
            image: image ?? self.image,
            title: title ?? self.title,
            author: author ?? self.author,
            year: year ?? self.year,
            status: status ?? self.status,
            genre: genre ?? self.genre,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum BookStatus: String, Codable {
    case available = "Available"
    case unavailable = "Unavailable"
}

extension Array where Element == Books.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Books.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
