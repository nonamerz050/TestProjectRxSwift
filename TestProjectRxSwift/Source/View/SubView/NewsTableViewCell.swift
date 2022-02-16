//
//  NewsTableViewCell.swift
//  TestProjectRxSwift
//
//  Created by MacBook Pro on 16/2/22.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: MagicNumbers.x2, weight: .medium)
        return label
    }()
    
    private lazy var newsSubtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSubtitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsImageView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: contentView.frame.size.width,
                                     height: contentView.frame.size.height / 2)
        newsTitleLabel.frame = CGRect(x: 10,
                                      y: 150,
                                      width: contentView.frame.size.width - 20,
                                      height: 80)
        newsSubtitleLabel.frame = CGRect(x: 10,
                                      y: 230,
                                      width: contentView.frame.size.width - 20,
                                      height: 50)
    }
    
    func configureWithArticle(article: Article) {
        newsImageView.kf.setImage(with: URL(string: article.urlToImage ?? EmptyImage.imgUrl))
        newsTitleLabel.text = article.title
        newsSubtitleLabel.text = article.content
    }
}
