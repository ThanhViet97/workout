//
//  MainCoordinator.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit

class MainCoordinator {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showHome() {
        let trainingVC = TrainingViewController()
        trainingVC.bind(to: TrainingViewModel(workoutUsercase: resolve(WorkoutUsercase.self), 
                                              localDatabase: resolve(LocalDatabase.self)))
        let roootNavigation = UINavigationController(rootViewController: trainingVC)
        roootNavigation.isNavigationBarHidden = true
        window.makeKeyAndVisible()
        window.rootViewController = roootNavigation
    }
}
