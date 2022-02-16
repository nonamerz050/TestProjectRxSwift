//
//  NetworkManager.swift
//  TestProjectRxSwift
//
//  Created by MacBook Pro on 16/2/22.
//

import Foundation
import RxSwift

class NetworkManager {
    static let shared = NetworkManager()
    
    func getData<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return }
                
                do {
                    let news = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(news)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    func getNews() -> Observable<[Article]> {
        let url = URL(string: API.urlString)!
        let articlesModel: Observable<ArticleModel> = getData(url: url)
        
        return articlesModel
            .map { $0.articles }
    }
}
