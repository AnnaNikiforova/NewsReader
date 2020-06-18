//
//  NewsCell.swift
//  NewsReader
//
//  Created by Анна Никифорова on 10.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            categoryLabel.text = item.category?.uppercased()
            pubDateLabel.text = DataConverter.formatDate(newsDate: item.pubDate!)
            loadImage(url: item.imageURL!)
        }
    }
    
    func loadImage(url: String) {
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.newsImage.image = imageFromCache
        } else {
            if let imageURL = URL(string: item.imageURL!) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        if let imageToCache = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                                self.newsImage.image = imageToCache
                            }
                        }
                    }
                }
            }
        }
    }
    
}
