//
//  MockNewsService.swift
//  NewsReaderTests
//
//  Created by Kuncoro Galih Gemilang on 04/06/24.
//

import NewsReader

final class MockNewsService: NewsServiceable {
    
    func fetchNewsSources(with categoryName: String, completionHandler: @escaping ([NewsReader.NewsSource]) -> Void) {
        
    }
    
    func fetchNews(source: String, completionHandler: @escaping ([NewsReader.NewsArticle]) -> Void) {
        
    }
    
    func fetchAllNews(keyword: String, completionHandler: @escaping ([NewsReader.NewsArticle]) -> Void) {
        
    }
}
