//
//  SceneDelegate.swift
//  TestProjectRxSwift
//
//  Created by MacBook Pro on 15/2/22.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let disposeBag = DisposeBag()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let appCoordinator = AppCoordinator(window: window)
        
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
    }

}

