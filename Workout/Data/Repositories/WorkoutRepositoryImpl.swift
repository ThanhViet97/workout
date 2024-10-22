//
//  WorkoutRepositoryImpl.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Combine

class WorkoutRepositoryImpl: WorkoutRepository {
    
    private var apiService: APIServiceType
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
    }
    
    func getWorkouts() -> AnyPublisher<[WorkoutData], APIError> {
        return apiService.request(WorkoutEndpoint.getWorkouts)
            .map({ json in
                let workoutSchedule: WorkoutScheduleResponse? = DecodeUtils.decode(json: json)
                guard let workoutSchedule else { return [] }
                return workoutSchedule.dayData
            })
            .eraseToAnyPublisher()
    }
}
