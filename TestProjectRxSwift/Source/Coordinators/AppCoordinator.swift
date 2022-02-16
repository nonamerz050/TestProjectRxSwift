//
//  AppCoordinator.swift
//  TestProjectRxSwift
//
//  Created by MacBook Pro on 16/2/22.
//

import UIKit
import RxSwift

class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() -> Observable<Void> {
        let newsListCoordinator = NewsListCoordinator(window: window)
        
        return newsListCoordinator.start()
    }
}
