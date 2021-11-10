//
//  ApiService.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 4/11/21.
//

import Foundation
import Moya
import CocoaLumberjack
import RxSwift

let provider = MoyaProvider<ApiService>()

enum ApiService {
    case books
    case commentsById(bookId: Int)
    case suggestionsById(bookId: Int)
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
        case .commentsById(let id):
            return Constants.PathWS.bookCommentsById(id: id)
        case .suggestionsById(bookId: let bookId):
            return "/book/\(bookId)/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .books, .suggestionsById, .commentsById:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .books:
            return .requestPlain
        case .suggestionsById(let id), .commentsById(let id):
            let parameters = [
                "id": id
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
