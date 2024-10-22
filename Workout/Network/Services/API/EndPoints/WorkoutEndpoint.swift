//
//  WorkoutEndpoint.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Alamofire

enum WorkoutEndpoint {
    case getWorkouts
}

extension WorkoutEndpoint: APIEndpoint {
    var service: String {
        return "/workouts"
    }
    
    var path: String {
        switch self {
        case .getWorkouts:
            return ""
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getWorkouts:
            return .get
        }
    }
    
    var params: Alamofire.Parameters? {
        switch self {
        case .getWorkouts:
            return nil
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        return nil
    }
    
    var encoding: any Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
}
