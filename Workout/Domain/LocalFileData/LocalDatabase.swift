//
//  LocalDatabase.swift
//  Workout
//
//  Created by Viet Phan on 23/10/24.
//

import Foundation
import CoreData

protocol LocalDatabase {
    var store: CoreDataStore { get }
}
