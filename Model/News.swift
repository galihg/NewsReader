//
//  News.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import Foundation

struct News<T: Codable>: Codable {
    let articles: T?
    let status: String?
    let totalResults: Int?
}

struct NewsArticle: Codable {
    let source: NewsSource?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct NewsSource: Codable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}

struct NewsCategory<T: Codable>: Codable {
    let status: String?
    let sources: T?
}
