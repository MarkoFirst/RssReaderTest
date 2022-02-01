//
//  String+toDate.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation

extension String {
    func toDate(with format: String, _ ignoreTimeZone: Bool = false) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "uk")
        
        if ignoreTimeZone {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        
        return dateFormatter.date(from: self)
    }
}
