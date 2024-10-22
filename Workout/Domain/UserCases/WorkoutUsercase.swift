//
//  WorkoutUsercase.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Combine

protocol WorkoutUsercase {
    func getWorkouts() -> AnyPublisher<[WorkoutData], APIError>
    func saveDayOfWeekTrainingDatas(_ dayOfWeekTrainingDatas: [DayOfWeekTrainingData]?)
    func getLocalDayOfWeekTrainingDatas() -> [DayOfWeekTrainingData]?
    func removeDayOfWeekTrainingDatasFileName()
}
