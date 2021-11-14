//
//  CommentsViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 10/11/21.
//

import Foundation
import RxSwift

final class CommentsViewController: BaseViewController, UIScrollViewDelegate {
    
    // MARK: Properties
    private lazy var commentsView = CommentsView()
    private var viewModel: CommentsViewModel
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadComments()
    }
    
    override func loadView() {
        super.loadView()
        view = commentsView
    }
}

private extension CommentsViewController {
    
    // MARK: Custom methods
    func setupTableView() {
        commentsView.tableView.register(CommentCell.self)
        commentsView.tableView.rowHeight = Helper.sizeBy(height: 127).screenHeight
    }
    
    func loadComments() {
        commentsView.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.observableComments()
            .subscribe(on: MainScheduler.instance)
            .bind(to: commentsView.tableView.rx.items(cellIdentifier: "CommentCell", cellType: CommentCell.self)) { (row, _, cell) in
                // Configure the cell
                let commentCellViewModel = self.viewModel.createCommentViewModel(commentIndex: row)
                commentCellViewModel.observableUser()
                    .subscribe { _ in
                        cell.configureView(viewModel: commentCellViewModel)
                    }.disposed(by: disposeBag)
            }.disposed(by: disposeBag)
    }
}
