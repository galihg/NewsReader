//
//  NewsArticlesScreen.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 03/06/24.
//

import UIKit

final class NewsArticlesScreen: Screen {
    
    var viewController: UIViewController?
    var viewModel: NewsArticlesViewModel
    
    init(viewModel: NewsArticlesViewModel) {
        self.viewModel = viewModel
    }
    
    func make() -> UIViewController {
        let newsArticlesViewController: UIViewController = NewsArticlesViewController(viewModel: viewModel)
        
        viewController = newsArticlesViewController
        
        return newsArticlesViewController
    }
}
