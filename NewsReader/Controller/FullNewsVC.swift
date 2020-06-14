//
//  FullNewsVC.swift
//  NewsReader
//
//  Created by Анна Никифорова on 11.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class FullNewsVC: UIViewController {

    var item: RSSItem!
    
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullNewsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.standardAppearance.shadowColor = .clear
        setUI()

    }
    
    func setUI() {
        pubDateLabel.text = DataConverter.formatDate(newsDate: item.pubDate)
        titleLabel.text = item.title
        fullNewsText.text = item.fullText
      
        if let imageURL = URL(string: item.imageURL) {
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
