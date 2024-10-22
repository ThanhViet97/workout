//
//  APIEndpoint.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Alamofire

protocol APIEndpoint {
    var service: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }

    var fullPath: String { get }
    var isPublic: Bool { get }
}

extension APIEndpoint {
    
    var fullPath: String {
        return APIConfig.baseURL + service + path
    }
    
    var isPublic: Bool {
        return false
    }
}
