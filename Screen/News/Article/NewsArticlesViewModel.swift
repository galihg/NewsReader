//
//  NewsArticlesViewModel.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 03/06/24.
//

import UIKit

final class NewsArticlesViewModel {
    
    var articles: [NewsData] = []
    var preservedArticles: [NewsData] = []

    private let service: NewsServiceable
    private let source: String

    init(service: NewsServiceable = NewsService(), source: String) {
        self.service = service
        self.source = source
    }
    
    func getArticles(completion: @escaping () -> Void) {
        service.fetchNews(source: source, completionHandler: { [weak self] articles in
            
            guard let self else { return }
            
            for article in articles {
                self.articles.append(NewsData(newsTitle: article.title ?? "", newsImageURL: article.urlToImage ?? "", newsSource: article.source?.name ?? "", newsDate: self.convertDate(time: article.publishedAt ?? ""), newsURL: article.url ?? ""))
            }
            
            self.preservedArticles = self.articles
            
            completion()
        })
    }
    
    func getAllArticles(keyword: String, completion: @escaping () -> Void) {
        service.fetchAllNews(keyword: keyword, completionHandler: { [weak self] articles in
            var news: [NewsData] = []

            for article in articles {
                news.append(NewsData(newsTitle: article.title ?? "", newsImageURL: article.urlToImage ?? "", newsSource: article.source?.name ?? "", newsDate: self?.convertDate(time: article.publishedAt ?? "") ?? "", newsURL: article.url ?? ""))
                self?.articles = news
            }
            
            completion()
        })
    }
    
    private func convertDate(time: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date: Date? = formatter.date(from: time)
        
        return formatter.string(from: date ?? Date())
    }
}
