//
//  CoreDataStore.swift
//  Workout
//
//  Created by Viet Phan on 23/10/24.
//

import CoreData

class CoreDataStore {
    func performSync<R>(_ action: (NSManagedObjectContext) -> Result<R, Error>) throws -> R {
        fatalError("Need override")
    }
}
