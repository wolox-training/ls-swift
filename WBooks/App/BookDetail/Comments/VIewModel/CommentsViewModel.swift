//
//  CommentsViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 10/11/21.
//

import UIKit
import RxSwift
import CocoaLumberjack

protocol CommentsViewModelType {
    func createCommentViewModel(commentIndex: Int) -> CommentViewModel
    func observableComments() -> Observable<Comments>
}

public class CommentsViewModel {
    
    // MARK: Properties
    private let bookId: Int
    private let repository: BookRepositoryProtocol
    internal var comments: Comments = Comments()
    
    init(bookId: Int, repository: BookRepositoryProtocol = BookRepository()) {
        self.bookId = bookId
        self.repository = repository
    }
    
    func createCommentViewModel(commentIndex: Int) -> CommentViewModel {
        CommentViewModel(comment: comments[commentIndex])
    }
    
    func observableComments() -> Observable<Comments> {
        return Observable.create { [weak self] observer in
            self?.repository.fetchComments(bookId: self?.bookId ?? 0, completion: { [weak self] result in
                switch result {
                case .success(let comments):
                    DDLogDebug("Comments \(comments.count)")
                    self?.comments = comments
                    observer.onNext(comments)
                    observer.onCompleted()
                case .failure(let error):
                    var msgError = "Error getting Comments "
                    msgError = msgError.appending(error.errorDescription ?? "")
                    DDLogError(msgError)
                    observer.onError(error)
                }
            })
            return Disposables.create()
        }
    }
}
