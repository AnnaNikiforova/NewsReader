//
//  FullNewsVC.swift
//  NewsReader
//
//  Created by Анна Никифорова on 11.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class FullNewsVC: UIViewController {
    
    var item: RSSItem?
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullNewsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.standardAppearance.shadowColor = .clear
        setUI()
    }
    
    func setUI() {
        
        pubDateLabel.text = Helpers.formatDate(newsDate: item!.pubDate!)
        titleLabel.text = item?.title
        fullNewsLabel.text = item?.fullText
        
        guard let imageURL = URL(string: item!.imageURL!) else { return }
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.newsImage.image = image
                }
            }
        }
        task.resume()
    }
    
}
