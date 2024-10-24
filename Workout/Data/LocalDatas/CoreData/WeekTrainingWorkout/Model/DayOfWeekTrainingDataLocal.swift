//
//  DayOfWeekTrainingDataLocal+CoreDataProperties.swift
//  Workout
//
//  Created by Viet Phan on 22/10/24.
//
//

import Foundation
import CoreData

@objc(DayOfWeekTrainingDataLocal)
public class DayOfWeekTrainingDataLocal: NSManagedObject {

}

extension DayOfWeekTrainingDataLocal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayOfWeekTrainingDataLocal> {
        return NSFetchRequest<DayOfWeekTrainingDataLocal>(entityName: "DayOfWeekTrainingDataLocal")
    }

    @NSManaged public var date: String?
    @NSManaged public var trainingData: WorkoutDataLocal?
//    @NSManaged public var dayOfWeekTrainingData: WeekTrainingDataLocal?

}

extension DayOfWeekTrainingDataLocal : Identifiable {
    static func newUniqueInstance(in context: NSManagedObjectContext,
                                  with dayOfWeekTrainingData: DayOfWeekTrainingData) throws -> DayOfWeekTrainingDataLocal {
        let dayOfWeekTrainingDataLocal = DayOfWeekTrainingDataLocal(context: context)
        dayOfWeekTrainingDataLocal.date = dayOfWeekTrainingData.date
        if let trainingData = dayOfWeekTrainingData.trainingData {
            dayOfWeekTrainingDataLocal.trainingData = try WorkoutDataLocal.newUniqueInstance(in: context, with: trainingData)
        }
        return dayOfWeekTrainingDataLocal
    }
    
    static func fetch(in context: NSManagedObjectContext) throws -> [DayOfWeekTrainingDataLocal]? {
        let request = NSFetchRequest<DayOfWeekTrainingDataLocal>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try? context.fetch(request)
    }
    
    var dayOfWeekTrainingData: DayOfWeekTrainingData {
        return DayOfWeekTrainingData(date: date ?? "",
                                     trainingData: trainingData?.workoutData)
    }
}
