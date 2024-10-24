//
//  DayOfWeekTrainingData.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

struct DayOfWeekTrainingData: Codable {
    let date: String
    var trainingData: WorkoutData?
    
    var dateOfWeek: String? {
        return date.changeFormatToString(currentFormat: AppDateFormat.localDate.rawValue,
                                         toFormat: AppDateFormat.dayOfWeek.rawValue)?.uppercased()
    }
    
    var dateOfMonth: String? {
        return date.changeFormatToString(currentFormat: AppDateFormat.localDate.rawValue,
                                         toFormat: AppDateFormat.dayOfMonth.rawValue)
    }
    
    func dateIsToday() -> Bool {
        guard let date = date.toDate(format: AppDateFormat.localDate.rawValue)
        else {
            return false
        }
        return Calendar.current.isDate(Date.today, inSameDayAs: date)
    }
    
    func isWorkoutPastDate() -> Bool {
        guard let date = date.toDate(format: AppDateFormat.localDate.rawValue)
        else {
            return false
        }
        return date < Date.today
    }
    
    func isWorkoutFutureDate() -> Bool {
        guard let date = date.toDate(format: AppDateFormat.localDate.rawValue)
        else {
            return false
        }
        return date > Date.today
    }
}
