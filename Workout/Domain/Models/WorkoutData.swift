//
//  DayData.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

enum WorkoutStatus: Int, Codable {
    case assigned = 0, inProgress, completed
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
    var status: WorkoutStatus
    let client: String
    let title: String
    let day: String
    let date: String
    let exercisesCompleted: Int
    let exercisesCount: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case status
        case client
        case title
        case day
        case date
        case exercisesCompleted = "exercises_completed"
        case exercisesCount = "exercises_count"
    }
        
    mutating func workoutToggle() {
        let currentStatus = status
        status = currentStatus == .completed ? .assigned : .completed
    }
    
    mutating func updateStatus(newValue: WorkoutStatus) {
        status = newValue
    }
}
