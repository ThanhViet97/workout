//
//  WorkoutScheduleResponse.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

struct WorkoutScheduleResponse: Codable {
    let dayData: [WorkoutData]

    enum CodingKeys: String, CodingKey {
        case dayData = "day_data"
    }
}
