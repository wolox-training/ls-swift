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
    func fetchComments(bookId: Int,
                       completion: @escaping HandleCompletion<Comments>)
}

internal class CommentRepository: CommentRepositoryProtocol {
    
    // MARK: API calls
    func fetchComments(bookId: Int,
                       completion: @escaping HandleCompletion<Comments>) {
        let endpoint = ApiService.commentsById(bookId: bookId)
        provider.rx.request(endpoint).flatMap { (response) ->
            Single<Comments> in
            try ApiService.statusResponse(response)
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
