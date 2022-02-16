//
//  NewsListViewModel.swift
//  TestProjectRxSwift
//
//  Created by MacBook Pro on 16/2/22.
//

import UIKit
import RxSwift
import RxCocoa

class NewsListViewModel {
    func transform(_ input: Input, outputHandler: (Output) -> Void) {
        let articlesSignal = input.refreshSignal
            .flatMap { _ -> Driver<[Article]> in
                return NetworkManager.shared.getNews().asDriver(onErrorJustReturn: [])
            }
        
        let output = Output (
            articlesModel: articlesSignal
        )
        
        outputHandler(output)
    }
}
