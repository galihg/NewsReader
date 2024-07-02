//
//  NewsCategoryViewModel.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import Foundation
import UIKit

final class NewsSourcesViewModel: NSObject {
    
    var sources: [(id: String, name: String)] = []

    private let service: NewsServiceable
    private let categoryName: String
    
    init(service: NewsServiceable = NewsService(), categoryName: String) {
        self.service = service
        self.categoryName = categoryName
    }
    
    func getNewsSources(completion: @escaping () -> Void) {
        service.fetchNewsSources(with: categoryName.lowercased(), completionHandler: { [weak self] sourcesData in
            
            for source in sourcesData {
                self?.sources.append((source.id ?? "", source.name ?? ""))
            }
            
            completion()
        })
    }
}


