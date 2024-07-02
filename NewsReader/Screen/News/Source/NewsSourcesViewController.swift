//
//  NewsSourcesViewController.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import UIKit
import PKHUD

final class NewsSourcesViewController: UIViewController {
    
    var onOpenArticle: ((String) -> Void)?
    
    private let sourceCellID: String = "NewsSourceCell"
    private let viewModel: NewsSourcesViewModel
    
    private lazy var sourceList: UITableView = {
        let list: UITableView = UITableView.construct()
        list.bounces = false
        list.rowHeight = 48
        list.dataSource = self
        list.delegate = self
        
        return list
    }()
    
    init(viewModel: NewsSourcesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        HUD.show(.progress)
        
        title = "Sources"
        sourceList.register(UITableViewCell.self, forCellReuseIdentifier: sourceCellID)
        view.addSubview(sourceList)
        NSLayoutConstraint.activate([
            sourceList.topAnchor.constraint(equalTo: view.safeTopAnchor),
            sourceList.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            sourceList.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            sourceList.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
        
        viewModel.getNewsSources(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.sourceList.reloadData()
                HUD.hide()
            }
        })
    }
}

extension NewsSourcesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: sourceCellID, for: indexPath)
        let sourceName: String = viewModel.sources[indexPath.row].name
        cell.selectionStyle = .none
        cell.textLabel?.text = sourceName
        
        return cell
    }
}

extension NewsSourcesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onOpenArticle?(viewModel.sources[indexPath.row].id)
    }
}
