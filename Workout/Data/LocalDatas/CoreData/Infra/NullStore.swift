//
//  NullStore.swift
//  Workout
//
//  Created by Viet Phan on 23/10/24.
//

import CoreData

class NullStore: CoreDataStore {
    
    override func performSync<R>(_ action: (NSManagedObjectContext) -> Result<R, Error>) throws -> R {
        throw APIError.commonError
    }
}
