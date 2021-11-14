//
//  BookRepository.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 4/11/21.
//

import RxSwift
import Moya
import CocoaLumberjack

protocol BookRepositoryProtocol {
    func fetchBooks(completion: @escaping (Result<Books, ApiError>) -> Void)
}

internal class BookRepository: BookRepositoryProtocol {
    
    // MARK: API calls
    func fetchBooks(completion: @escaping (Result<Books, ApiError>) -> Void) {
        provider.rx.request(.books).flatMap { (response) -> Single<Books> in
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
            
            let books = try response.map(Books.self)
            return Single.just(books)
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
