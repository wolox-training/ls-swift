//
//  CommentsViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 10/11/21.
//

import Foundation

final class CommentsViewController: BaseViewController {
    
    // MARK: Properties
    private lazy var commentsView = CommentsView()
    private var viewModel: InfographicViewModel
    
    init(viewModel: InfographicViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = commentsView
    }
}
