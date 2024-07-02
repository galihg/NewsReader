//
//  NewsService.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import Foundation

public protocol NewsServiceable {
    func fetchNewsSources(with categoryName: String, completionHandler: @escaping ([NewsSource]) -> Void)
    func fetchNews(source: String, completionHandler: @escaping ([NewsArticle]) -> Void)
    func fetchAllNews(keyword: String, completionHandler: @escaping ([NewsArticle]) -> Void)
}

final class NewsService: NewsServiceable {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchAllNews(keyword: String, completionHandler: @escaping ([NewsArticle]) -> Void) {
        apiClient.fetch(request: NewsAPI.getAllNews(keyword: keyword), basePath: "https://newsapi.org/v2/", keyDecodingStrategy: .useDefaultKeys, completionHandler: { (response: Result<News<[NewsArticle]>, NetworkError>) in
            
            switch response {
            case .success(let result):
                
                if let articles = result.articles {
                    completionHandler(articles)
                } else {
                    print(NetworkError.noResponseData)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchNews(source: String, completionHandler: @escaping ([NewsArticle]) -> Void) {
        apiClient.fetch(request: NewsAPI.getNews(source: source), basePath: "https://newsapi.org/v2/", keyDecodingStrategy: .useDefaultKeys, completionHandler: { (response: Result<News<[NewsArticle]>, NetworkError>) in
            
            switch response {
            case .success(let result):
                
                if let articles = result.articles {
                    completionHandler(articles)
                } else {
                    print(NetworkError.noResponseData)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchNewsSources(with categoryName: String, completionHandler: @escaping ([NewsSource]) -> Void) {
        
        apiClient.fetch(request: NewsAPI.getSources(category: categoryName), basePath: "https://newsapi.org/v2/", keyDecodingStrategy: .useDefaultKeys, completionHandler: { (response: Result<NewsCategory<[NewsSource]>, NetworkError>) in
            
            switch response {
            case .success(let result):
                
                if let sources = result.sources {
                    completionHandler(sources)
                } else {
                    print(NetworkError.noResponseData)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
