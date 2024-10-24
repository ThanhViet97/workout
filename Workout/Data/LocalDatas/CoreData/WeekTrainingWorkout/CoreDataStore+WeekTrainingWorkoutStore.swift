//
//  CoreDataStore+WeekTrainingWorkoutStore.swift
//  Workout
//
//  Created by Viet Phan on 23/10/24.
//

import Foundation

extension CoreDataStore: WeekTrainingWorkoutStore {
    
    func getWeekTrainingWorkout() -> [WeekTrainingData] {
        do {
            return try performSync { context in
                Result {
                    try WeekTrainingDataLocal.findAll(in: context)?.map({ $0 .weekTrainingData }) ?? []
                }
            }
        } catch {
            return []
        }
    }
    
    func saveWeekTrainingWorkout(with weekTrainingData: WeekTrainingData) {
        try? performSync({ context in
            Result {
                try WeekTrainingDataLocal.deleteAllWeekTrainingDataLocal(in: context)
                _ = try? WeekTrainingDataLocal.newUniqueInstance(in: context, with: weekTrainingData)
                try? context.save()
                print("Save Data Success")
            }
        })
    }
    
    func updateAssignmentStatus(assignmentId: String, status: Int) {
        try? performSync({ context in
            Result {
                _ = try? AssignmentLocal.changeStatus(assignmentId: assignmentId, status: Int16(status), in: context)
                print("Change assignmentId: \(assignmentId): Status to \(status) Data Success")
            }
        })
    }
}
