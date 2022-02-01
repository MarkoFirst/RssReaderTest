//
//  Date+formattedString.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation

extension Date {
    func formattedString(_ format: String, _ ignoreTimeZone: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "uk")
        formatter.dateFormat = format
        
        if ignoreTimeZone {
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        
        return formatter.string(from: self)
    }
}
