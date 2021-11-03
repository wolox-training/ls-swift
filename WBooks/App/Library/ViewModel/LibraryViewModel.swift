//
//  LibraryViewModel.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 28/10/21.
//

import Foundation

public class LibraryViewModel: NSObject {
    private(set) var bookData: Books! {
        didSet {
            self.bindBooks()
        }
    }
    var bindBooks: () -> Void = {}
    
    func getBooks(completion: @escaping (Result<Books, Error>) -> Void) {
        Helper.loadDummy { result in
            switch result {
            case .success(let books):
                self.bookData = books
            case .failure(_):
                print("Error getting the books")
            }
        }
    }
}
