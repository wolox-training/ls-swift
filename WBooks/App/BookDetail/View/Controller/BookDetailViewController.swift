//
//  BookDetailViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 09/11/21.
//

import UIKit

final class BookDetailViewController: BaseViewController {
    
    // MARK: Properties
    private lazy var bookDetailView = BookDetailView()
    private var viewModel: BookDetailViewModel
    private let infographicViewController: InfographicViewController
    private let commentsViewController: CommentsViewController
    
    init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        let infographicViewModel = viewModel.createInfographicsViewModel()
        infographicViewController = InfographicViewController(viewModel: infographicViewModel)
        let commentsViewModel = viewModel.createCommentsViewModel()
        commentsViewController = CommentsViewController(viewModel: commentsViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        loadViews()
    }
    
    override func loadView() {
        view = bookDetailView
    }
    
    func configureNavigation() {
        initNavigation(title: viewModel.navBarTitle, hasBack: true)
    }
    
    private func loadViews() {
        let container: UIView = bookDetailView.detailView
        let infographicFrame: CGRect = CGRect(x: 0.0,
                                   y: 0.0,
                                   width: UIScreen.main.bounds.size.width,
                                   height: Helper.sizeBy(height: 308).screenHeight)
        let commentsframe: CGRect = CGRect(x: 0.0,
                                   y: Helper.sizeBy(height: 308).screenHeight,
                                   width: UIScreen.main.bounds.size.width,
                                   height: Helper.sizeBy(height: 250).screenHeight)
        addChilToContainer(infographicViewController,
                           frame: infographicFrame,
                           container: container)
        addChilToContainer(commentsViewController,
                           frame: commentsframe,
                           container: container)
    }
}
