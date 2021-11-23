//
//  ApiService.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 4/11/21.
//

import Moya
import CocoaLumberjack
import RxSwift

let provider = MoyaProvider<ApiService>()
typealias HandleCompletion<T> = (Result<T, ApiError>) -> Void

enum ApiService {
    case books
    case addBook(book: Book)
    case commentsById(bookId: Int)
    case userById(userId: Int)
    case suggestionsById(bookId: Int)
    case rentalsByUserId(userId: Int)
}

extension ApiService: TargetType {
    var baseURL: URL {
        let url = URL(string: ApiConfig.manager.endpoint)!
        return url
    }
    
    var path: String {
        switch self {
        case .books:
            return ApiConfig.manager.apiVersion.appending(Constants.PathWS.books)
        case .addBook:
            return ApiConfig.manager.apiVersion.appending(Constants.PathWS.books)
        case .commentsById(let id):
            return ApiConfig.manager.apiVersion.appending(Constants.PathWS.bookCommentsById(id: id))
        case .userById(let id):
            return ApiConfig.manager.apiVersion.appending(Constants.PathWS.userById(id: id))
        case .rentalsByUserId(let id):
            return ApiConfig.manager.apiVersion.appending(Constants.PathWS.rentalsByUserId(id: id))
        case .suggestionsById(bookId: let bookId):
            return "/book/\(bookId)/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .books, .suggestionsById, .commentsById, .userById, .rentalsByUserId:
            return .get
        case .addBook:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .books, .suggestionsById, .commentsById, .userById, .rentalsByUserId:
            return .requestPlain
        case .addBook(let newBook):
            let parameters = [
                "author": newBook.author ?? "",
                "title": newBook.title ?? "",
                "image": newBook.image ?? "",
                "year": newBook.year ?? "",
                "genre": newBook.genre ?? "",
                "status": newBook.status!.rawValue
            ]
            return .requestJSONEncodable(parameters)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    static func statusResponse(_ response: Response) throws {
        guard let httpResponse = response.response,
              httpResponse.statusCode == 200 || httpResponse.statusCode == 201
        else {
            switch response.statusCode {
            case 401:
                throw ApiError.apiError(reason: "Unauthorized")
            case 403:
                throw ApiError.apiError(reason: "Resource forbidden")
            case 404:
                throw ApiError.networkError(from: URLError(.badServerResponse))
            case 405..<500:
                throw ApiError.apiError(reason: "Client error")
            default:
                throw ApiError.apiError(reason: "Server error")
            }
        }
    }
}
