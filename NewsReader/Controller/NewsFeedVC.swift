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
    private var searchThroughRSSItems = [RSSItem?]()
    var isSearching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        tableView.refreshControl = myRefreshControl
        
    }
    
    // fetch data
    private func fetchData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://www.vesti.ru/vesti.rss") { (rssItems) in
            self.rssItems = rssItems
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    // refresh data
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func refresh(sender: UIRefreshControl) {
        fetchData()
        sender.endRefreshing()
    }
    
    // pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToTheFullNewsVC"{
            let destinationVC = segue.destination as! FullNewsVC
            destinationVC.item = sender as? RSSItem
        }
    }
    
}

// MARK: - TableView

extension NewsFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchThroughRSSItems.count
        } else {
            guard let rssItems = rssItems else {
                return 0
            }
            return rssItems.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        if isSearching {
            if let item = searchThroughRSSItems[indexPath.item] {
                cell.item = item
            }
            return cell
        } else {
            if let item = rssItems?[indexPath.item] {
                cell.item = item
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = rssItems?[indexPath.item]
        performSegue(withIdentifier: "ToTheFullNewsVC", sender: item)
    }
    
}

// MARK: - Search Bar

extension NewsFeedVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            searchThroughRSSItems = rssItems!.filter({ value -> Bool in
                guard let text = searchBar.text?.lowercased() else { return false}
                return value.title.lowercased().contains(text)
            })
            tableView.reloadData()
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
