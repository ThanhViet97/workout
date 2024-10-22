//
//  WeekTrainingData.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

struct WeekTrainingData: Codable {
    var dayOfWeekTrainingData: [DayOfWeekTrainingData]
}
//
//extension WeekTrainingData {
//    init(from localData: WeekTrainingLocalData) {
//        self.dayOfWeekTrainingData = localData.dayOfWeekTrainingData.map({ DayOfWeekTrainingData(from: $0) })
//    }
//}
