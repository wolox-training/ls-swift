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
    func fetchBooks(completion: @escaping HandleCompletion<Books>)
    func addBook(book: Book, completion: @escaping HandleCompletion<Book>)
}

internal class BookRepository: BookRepositoryProtocol {
    
    // MARK: API calls
    func fetchBooks(completion: @escaping HandleCompletion<Books>) {
        provider.rx.request(.books).flatMap { (response) -> Single<Books> in
            try ApiService.statusResponse(response)
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
    
    func addBook(book: Book, completion: @escaping HandleCompletion<Book>) {
        provider.rx.request(.addBook(book: book)).flatMap { (response) -> Single<Book> in
            try ApiService.statusResponse(response)
            let book = try response.map(Book.self)
            return Single.just(book)
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
