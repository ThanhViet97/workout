//
//  WorkoutUsercaseImpl.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Combine

class WorkoutUsercaseImpl: WorkoutUsercase {

    private let workoutRepository: WorkoutRepository
    private let localFileData: LocalFileData
    
    init(workoutRepository: WorkoutRepository, localFileData: LocalFileData) {
        self.workoutRepository = workoutRepository
        self.localFileData = localFileData
    }
    
    func getWorkouts() -> AnyPublisher<[WorkoutData], APIError> {
        workoutRepository.getWorkouts()
    }
    
    func saveDayOfWeekTrainingDatas(_ dayOfWeekTrainingDatas: [DayOfWeekTrainingData]?) {
        localFileData.save(dayOfWeekTrainingDatas)
    }
    
    func getLocalDayOfWeekTrainingDatas() -> [DayOfWeekTrainingData]? {
        localFileData.getDayOfWeekTrainingDatas()
    }
    
    func removeDayOfWeekTrainingDatasFileName() {
        localFileData.removeDayOfWeekTrainingDatasFileName()
    }
}
