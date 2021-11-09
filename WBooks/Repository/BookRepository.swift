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
            let books = try response.map(Books.self)
            return Single.just(books)
        }.subscribe(onSuccess: { (data) in
            print("JSON: \(data)")
            completion(.success(data))
        },onFailure: { (error) in
            print("Error: \(error.localizedDescription)")
            let dataError = MoyaError.underlying(error, nil)
            let errorModel = ErrorModel(timestamp: nil, message: dataError.localizedDescription, statusCode: nil)
            completion(.failure(.apiError(errorModel)))
        }).disposed(by: disposeBag)
    }
}
