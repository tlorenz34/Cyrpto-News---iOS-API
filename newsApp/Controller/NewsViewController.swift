//
//  ViewController.swift
//  newsApp
//
//  Created by Thaddeus Lorenz on 10/11/21.
//

import UIKit
import Coinpaprika

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
// set tableview
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
// create array to store news articles fetched from API
    
    private var news = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
// custom views
        
        title = "Today"
        
// Tableview setup and reloading of data
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = .none

        
// API Caller that fetches data
        
        APICaller.shared.getTopStories{ [weak self] result in
            switch result{
            case .success(let articles):
                self?.news = articles.compactMap({ News(title: $0.title, imageURL: URL(string: $0.urlToImage ?? "")
                )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
// subview
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
// Tableview functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: news[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    

}

