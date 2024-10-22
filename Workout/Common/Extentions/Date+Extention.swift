//
//  Date+Extention.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

extension TimeZone {
    static let utc = TimeZone(identifier: "GMT") ?? .current
}

enum AppDateFormat: String {
    case severDate = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case localDate = "MM-dd-yyyy"
    case dayOfWeek = "EEE"
    case dayOfMonth = "dd"
}

extension Date {
    
    // Mockup data today to match with data from API
    static var today: Date {
        let todayStr = "2024-05-24T00:00:00.000Z"
        return todayStr.toDate(format: AppDateFormat.severDate.rawValue) ?? Date()
    }
    
    static func fetchCurrentWeek() -> [Date] {
        var currentWeek: [Date] = []
        let today = Date.today
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return []
        }
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
        return currentWeek
    }
    
    func toString(format: String, timezone: TimeZone = .utc) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.timeZone = timezone
        return dateFormat.string(from: self)
    }
}

extension String {
    func toDate(format: String, timezone: TimeZone = .utc) -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.timeZone = timezone
        return dateFormat.date(from: self)
    }
    
    func changeFormatToString(currentFormat: String,
                              toFormat: String,
                              timezone: TimeZone = .utc) -> String? {
        let date = self.toDate(format: currentFormat)
        let dateFormated = date?.toString(format: toFormat)
        return dateFormated
    }
}
