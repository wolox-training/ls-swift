//
//  ApiError.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 7/11/21.
//

enum ApiError: Error {
    case apiError(ErrorModel)
    
    func get() -> ErrorModel {
        switch self {
        case .apiError(let model):
            return model
        }
    }
}

struct ErrorModel: Codable {
    let timestamp, message: String?
    let statusCode: Int?
    
    enum ApiError: String, CodingKey {
        case timestamp, message
        case statusCode
    }
}
