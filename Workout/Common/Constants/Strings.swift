//
//  Strings.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

enum Strings {
    enum Common {
        static var noNetwork: String { return "common.no.network".localized() }
        static var error: String { return "common.error".localized() }
        static var done: String { return  "common.done".localized() }
    }
    
    enum LocalError {
        static var commonError: String { return "error.common.message".localized() }
    }
    
    enum Workout {
        static var completed: String { return "common.completed".localized() }
        static var inProgress: String { return "common.in.progress".localized() }
        static var missed: String { return "common.missed".localized() }
        static func exercises(_ number: Int) -> String {
            return "common.exercises".localizedPlural(number: number)
        }
    }
}
