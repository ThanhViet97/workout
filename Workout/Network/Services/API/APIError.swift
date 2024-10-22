//
//  APIError.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

class APIError: NSObject, Codable, LocalizedError {
    var objectErrors: [String]

    static let commonError = APIError(errorMessage: Strings.LocalError.commonError)

    init(errorMessage: String) {
        self.objectErrors = [errorMessage]
    }
    
    init(error: Error) {
        if let apiError = error as? APIError {
            self.objectErrors = apiError.objectErrors
        } else {
            self.objectErrors = [error.localizedDescription]
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let optionalContainer = try decoder.container(keyedBy: OptionalCodingKeys.self)
        
        self.objectErrors = (try? container.decodeIfPresent([String].self, forKey: CodingKeys.objectErrors)) ?? []
        
        let errorDetails = try? optionalContainer.decodeIfPresent(String.self, forKey: OptionalCodingKeys.errorDetails)
        if self.objectErrors.isEmpty && errorDetails != nil {
            self.objectErrors = [errorDetails ?? ""]
        }
    }
    
    override var description: String {
        get {
            return self.objectErrors.joined(separator: ", ")
        }
    }
    
    var errorDescription: String? {
        get {
            return self.description
        }
    }
    
    enum OptionalCodingKeys: String, CodingKey {
        case errorDetails
    }
    
    /* Mockup Error JSON key
     {
         "objectErrors": ["Invalid request"],
     }
    */
    enum CodingKeys: String, CodingKey {
        case objectErrors
    }
}
