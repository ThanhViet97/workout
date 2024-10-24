//
//  WorkoutDataLocal+CoreDataProperties.swift
//  Workout
//
//  Created by Viet Phan on 22/10/24.
//
//

import Foundation
import CoreData

@objc(WorkoutDataLocal)
public class WorkoutDataLocal: NSManagedObject {

}

extension WorkoutDataLocal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutDataLocal> {
        return NSFetchRequest<WorkoutDataLocal>(entityName: "WorkoutDataLocal")
    }

    @NSManaged public var id: String?
    @NSManaged public var trainer: String?
    @NSManaged public var client: String?
    @NSManaged public var day: String?
    @NSManaged public var date: String?
    @NSManaged public var assignments: Set<AssignmentLocal>?
//    @NSManaged public var trainingData: DayOfWeekTrainingDataLocal?
    
    public var listAssignments: [AssignmentLocal]? {
        let setOfAssignments = assignments
        return setOfAssignments?.sorted(by: {
            let firstDay = $0.day?.toDate(format: AppDateFormat.localDate.rawValue) ?? Date()
            let seconDay = $1.day?.toDate(format: AppDateFormat.localDate.rawValue) ?? Date()
            return firstDay < seconDay
        })
    }
}

// MARK: Generated accessors for assignments
extension WorkoutDataLocal {

    @objc(addAssignmentsObject:)
    @NSManaged public func addToAssignments(_ value: AssignmentLocal)

    @objc(removeAssignmentsObject:)
    @NSManaged public func removeFromAssignments(_ value: AssignmentLocal)

    @objc(addAssignments:)
    @NSManaged public func addToAssignments(_ values: NSSet)

    @objc(removeAssignments:)
    @NSManaged public func removeFromAssignments(_ values: NSSet)

}

extension WorkoutDataLocal : Identifiable {
    static func newUniqueInstance(in context: NSManagedObjectContext,
                                  with workoutData: WorkoutData) throws -> WorkoutDataLocal {
        let workoutDataLocal = WorkoutDataLocal(context: context)
        workoutDataLocal.id = workoutData.id
        workoutDataLocal.trainer = workoutData.trainer
        workoutDataLocal.client = workoutData.client
        workoutDataLocal.day = workoutData.day
        workoutDataLocal.date = workoutData.date
        let assignmentLocal: [AssignmentLocal] = workoutData.assignments.compactMap({ assignmentLocal in
            do {
                let assignmentLocal = try AssignmentLocal.newUniqueInstance(in: context, with: assignmentLocal)
                return assignmentLocal
            } catch {
                return nil
            }
        })
        workoutDataLocal.assignments = Set(assignmentLocal)
        
        return workoutDataLocal
    }
    
    var workoutData: WorkoutData {
        let newAssignments = assignments?.compactMap({ assignmentLocal in
            assignmentLocal.assignment
        }).sorted(by: {
            let firstDay = $0.day.toDate(format: AppDateFormat.localDate.rawValue) ?? Date()
            let seconDay = $1.day.toDate(format: AppDateFormat.localDate.rawValue) ?? Date()
            return firstDay < seconDay
        }) ?? []
        
        return WorkoutData(id: id ?? "",
                           trainer: trainer ?? "",
                           client: client ?? "",
                           day: day ?? "",
                           date: date ?? "",
                           assignments: newAssignments)
    }
}
