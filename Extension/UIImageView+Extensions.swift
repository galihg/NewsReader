//
//  UIImageView+Extensions.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 04/06/24.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func getImage(from link: String) {
        
        guard let url = URL(string: link) else { return }
        
        downloadImage(from: url)
    }
}
