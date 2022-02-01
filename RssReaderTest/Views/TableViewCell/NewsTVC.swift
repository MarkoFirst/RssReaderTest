//
//  NewsTVC.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation
import UIKit

class NewsTVC: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    func setup(_ news: News) {
        titleLabel.text = news.title
        authorLabel.text = news.author
        
        newsImageView.loadImageUsingCache(withUrl: news.urlToImage)
    }
}
