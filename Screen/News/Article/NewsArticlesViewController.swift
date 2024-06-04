//
//  NewsArticlesViewController.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 03/06/24.
//

import UIKit
import PKHUD
import SafariServices

final class NewsArticlesViewController: UIViewController {
    
    private let viewModel: NewsArticlesViewModel
    private let newsCollection: UICollectionView = {
        let flow: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = .vertical
        
        let collection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    private let searchController: UISearchController = {
        let controller: UISearchController = UISearchController()
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Find news"
        
        return controller
    }()
    
    init(viewModel: NewsArticlesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        newsCollection.register(NewsArticleCell.self, forCellWithReuseIdentifier: NewsArticleCell.reusableIdentifier)
        
        newsCollection.delegate = self
        newsCollection.dataSource = self

        HUD.show(.progress)
        
        title = "News"
        view.addSubview(newsCollection)
        NSLayoutConstraint.activate([
            newsCollection.topAnchor.constraint(equalTo: view.safeTopAnchor),
            newsCollection.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            newsCollection.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            newsCollection.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
        
        viewModel.getArticles(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.newsCollection.reloadData()
                HUD.hide()
            }
        })
    }
}

extension NewsArticlesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsArticleCell.reusableIdentifier, for: indexPath) as? NewsArticleCell else {
            return UICollectionViewCell()
        }
        
        let article: NewsData = viewModel.articles[indexPath.row]
        
        cell.setupView(with: article)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let newsLink = URL(string: viewModel.articles[indexPath.row].newsURL) {
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: newsLink, configuration: config)
            vc.modalPresentationStyle = .overFullScreen
            
            present(vc, animated: true)
        }
    }
}

extension NewsArticlesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = collectionView.frame.width / 2 - 8
        
        return CGSize(width: width, height: 220)
    }
}

extension NewsArticlesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchedText = searchController.searchBar.text else { return }
        
        if searchedText.isEmpty {
            viewModel.articles = viewModel.preservedArticles
            newsCollection.reloadData()
        } else if searchedText.count % 3 == 0 {
            HUD.show(.progress)
            
            viewModel.getAllArticles(keyword: searchedText) { [weak self] in
                DispatchQueue.main.async {
                    
                    guard let self else { return }
                    
                    self.newsCollection.reloadData()
                    HUD.hide()
                }
            }
        } else {
            return
        }
    }
}
