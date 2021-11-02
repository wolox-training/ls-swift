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
}
