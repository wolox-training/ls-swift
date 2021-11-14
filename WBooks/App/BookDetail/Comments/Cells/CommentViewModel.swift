//
//  CommentViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 12/11/21.
//

import RxSwift
import CocoaLumberjack

protocol CommentViewModelType {
    var username: String { get }
    var image: String { get }
    var content: String { get }
    func observableUser() -> Observable<User>
}

final class CommentViewModel: CommentViewModelType {
    
    // MARK: Properties
    private let comment: Comment
    private var user: User?
    private let userRepository: UserRepositoryProtocol
    
    init(comment: Comment, userRepository: UserRepositoryProtocol = UserRepository()) {
        self.comment = comment
        self.userRepository = userRepository
    }
    
    var username: String {
        Helper.validateString(user?.username)
    }
    var image: String {
        user?.image ?? ""
    }
    var content: String {
        Helper.validateString(comment.content)
    }
    
    func observableUser() -> Observable<User> {
        return Observable.create { [weak self] observer in
            self?.userRepository.fetchUser(userId: self?.comment.userId ?? 0, completion: { [weak self] result in
                switch result {
                case .success(let user):
                    DDLogDebug("User \(user.username)")
                    self?.user = user
                    observer.onNext(user)
                    observer.onCompleted()
                case .failure(let error):
                    DDLogError("Error getting User \(error.localizedDescription)")
                    observer.onError(error)
                }
            })
            return Disposables.create()
        }
    }
}
