//
//  APIConfig.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

class APIConfig {
    static let https = "https://"
    static var baseURL = ""
    
    static func setup() {
        baseURL = https + getAppConfig(key: "baseURL")
    }
    
    static func getAppConfig(key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path) as? [String: Any],
            let appConfigs = values["API_CONFIG"] as? [String: Any],
            let value = appConfigs[key] as? String else {
            fatalError("MISSING CONFIG FOR \(key)")
        }
        return value
    }
}
