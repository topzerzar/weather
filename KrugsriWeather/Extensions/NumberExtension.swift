//
//  NumberExtension.swift
//  KrugsriWeather
//
//  Created by weerapon on 18/5/2564 BE.
//

import Foundation

extension NSNumber {
    
    func timestampToDate(format: DateFormat) -> String {
        let date = Date(timeIntervalSince1970: (self.doubleValue))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.string(from: date)
    }
    
    func timestampToDate(format: DateFormat) -> Date {
        let date = Date(timeIntervalSince1970: (self.doubleValue))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.date(from: dateFormatter.string(from: date)) ?? Date()
    }
}
