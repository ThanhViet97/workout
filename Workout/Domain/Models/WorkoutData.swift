//
//  DayData.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

enum WorkoutStatus: Int {
    case assign = 0, inProgress, complete
}

struct WorkoutData: Codable {
    let id: String
    let trainer: String
    let client: String
    let day: String
    let date: String
    var assignments: [Assignment]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case assignments
        case trainer
        case client
        case day
        case date
    }
}

struct Assignment: Codable {
    let id: String
    let status: Int
    let client: String
    let title: String
    let day: String
    let date: String
    let exercisesCompleted: Int
    let exercisesCount: Int
    var isWorkouted: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case status
        case client
        case title
        case day
        case date
        case exercisesCompleted = "exercises_completed"
        case exercisesCount = "exercises_count"
        case isWorkouted
    }
        
    mutating func workoutToggle() {
        isWorkouted = !(isWorkouted ?? false)
    }
    
    mutating func updateIsWorkouted(newValue: Bool?) {
        isWorkouted = newValue
    }
    
    func getWorkoutStatus() -> WorkoutStatus {
        return WorkoutStatus(rawValue: status) ?? .assign
    }
}
