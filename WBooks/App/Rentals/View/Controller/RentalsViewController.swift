//
//  RentalsViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 19/11/21.
//

import CocoaLumberjack

final class RentalsViewController: BaseViewController {
    
    // MARK: Properties
    private lazy var rentalsView = RentalsView()
    private var viewModel: BooksTableViewModelType
    private var tableViewController = BooksTableViewController(viewModel: RentalsViewModel())
    
    init(viewModel: BooksTableViewModelType) {
        self.viewModel = viewModel
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
        view = rentalsView
    }
    
    func configureNavigation() {
        initNavigation(title: viewModel.navBarTitle, hasBack: false)
        let tapGestureRecognizerSearch = UITapGestureRecognizer(target: self, action: #selector(activeSearch))
        addNavBarRightIcon(iconName: .iconSearch, tapGestureRecognizer: tapGestureRecognizerSearch)
        let tapGestureRecognizerNotification = UITapGestureRecognizer(target: self, action: #selector(redirectNotificaion))
        addNavBarLeftIcon(iconName: .iconNotification, tapGestureRecognizer: tapGestureRecognizerNotification)
    }
    
    private func loadViews() {
        let container: UIView = rentalsView.viewContainer
        let childView: UIView = tableViewController.view
        add(tableViewController, frame: container.frame)
        container.translatesAutoresizingMaskIntoConstraints = false
        childView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: container.topAnchor),
            childView.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor),
            childView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
    }
    
    @objc func activeSearch() {
        DDLogInfo("Active search")
    }
    
    @objc func redirectNotificaion() {
        DDLogInfo("Redirect notification")
    }
}
