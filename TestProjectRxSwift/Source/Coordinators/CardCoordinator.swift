//
//  CardCoordinator.swift
//  TestProjectRxSwift
//
//  Created by MacBook Pro on 25/2/22.
//

import UIKit
import RxSwift

class CardCoordinator {
        
    var navigationController: UINavigationController
    var article: Article
    
    init(navigationController: UINavigationController, article: Article) {
        self.navigationController = navigationController
        self.article = article
    }
    
    func start() -> Observable<Void> {
        
//        let viewModel = NewsListViewModel()
        
        let viewController = DetailsViewController(
            coordinator: self,
//            viewModel: viewModel,
            article: article
        )
        navigationController.pushViewController(viewController, animated: true)

        
        return .just(())
    }
}
