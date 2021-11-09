//
//  LibraryViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 28/10/21.
//

import UIKit
import RxSwift
import RxCocoa
import CocoaLumberjack

final class LibraryViewController: BaseViewController, UIScrollViewDelegate {
    
    // MARK: Properties
    private lazy var libraryView = LibraryView()
    private var viewModel: LibraryViewModelType
    private var loadingView: UIActivityIndicatorView!
    
    init(viewModel: LibraryViewModelType) {
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
        loadLibrary()
        configureNavigation()
    }
    
    override func loadView() {
        view = libraryView
    }
    
    func configureNavigation() {
        initNavigation(title: viewModel.navBarTitle, hasBack: false)
        let tapGestureRecognizerSearch = UITapGestureRecognizer(target: self, action: #selector(activeSearch))
        addNavBarRightIcon(iconName: .iconSearch, tapGestureRecognizer: tapGestureRecognizerSearch)
        let tapGestureRecognizerNotification = UITapGestureRecognizer(target: self, action: #selector(redirectNotificaion))
        addNavBarLeftIcon(iconName: .iconNotification, tapGestureRecognizer: tapGestureRecognizerNotification)
    }
    
    @objc func activeSearch() {
        DDLogInfo("Active search")
    }
    
    @objc func redirectNotificaion() {
        DDLogInfo("Redirect notification")
    }
}

extension LibraryViewController {
    
    // MARK: Custom methods
    private func setupTableView() {
        libraryView.libraryTable.register(BookCell.self)
        libraryView.libraryTable.rowHeight = Helper.sizeBy(height: 100).screenHeight
    }
    
    private func loadLibrary() {
        libraryView.libraryTable.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.observableBooks()
            .subscribe(on: MainScheduler.instance)
            .bind(to: libraryView.libraryTable.rx.items(cellIdentifier: "BookCell", cellType: BookCell.self)) { (row, _, cell) in
                // Configure the cell
                let bookCellViewModel = self.viewModel.createBookCellViewModel(for: row)
                cell.configureView(viewModel: bookCellViewModel)
            }.disposed(by: disposeBag)
    }
}
