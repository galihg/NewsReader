//
//  NewsScreen.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import UIKit

final class NewsCategoriesScreen: Screen {
    
    var viewController: UIViewController?
    
    func make() -> UIViewController {
        let newsCategoryViewController: UIViewController = NewsCategoriesViewController()
        viewController = newsCategoryViewController
        
        return newsCategoryViewController
    }
}
