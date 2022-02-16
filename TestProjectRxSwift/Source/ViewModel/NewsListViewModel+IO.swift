//
//  NewsListViewModel+IO.swift
//  TestProjectRxSwift
//
//  Created by MacBook Pro on 16/2/22.
//

import UIKit
import RxCocoa

extension NewsListViewModel {
    struct Input {
        var refreshSignal: Driver<Void>
    }
    
    struct Output {
        var articlesModel: Driver<[Article]>
    }
}
