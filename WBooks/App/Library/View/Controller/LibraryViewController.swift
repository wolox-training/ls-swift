//
//  LibraryViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 28/10/21.
//

import UIKit

class LibraryViewController: BaseViewController {
    
    private lazy var libraryView = LibraryView()
    private var viewModel = LibraryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        loadLibrary()
        configureNavigation()
    }
    
    override func loadView() {
        view = libraryView
    }
    
    func loadLibrary() {
        viewModel.getBooks { result in
            switch result {
            case .success(_):
                self.viewModel.bindBooks = {
                    self.libraryView.libraryTable.reloadData()
                }
            case .failure(_):
                print("failure")
            }
        }
    }
    
    func configureNavigation() {
        initNavigation(title: viewModel.navBarTitle, hasBack: false)
        let tapGestureRecognizerSearch = UITapGestureRecognizer(target: self, action: #selector(activeSearch))
        addNavBarRightIcon(iconName: .iconSearch, tapGestureRecognizer: tapGestureRecognizerSearch)
        let tapGestureRecognizerNotification = UITapGestureRecognizer(target: self, action: #selector(redirectNotificaion))
        addNavBarLeftIcon(iconName: .iconNotification, tapGestureRecognizer: tapGestureRecognizerNotification)
    }
    
    @objc func activeSearch() {
        print("Active search")
    }
    
    @objc func redirectNotificaion() {
        print("Redirect notification")
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTable() {
        libraryView.libraryTable.delegate = self
        libraryView.libraryTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Helper.sizeBy(height: 100).screenHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(BookCell.self, indexPath: indexPath)
        cell.configureView(book: viewModel.bookData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        libraryView.libraryTable.cellForRow(at: indexPath)?.backgroundColor = UIColor.appColor(.secondaryColor)?.withAlphaComponent(0.3)
        print("Redirect to detail view")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        libraryView.libraryTable.cellForRow(at: indexPath)?.backgroundColor = .clear
    }
}
