//
//  WorkoutRepository.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Combine

protocol WorkoutRepository {
    func getWorkouts() -> AnyPublisher<[WorkoutData], APIError>
}
