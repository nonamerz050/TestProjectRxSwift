//
//  NewsListCoordinator.swift
//  TestProjectRxSwift
//
//  Created by MacBook Pro on 16/2/22.
//

import UIKit
import RxSwift

class NewsListCoordinator {
    private let window: UIWindow
    private weak var navigationController: UINavigationController?
    let disposeBag = DisposeBag()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() -> Observable<Void> {
        let viewModel = NewsListViewModel()
        let rootViewController = NewsListViewController (
            coordinator: self,
            viewModel: viewModel
            )
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.rightBarButtonItem = UIBarButtonItem()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return .just(())
    }
    
    func coordinateToCard(article: Article) {
        guard let navigationController = navigationController else { return }
        let detailsCoodinator = CardCoordinator(navigationController: navigationController, article: article)
        detailsCoodinator.start()
            .subscribe()
            .disposed(by: disposeBag)
    }
}
