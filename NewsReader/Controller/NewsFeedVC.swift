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
    let categories = ["МВД", "Происшествие", "СМИ", "Экономика", "Главные", "Политика", "Общество", "Наука", "Футбол", "Hi-Tech"]
    var selectedCategory = "Главные"
    var rotationAngle: CGFloat!
    
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.standardAppearance.shadowColor = .clear
        setupCategoryPickerView()
        fetchData()
        tableView.tableFooterView = UIView()
        tableView.refreshControl = myRefreshControl
    }
    
    // setup PickerView
    func setupCategoryPickerView() {
        
        // customization
        categoryPickerView.layer.borderWidth = 0.4
        categoryPickerView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        categoryPickerView.selectRow(4, inComponent: 0, animated: true)
        
        // picker view rotation
        let y = self.transparentView.bounds.origin.y
        rotationAngle = -(90 * (.pi/180))
        categoryPickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        categoryPickerView.frame = CGRect(x: -100, y: y, width: transparentView.frame.width + 200, height: 56)
        
    }
    
    // fetch data based on PickerView selection
    private func fetchData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://www.vesti.ru/vesti.rss") { (rssItems) in
            
            if self.selectedCategory.lowercased() == self.categories[4].lowercased() {
                self.rssItems = rssItems
            } else {
                self.rssItems = rssItems.filter({ return $0.category?.lowercased() == self.selectedCategory.lowercased()})
            }
            
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
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let item = rssItems?[indexPath.item]
        cell.item = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = rssItems?[indexPath.item]
        performSegue(withIdentifier: "ToTheFullNewsVC", sender: item)
    }
    
}

// MARK: - PickerView

extension NewsFeedVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
        fetchData()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 220
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        // customization
        let label = UILabel()
        
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: 220, height: 56)
        label.text = categories[row]
        
        let view = UIView()
        view.addSubview(label)
        view.frame = CGRect(x: 0, y: 0, width: 220, height: 56)
        
        // picker view rotation
        view.transform = CGAffineTransform(rotationAngle: (90 * (.pi/180)))
        
        return view
    }
    
}

