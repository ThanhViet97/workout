//
//  String+Localize.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

extension String {
    
    static let stringLoader: StringLoader = {
       return StringLoader()
    }()
    
    func localized() -> String {
        return String.stringLoader.localisedString(forKey: self)
    }
    
    func localized(withArgs: [CVarArg]) -> String {
        return String.stringLoader.localizedString(forKey: self, withArgs: withArgs)
    }
    
    func localizedPlural(number: Int) -> String {
        return String.stringLoader.localisedPlural(forKey: self, number: number)
    }
}
