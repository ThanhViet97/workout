//
//  WeekTrainingDataLocal+CoreDataProperties.swift
//  Workout
//
//  Created by Viet Phan on 22/10/24.
//
//

import Foundation
import CoreData

@objc(WeekTrainingDataLocal)
public class WeekTrainingDataLocal: NSManagedObject {

}

extension WeekTrainingDataLocal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeekTrainingDataLocal> {
        return NSFetchRequest<WeekTrainingDataLocal>(entityName: "WeekTrainingDataLocal")
    }

    @NSManaged public var dayOfWeekTrainingData: Set<DayOfWeekTrainingDataLocal>?

    public var listdayOfWeekTrainingData: [DayOfWeekTrainingDataLocal]? {
        let dayOfWeekTrainingDataLocal = dayOfWeekTrainingData
        return dayOfWeekTrainingDataLocal?.sorted(by: {
            let firstDay = $0.date?.toDate(format: AppDateFormat.localDate.rawValue) ?? Date()
            let seconDay = $1.date?.toDate(format: AppDateFormat.localDate.rawValue) ?? Date()
            return firstDay < seconDay
        })
    }
}

// MARK: Generated accessors for dayOfWeekTrainingData
extension WeekTrainingDataLocal {

    @objc(addDayOfWeekTrainingDataObject:)
    @NSManaged public func addToDayOfWeekTrainingData(_ value: DayOfWeekTrainingDataLocal)

    @objc(removeDayOfWeekTrainingDataObject:)
    @NSManaged public func removeFromDayOfWeekTrainingData(_ value: DayOfWeekTrainingDataLocal)

    @objc(addDayOfWeekTrainingData:)
    @NSManaged public func addToDayOfWeekTrainingData(_ values: NSSet)

    @objc(removeDayOfWeekTrainingData:)
    @NSManaged public func removeFromDayOfWeekTrainingData(_ values: NSSet)

}

extension WeekTrainingDataLocal {
    
    static func newUniqueInstance(in context: NSManagedObjectContext,
                                  with weekTrainingData: WeekTrainingData) throws -> WeekTrainingDataLocal {
        let weekTrainingDataLocal = WeekTrainingDataLocal(context: context)
        let dayOfWeekTrainingDataLocal: [DayOfWeekTrainingDataLocal] = weekTrainingData.dayOfWeekTrainingData
            .compactMap({ dayOfWeekTrainingData in
            do {
                let dayOfWeekTrainingData = try DayOfWeekTrainingDataLocal.newUniqueInstance(in: context,
                                                                                             with: dayOfWeekTrainingData)
                return dayOfWeekTrainingData
            } catch {
                return nil
            }
        })
        weekTrainingDataLocal.dayOfWeekTrainingData = Set(dayOfWeekTrainingDataLocal)
        return weekTrainingDataLocal
    }
    
    static func findAll(in context: NSManagedObjectContext) throws -> [WeekTrainingDataLocal]? {
        let request = NSFetchRequest<WeekTrainingDataLocal>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try? context.fetch(request)
    }
    
    static func find(weekTrainingDataId: String, in context: NSManagedObjectContext) throws -> WeekTrainingDataLocal? {
        let request = NSFetchRequest<WeekTrainingDataLocal>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "id = %@", weekTrainingDataId)
        request.returnsObjectsAsFaults = false
        return try? context.fetch(request).first
    }
    
    static func deleteAllWeekTrainingDataLocal(in context: NSManagedObjectContext) throws {
        try findAll(in: context)?.forEach({ 
            context.delete($0)
        })
        try context.save()
    }
    
    var weekTrainingData: WeekTrainingData {
        let newDayOfWeekTrainingData = dayOfWeekTrainingData?.compactMap({ dayOfWeekTrainingDataLocal in
            dayOfWeekTrainingDataLocal.dayOfWeekTrainingData
        }).sorted(by: {
            let firstDay = $0.date.toDate(format: AppDateFormat.localDate.rawValue) ?? Date()
            let seconDay = $1.date.toDate(format: AppDateFormat.localDate.rawValue) ?? Date()
            return firstDay < seconDay
        }) ?? []
        return WeekTrainingData(dayOfWeekTrainingData: newDayOfWeekTrainingData)
    }
}
