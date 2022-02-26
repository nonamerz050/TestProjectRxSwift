//
//  NewsListViewController.swift
//  TestProjectRxSwift
//  Created by MacBook Pro on 16/2/22.
//

import UIKit
import RxSwift
import RxCocoa

class NewsListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
        
        setupBindings()
        setupInput()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

private extension NewsListViewController {
    
    func setupBindings() {
        tableView
            .rx
            .modelSelected(Article.self)
            .subscribe(onNext: { article in
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
                self.coordinator.coordinateToCard(article: article)
            })
            .disposed(by: disposeBag)
    }
    
    func setupInput() {
        let refreshSignal = Observable.concat(
            .just(()),
            navigationItem.rightBarButtonItem?.rx.tap.asObservable() ?? .empty()
        )
            .asDriver(onErrorJustReturn: ())
        
        let input = NewsListViewModel.Input(
            refreshSignal: refreshSignal
        )
        viewModel.transform(input) { [weak self] output in
            self?.setupOutput(output: output)
        }
    }
    
    func setupOutput(output: NewsListViewModel.Output){
        output.articlesModel
            .drive(tableView.rx.items(
                cellIdentifier: NewsTableViewCell.identifier,
                cellType: NewsTableViewCell.self)
            ) { row, article, cell in
                cell.configureWithArticle(article: article)
            }
            .disposed(by: disposeBag)
    }
}
