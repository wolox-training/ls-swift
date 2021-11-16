//
//  ApiError.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 7/11/21.
//
import Foundation

enum ApiError: Error, LocalizedError {
    case unknown, apiError(reason: String), parserError(reason: String), networkError(from: URLError)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason), .parserError(let reason):
            return reason
        case .networkError(let from):
            return from.localizedDescription
        }
    }
}
