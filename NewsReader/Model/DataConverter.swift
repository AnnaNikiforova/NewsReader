//
//  Helper.swift
//  NewsReader
//
//  Created by Анна Никифорова on 14.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class DataConverter {
    
    static func formatDate(newsDate: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "E, d MMM yyyy HH:mm:ss z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        dateFormatterPrint.dateFormat = "d MMM, HH:mm"
        
        if let date = dateFormatterGet.date(from: newsDate) {
            return dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        return ""
    }
    
}
