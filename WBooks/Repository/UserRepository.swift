//
//  UserRepository.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 14/11/21.
//

import RxSwift
import Moya
import CocoaLumberjack

protocol UserRepositoryProtocol {
    func fetchUser(userId: Int, completion: @escaping (Result<User, ApiError>) -> Void)
}

internal class UserRepository: UserRepositoryProtocol {
    
    // MARK: API calls
    func fetchUser(userId: Int, completion: @escaping (Result<User, ApiError>) -> Void) {
        provider.rx.request(.userById(userId: userId)).flatMap { (response) -> Single<User> in
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
            let user = try response.map(User.self)
            return Single.just(user)
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
