//
//  ViewController.swift
//  NewsReader
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import UIKit

final class NewsCategoriesViewController: UIViewController {
    
    var onOpenSource: ((String) -> Void)?
    
    private let categories: [String] = ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]
    private let categoryCellID: String = "NewsCategoryCell"
    
    private lazy var categoryList: UITableView = {
        let list: UITableView = UITableView.construct()
        list.bounces = false
        list.rowHeight = 60
        list.dataSource = self
        list.delegate = self
        
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Categories"
        categoryList.register(UITableViewCell.self, forCellReuseIdentifier: categoryCellID)
        view.addSubview(categoryList)
        NSLayoutConstraint.activate([
            categoryList.topAnchor.constraint(equalTo: view.safeTopAnchor),
            categoryList.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            categoryList.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            categoryList.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
    }
}

extension NewsCategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: categoryCellID, for: indexPath)
        let categoryName: String = categories[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = categoryName
        
        return cell
    }
}

extension NewsCategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onOpenSource?(categories[indexPath.row])
    }
}

