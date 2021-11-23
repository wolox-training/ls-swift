//
//  BooksTableViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 19/11/21.
//

import UIKit
import RxSwift
import RxCocoa
import CocoaLumberjack

final class BooksTableViewController: BaseViewController, UIScrollViewDelegate {
    
    // MARK: Properties
    private lazy var booksView = BooksTableView()
    private var viewModel: BooksTableViewModelType
    private var loadingView: UIActivityIndicatorView!
    
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
        setupTableView()
        loadBooks()
    }
    
    override func loadView() {
        view = booksView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchBooks()
        booksView.booksTable.reloadData()
    }
}

private extension BooksTableViewController {
    
    // MARK: Custom methods
    func setupTableView() {
        booksView.booksTable.register(BookCell.self)
        booksView.booksTable.rowHeight = Helper.sizeBy(height: 100).screenHeight
    }
    
    func loadBooks() {
        viewModel.fetchBooks()
        booksView.booksTable.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.booksData
            .subscribe(on: MainScheduler.instance)
            .catch({ error in
                DDLogError("Error: \(error.localizedDescription)")
                return Observable.empty()
            })
            .bind(to: booksView.booksTable.rx.items(cellIdentifier: "BookCell", cellType: BookCell.self)) { (row, _, cell) in
                // Configure the cell
                let bookCellViewModel = self.viewModel.createBookCellViewModel(for: row)
                cell.configureView(viewModel: bookCellViewModel)
            }.disposed(by: disposeBag)
        
        booksView.booksTable.rx.modelSelected(Book.self)
            .subscribe(onNext: { [weak self] book in
                guard let bookDetailViewModel = self?.viewModel.createBookDetailViewModel(book: book) else { return }
                let bookDetailViewController = BookDetailViewController(viewModel: bookDetailViewModel)
                bookDetailViewController.modalPresentationStyle = .fullScreen
                bookDetailViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(bookDetailViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
