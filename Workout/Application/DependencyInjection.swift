//
//  DependencyInjection.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Swinject

class DI {

    private let container = Container()
    
    init() {
        registerServices()
        registerRepositories()
        registerLocalFileData()
        registerUsecases()
    }
    
    func registerServices() {
        container.register(APIServiceType.self) { _ in
            return APIService()
        }
        .inObjectScope(.container)
        
        container.register(LocalDatabase.self) { _ in
            return LocalDatabaseImpl()
        }
        .inObjectScope(.container)
    }
    
    func registerRepositories() {
        container.register(WorkoutRepository.self) { resolver in
            let apiService = self.resolve(APIServiceType.self)
            return WorkoutRepositoryImpl(apiService: apiService)
        }
    }
    
    func registerLocalFileData() {
        container.register(LocalFileData.self) { _ in
            return LocalFileDataImpl()
        }
    }
    
    func registerUsecases() {
        container.register(WorkoutUsercase.self) { resolver in
            let workoutRepository = self.resolve(WorkoutRepository.self)
            let localFileData = self.resolve(LocalFileData.self)
            return WorkoutUsercaseImpl(workoutRepository: workoutRepository, localFileData: localFileData)
        }
    }
    

    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = container.resolve(serviceType) else {
            fatalError("‼️ Please register \(Service.self) before use it")
        }
        return service
    }
}
