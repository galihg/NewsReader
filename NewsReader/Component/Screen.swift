//
//  Screen.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import UIKit

protocol Screen {    
    var viewController: UIViewController? { get }
    
    func make() -> UIViewController
}
