//
//  WeekTrainingWorkoutStore.swift
//  Workout
//
//  Created by Viet Phan on 23/10/24.
//

import Foundation

protocol WeekTrainingWorkoutStore {
    func getWeekTrainingWorkout() -> [WeekTrainingData]
    func saveWeekTrainingWorkout(with weekTrainingData: WeekTrainingData)
    func updateAssignmentStatus(assignmentId: String, status: Int)
}
