//
//  News.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation
import Unbox

class News: Unboxable {
//    let source: Source
    let author: String
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: Date
    
    required init(unboxer: Unboxer) throws {
//        source      = try unboxer.unbox(key: "source")
        author      = try unboxer.unbox(key: "author")
        title       = try unboxer.unbox(key: "title")
        description = try unboxer.unbox(key: "description")
        url         = try unboxer.unbox(key: "url")
        urlToImage  = try unboxer.unbox(key: "urlToImage")
        
        if let dateStr: String = try? unboxer.unbox(key: "publishedAt"), let date = dateStr.toDate(with: "yyyy-MM-dd'T'HH:mm:ssZ") {
            publishedAt = date
        } else {
            publishedAt = Date(timeIntervalSince1970: 0)
        }
    }
}
