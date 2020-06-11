//
//  NewsCell.swift
//  NewsReader
//
//  Created by Анна Никифорова on 10.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            categoryLabel.text = item.category.uppercased()
            pubDateLabel.text = item.pubDate
            
            // date formatting
//            func formatDate(newsDate: String) -> String {
//                let dateFormatterGet = DateFormatter()
//                // example: Thu, 11 Jun 2020 23:59:00 +0300
//                dateFormatterGet.dateFormat = "E, d MMM yyyy HH:mm:ss z"
//
//                let dateFormatterPrint = DateFormatter()
//                dateFormatterPrint.dateFormat = "MMM d, h:mm a"
//
//                if let date = dateFormatterGet.date(from: item.pubDate) {
//                    return dateFormatterPrint.string(from: date)
//                } else {
//                    print("There was an error decoding the string")
//                }
//                return ""
//            }
//            pubDateLabel.text = formatDate(newsDate: item.pubDate)
            
            // image converting
            if let imageURL = URL(string: item.imagePath) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.newsImage.image = image
                        }
                    }
                }
            }
        }
    }

}
