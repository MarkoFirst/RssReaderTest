//
//  SourceCVC.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation
import TinyConstraints

class SourceCVC: UICollectionViewCell {
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = Config.pinkColor
        
        titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        
        titleLabel.leadingToSuperview(offset: 12)
        titleLabel.trailingToSuperview(offset: 12)
        titleLabel.bottomToSuperview(offset: -12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
}
