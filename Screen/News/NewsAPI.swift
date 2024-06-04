//
//  NewsAPI.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import Foundation

enum NewsAPI: APIData {
    
    case getAllNews(keyword: String)
    case getNews(source: String)
    case getSources(category: String)
    
    var path: String {
        switch self {
        case .getNews:
            return "top-headlines?"
        case .getSources:
            return "top-headlines/sources?"
        case .getAllNews:
            return "everything?"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getSources(let category):
            return RequestParams(urlParameters: ["category": category], bodyParameters: nil)
        case .getNews(let source):
            return RequestParams(urlParameters: ["sources": source], bodyParameters: nil)
        case .getAllNews(let keyword):
            return RequestParams(urlParameters: ["q": keyword], bodyParameters: nil)
        }
    }
    
    var headers: [String : String]? {
        return ["X-Api-Key": "bf4067d707084c4eb83fc018d5ba2166"]
    }
    
    var dataType: ResponseDataType {
        switch self {
        case .getNews, .getAllNews, .getSources:
            return .Data
        }
    }
}
