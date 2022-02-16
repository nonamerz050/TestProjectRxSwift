//
//  NewsListViewController.swift
//  TestProjectRxSwift
//  Created by MacBook Pro on 16/2/22.
//

import UIKit
import RxSwift
import RxCocoa

class NewsListViewController: UIViewController {
    
//    private let reloadSignal = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    private let tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableview
    }()
    
    let viewModel: NewsListViewModel!
    let coordinator: NewsListCoordinator
    
    init(coordinator: NewsListCoordinator, viewModel: NewsListViewModel) {
        
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .white
        view.addSubview(tableView)

        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

private extension NewsListViewController {
    
    func setupViews() {
        Observable.just(300)
            .bind(to: tableView.rx.rowHeight)
            .disposed(by: disposeBag)
    }
}
