//
//  NewsReaderTests.swift
//  NewsReaderTests
//
//  Created by Анна Никифорова on 23.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import XCTest
@testable import NewsReader

class NewsReaderTests: XCTestCase {
    
    func testDataFormatter() {
        let date = DataConverter.formatDate(newsDate: "Tue, 23 Jun 2020 18:13:00 +0300")
        XCTAssertEqual(date, "23 июня, 18:13")
        
        let dateWithAnError = DataConverter.formatDate(newsDate: "Tue, 23 Jun 2020 18:13:00 +0300   \n")
        XCTAssertEqual(dateWithAnError, "")
    }


}
