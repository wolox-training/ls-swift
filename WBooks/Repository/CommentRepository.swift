//
//  CommentRepository.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 12/11/21.
//

import RxSwift
import Moya
import CocoaLumberjack

protocol CommentRepositoryProtocol {
    func fetchComments(bookId: Int, completion: @escaping (Result<Comments, ApiError>) -> Void)
}

internal class CommentRepository: CommentRepositoryProtocol {
    
    // MARK: API calls
    func fetchComments(bookId: Int, completion: @escaping (Result<Comments, ApiError>) -> Void) {
        provider.rx.request(.commentsById(bookId: bookId)).flatMap { (response) -> Single<Comments> in
            guard let httpResponse = response.response,
                      httpResponse.statusCode == 200 else {
                          switch response.statusCode {
                          case 401:
                              throw ApiError.apiError(reason: "Unauthorized")
                          case 403:
                              throw ApiError.apiError(reason: "Resource forbidden")
                          case 404:
                              throw ApiError.networkError(from: URLError(.badServerResponse))
                          case 405..<500:
                              throw ApiError.apiError(reason: "Client error")
                          case 500..<600:
                              throw ApiError.apiError(reason: "Server error")
                          default:
                              throw ApiError.apiError(reason: "Server error")
                          }
                      }
            let comments = try response.map(Comments.self)
            return Single.just(comments)
        }.subscribe(onSuccess: { (data) in
            DDLogDebug("JSON: \(data)")
            completion(.success(data))
        }, onFailure: { (error) in
            DDLogError("Error: \(error.localizedDescription)")
            let dataError = MoyaError.underlying(error, nil)
            completion(.failure(.apiError(reason: dataError.localizedDescription)))
        }).disposed(by: disposeBag)
    }
}
