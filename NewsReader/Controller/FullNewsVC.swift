//
//  FullNewsVC.swift
//  NewsReader
//
//  Created by Анна Никифорова on 11.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class FullNewsVC: UIViewController {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullNewsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.standardAppearance.shadowColor = .clear
    }
  

}
