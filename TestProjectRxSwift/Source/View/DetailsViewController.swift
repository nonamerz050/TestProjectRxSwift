//
//  DetailsViewController.swift
//  TestProjectRxSwift
//
//  Created by MacBook Pro on 25/2/22.
//

import UIKit
import RxSwift
import SnapKit

class DetailsViewController: UIViewController {
    
    let coordinator: CardCoordinator
    let article: Article
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var newsSubtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var sourceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()

    init(coordinator: CardCoordinator, article: Article) {
        self.coordinator = coordinator
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubView()
        prepareArticle()
    }
    
    func setupSubView() {
        view.addSubview(newsTitleLabel)
        view.addSubview(newsSubtitleLabel)
        view.addSubview(newsImageView)
        view.addSubview(sourceNameLabel)

        
        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceNameLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(-40)
        }
        
        newsSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(-40)
        }
        
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        
        sourceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func prepareArticle() {
        sourceNameLabel.text = article.source.name
        newsTitleLabel.text = article.title
        newsSubtitleLabel.text = article.content
        newsImageView.kf.setImage(with: URL(string: article.urlToImage ?? EmptyImage.imgUrl))
    }
}
