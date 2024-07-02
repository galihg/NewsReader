//
//  NewsCoordinator.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import Foundation

final class NewsCoordinator: Coordinator {
    
    var screen: Screen = NewsCategoriesScreen()
    private var router: Navigation = Router.shared
    
    func startCoordinator() {
        router.show(view: screen, style: .push)
        
        if let viewController = screen.viewController as? NewsCategoriesViewController {
            viewController.onOpenSource = { category in
                self.screen = NewsSourcesScreen(viewModel: NewsSourcesViewModel(categoryName: category))
                
                DispatchQueue.main.async {
                    Router.shared.show(view: self.screen, style: .push)
                    self.observeNewsSource()
                }
            }
        }
    }
    
    private func observeNewsSource() {
        
        if let viewController = screen.viewController as? NewsSourcesViewController {
            viewController.onOpenArticle = { source in
                self.screen = NewsArticlesScreen(viewModel: NewsArticlesViewModel(source: source))
                
                DispatchQueue.main.async {
                    Router.shared.show(view: self.screen, style: .push)
                }
            }
        }
    }
}
