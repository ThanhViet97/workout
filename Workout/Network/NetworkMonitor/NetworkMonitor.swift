//
//  NetworkMonitor.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Network
import Combine

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private init() { }
    
    var networkStatus = CurrentValueSubject<NWPath.Status, Never>(.unsatisfied)
    
    var hasConnection: Bool {
        return networkStatus.value == .satisfied
    }
    
    private let monitor = NWPathMonitor()
    
    func startListen() {
        monitor.pathUpdateHandler = { [weak self] path in
            let status = path.status
            self?.networkStatus.send(status)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
