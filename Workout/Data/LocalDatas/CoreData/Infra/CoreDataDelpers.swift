//
//  CoreDataDelpers.swift
//  Workout
//
//  Created by Viet Phan on 23/10/24.
//

import CoreData

extension NSPersistentContainer {
    
    static func load(name: String, model: NSManagedObjectModel, url: URL) throws -> NSPersistentContainer {
        let description = NSPersistentStoreDescription(url: url)
        let container = NSPersistentContainer(name: name, managedObjectModel: model)
        container.persistentStoreDescriptions = [description]
        var loadStoreError: Error?
        container.loadPersistentStores(completionHandler: { _, error in
            loadStoreError = error
        })
        if let error = loadStoreError {
            throw error
        }
        return container
    }
}

extension NSManagedObjectModel {
    
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        return bundle
            .url(forResource: name, withExtension: "momd")
            .flatMap({ NSManagedObjectModel(contentsOf: $0) })
    }
}

extension String {
    func convertToUUIDFormat(from id: String) -> String? {
        // Kiểm tra độ dài của id để đảm bảo rằng nó có thể chuyển đổi thành UUID
        guard id.count == 32 else {
            print("ID không đủ 32 ký tự để chuyển đổi thành UUID")
            return nil
        }
        
        // Chèn dấu gạch nối vào các vị trí thích hợp để tạo thành UUID
        let formattedId = "\(id.prefix(8))-\(id.dropFirst(8).prefix(4))-\(id.dropFirst(12).prefix(4))-\(id.dropFirst(16).prefix(4))-\(id.dropFirst(20))"
        
        return formattedId
    }
}
