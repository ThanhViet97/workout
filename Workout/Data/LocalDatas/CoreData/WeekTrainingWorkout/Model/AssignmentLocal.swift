//
//  AssignmentLocal+CoreDataProperties.swift
//  Workout
//
//  Created by Viet Phan on 22/10/24.
//
//

import Foundation
import CoreData


@objc(AssignmentLocal)
public class AssignmentLocal: NSManagedObject {

}

extension AssignmentLocal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AssignmentLocal> {
        return NSFetchRequest<AssignmentLocal>(entityName: "AssignmentLocal")
    }

    @NSManaged public var id: String?
    @NSManaged public var status: Int16
    @NSManaged public var title: String?
    @NSManaged public var client: String?
    @NSManaged public var day: String?
    @NSManaged public var date: String?
    @NSManaged public var exercisesCompleted: Int16
    @NSManaged public var exercisesCount: Int16
    @NSManaged public var isWorkouted: Bool
}

extension AssignmentLocal : Identifiable {
    
    static func newUniqueInstance(in context: NSManagedObjectContext,
                                  with assignment: Assignment) throws -> AssignmentLocal {
        let assignmentLocal = AssignmentLocal(context: context)
        assignmentLocal.id = assignment.id
        assignmentLocal.status = Int16(assignment.status.rawValue)
        assignmentLocal.title = assignment.title
        assignmentLocal.client = assignment.client
        assignmentLocal.day = assignment.day
        assignmentLocal.date = assignment.date
        assignmentLocal.exercisesCompleted = Int16(assignment.exercisesCompleted)
        assignmentLocal.exercisesCount = Int16(assignment.exercisesCount)
        
        return assignmentLocal
    }
    
    static func find(assignmentId: String, in context: NSManagedObjectContext) throws -> AssignmentLocal? {
        let request = NSFetchRequest<AssignmentLocal>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "id = %@", assignmentId)
        request.returnsObjectsAsFaults = false
        let listAssignment = try? context.fetch(request)
        return listAssignment?.first
    }
    
    static func changeStatus(assignmentId: String, status: Int16, in context: NSManagedObjectContext) throws {
        do {
            let assignment = try find(assignmentId: assignmentId, in: context)
            
            if let assignment {
                assignment.status = status
                try context.save()
                print("Workout updated successfully.")
            } else {
                print("No workout found with the given id.")
                throw StoreError.updateStatusFail
            }
        } catch {
            print("No workout found with the given id.")
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    var assignment: Assignment {
        return Assignment(id: id ?? "",
                          status: WorkoutStatus(rawValue: Int(status)) ?? .assigned,
                          client: client ?? "",
                          title: title ?? "",
                          day: day ?? "",
                          date: date ?? "",
                          exercisesCompleted: Int(exercisesCompleted),
                          exercisesCount: Int(exercisesCount)
        )
    }
}
