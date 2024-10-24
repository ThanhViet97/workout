//
//  CoreDataStoreImpl.swift
//  Workout
//
//  Created by Viet Phan on 23/10/24.
//

import CoreData

enum StoreError: Error {
    case modelNotFound
    case failedToLoadPersistentContainer(Error)
    case updateStatusFail
}

final class CoreDataStoreImpl: CoreDataStore {
    
    private static let modelName = "Workout"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataStoreImpl.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    public init(storeURL: URL) throws {
        guard let model = CoreDataStoreImpl.model else {
            throw StoreError.modelNotFound
        }
        do {
            container = try NSPersistentContainer.load(name: CoreDataStoreImpl.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    override func performSync<R>(_ action: (NSManagedObjectContext) -> Result<R, Error>) throws -> R {
        let context = self.context
        var result: Result<R, Error>!
        context.performAndWait { result = action(context) }
        return try result.get()
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
    
    deinit {
        cleanUpReferencesToPersistentStores()
    }
}
