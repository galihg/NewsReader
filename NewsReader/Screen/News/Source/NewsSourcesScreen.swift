//
//  NewsSourceScreen.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 03/06/24.
//

import UIKit

final class NewsSourcesScreen: Screen {
    
    var viewController: UIViewController?
    var viewModel: NewsSourcesViewModel
    
    init(viewModel: NewsSourcesViewModel) {
        self.viewModel = viewModel
    }
    
    func make() -> UIViewController {
        let newsSourceViewController: UIViewController = NewsSourcesViewController(viewModel: viewModel)
        
        viewController = newsSourceViewController
        
        return newsSourceViewController
    }
}
