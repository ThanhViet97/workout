//
//  AppDelegate.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: MainCoordinator!
    var diService: DI!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkMonitor.shared.startListen()
        APIConfig.setup()
        diService = DI()
        setupAppCoordinator()
        return true
    }
    
    private func setupAppCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = MainCoordinator(window: window)
        appCoordinator.showHome()
    }
}

