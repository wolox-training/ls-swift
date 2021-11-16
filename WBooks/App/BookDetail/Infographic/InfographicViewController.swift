//
//  InfographicViewController.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 09/11/21.
//

import UIKit

final class InfographicViewController: BaseViewController {
    
    // MARK: Properties
    private lazy var infographicView = InfographicView()
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
        infographicView.configure(viewModel: viewModel)
    }
    
    override func loadView() {
        super.loadView()
        view = infographicView
    }
}
