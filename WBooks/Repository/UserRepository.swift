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
    func fetchUser(userId: Int, completion: @escaping HandleCompletion<User>)
    func fetchRentals(userId: Int, completion: @escaping HandleCompletion<Rentals>)
}

internal class UserRepository: UserRepositoryProtocol {
    
    // MARK: API calls
    func fetchUser(userId: Int, completion: @escaping HandleCompletion<User>) {
        provider.rx.request(.userById(userId: userId)).flatMap { (response) ->
            Single<User> in
            try ApiService.statusResponse(response)
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
    
    func fetchRentals(userId: Int, completion: @escaping HandleCompletion<Rentals>) {
        provider.rx.request(.rentalsByUserId(userId: userId)).flatMap { (response) ->
            Single<Rentals> in
            try ApiService.statusResponse(response)
            let rentals = try response.map(Rentals.self)
            return Single.just(rentals)
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
