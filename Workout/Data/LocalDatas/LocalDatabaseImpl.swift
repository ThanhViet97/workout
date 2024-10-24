//
//  LocalDatabaseImpl.swift
//  Workout
//
//  Created by Viet Phan on 23/10/24.
//

import Foundation
import CoreData

class LocalDatabaseImpl: LocalDatabase {
    
    lazy var store: CoreDataStore = {
        do {
            return try CoreDataStoreImpl(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("workout.sqlite"))
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            return NullStore()
        }
    }()
}
