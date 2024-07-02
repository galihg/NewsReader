//
//  NewsArticleCell.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import UIKit

struct NewsData {
    let newsTitle: String
    let newsImageURL: String
    let newsSource: String
    let newsDate: String
    let newsURL: String
}

final class NewsArticleCell: UICollectionViewCell {
    
    static var reusableIdentifier: String {
        "NewsArticleCell"
    }
    
    private lazy var newsTitle: UILabel = {
        let label: UILabel = UILabel.construct()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left

        return label
    }()
    
    private lazy var newsSource: UILabel = {
        let label: UILabel = UILabel.construct()
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left

        return label
    }()
    
    private lazy var newsTime: UILabel = {
        let label: UILabel = UILabel.construct()
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left

        return label
    }()
    
    private lazy var articleGroup: UIStackView = {
        let stack: UIStackView = UIStackView.construct()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    private lazy var thumbnail: UIImageView = {
        let view: UIImageView = UIImageView.construct()
        view.contentMode = .scaleToFill
        
        return view
    }()
    
    override func prepareForReuse() {
        newsTitle.text = nil
        newsTime.text = nil
        newsSource.text = nil
        thumbnail.image = nil
        
        super.prepareForReuse()
    }
    
    func setupView(with data: NewsData) {
        newsTitle.text = data.newsTitle
        newsTime.text = data.newsDate
        newsSource.text = data.newsSource
        
        thumbnail.getImage(from: data.newsImageURL)
        articleGroup.addArrangedSubviews(newsSource, newsTitle)
        contentView.addSubviews(thumbnail, newsTime, articleGroup)
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: contentView.safeTopAnchor, constant: 8.0),
            thumbnail.leadingAnchor.constraint(equalTo: contentView.safeLeadingAnchor, constant: 16.0),
            thumbnail.trailingAnchor.constraint(equalTo: contentView.safeTrailingAnchor, constant: -16.0),
            thumbnail.heightAnchor.constraint(equalToConstant: contentView.frame.height / 3 + 16),
            thumbnail.widthAnchor.constraint(equalToConstant: contentView.frame.width / 3 + 24),
            newsTime.topAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: 4.0),
            newsTime.leadingAnchor.constraint(equalTo: contentView.safeLeadingAnchor, constant: 16.0),
            newsTime.trailingAnchor.constraint(equalTo: contentView.safeTrailingAnchor, constant: -16.0),
            newsTime.heightAnchor.constraint(equalToConstant: 16),
            newsTime.widthAnchor.constraint(equalToConstant: contentView.frame.width - 32.0),
            articleGroup.topAnchor.constraint(equalTo: newsTime.bottomAnchor, constant: 8.0),
            articleGroup.leadingAnchor.constraint(equalTo: contentView.safeLeadingAnchor, constant: 16.0),
            articleGroup.trailingAnchor.constraint(equalTo: contentView.safeTrailingAnchor, constant: -16.0),
            articleGroup.widthAnchor.constraint(equalToConstant: contentView.frame.width - 32.0),
            contentView.bottomAnchor.constraint(equalTo: articleGroup.bottomAnchor, constant: 8.0)
        ])
    }
}
