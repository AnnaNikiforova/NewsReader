//
//  ViewController.swift
//  NewsReader
//
//  Created by Анна Никифорова on 10.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class NewsFeedVC: UIViewController {
    
    private var rssItems: [RSSItem]?
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        tableView.refreshControl = myRefreshControl
      
    }
    
    private func fetchData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://www.vesti.ru/vesti.rss") { (rssItems) in
            self.rssItems = rssItems
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        fetchData()
        sender.endRefreshing()
    }

}

// MARK: - TableView

extension NewsFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        if let item = rssItems?[indexPath.item] {
            cell.item = item
        }
        return cell
    }
    
}

