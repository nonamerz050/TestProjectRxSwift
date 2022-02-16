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
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return .just(())
    }
}
